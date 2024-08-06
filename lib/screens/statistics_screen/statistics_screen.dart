// ignore_for_file: avoid_types_as_parameter_names, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthmini/const/colors.dart';
import 'package:healthmini/utils/textstyles.dart';
import 'package:intl/intl.dart';

enum TimeRange { last24Hours, last7Days, lastMonth, allTime }

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  TimeRange _selectedRange = TimeRange.allTime;
  Map<String, Map<String, Map<String, List<Map<String, dynamic>>>>> _data = {};
  bool _isLoading = true;
  final String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchAndProcessData();
  }

  Future<void> _fetchAndProcessData() async {
    List<Map<String, dynamic>> rawData = await fetchData();
    Map<String, Map<String, Map<String, List<Map<String, dynamic>>>>>
        processedData = processData(rawData, getStartDate(_selectedRange));
    setState(() {
      _data = processedData;
      _isLoading = false;
    });
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('query_data').get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Map<String, Map<String, Map<String, List<Map<String, dynamic>>>>> processData(
      List<Map<String, dynamic>> data, DateTime startDate) {
    Map<String, Map<String, Map<String, List<Map<String, dynamic>>>>>
        countryStateCityCaseMap = {};

    for (var entry in data) {
      DateTime timestamp = entry['timestamp'].toDate();
      if (timestamp.isAfter(startDate)) {
        String country = entry['country'];
        String state = entry['state'];
        String city = entry['city'];

        countryStateCityCaseMap[country] ??= {};
        countryStateCityCaseMap[country]![state] ??= {};
        countryStateCityCaseMap[country]![state]![city] ??= [];
        countryStateCityCaseMap[country]![state]![city]!.add(entry);
      }
    }

    return countryStateCityCaseMap;
  }

  DateTime getStartDate(TimeRange range) {
    DateTime now = DateTime.now();
    switch (range) {
      case TimeRange.last24Hours:
        return now.subtract(const Duration(hours: 24));
      case TimeRange.last7Days:
        return now.subtract(const Duration(days: 7));
      case TimeRange.lastMonth:
        return DateTime(now.year, now.month - 1, now.day);
      case TimeRange.allTime:
      default:
        return DateTime(2000);
    }
  }

  void _onRangeChanged(TimeRange range) {
    setState(() {
      _selectedRange = range;
      _isLoading = true;
    });
    _fetchAndProcessData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics',
            style: AppTextStyles.mediumTextStyles(fontSize: 22)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildCountryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...[
              TimeRange.allTime,
              TimeRange.last24Hours,
              TimeRange.last7Days,
              TimeRange.lastMonth,
            ].map((range) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(_rangeToString(range),
                      style: AppTextStyles.semiBoldTextStyles(fontSize: 16)),
                  selected: _selectedRange == range,
                  onSelected: (selected) {
                    if (selected) _onRangeChanged(range);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _rangeToString(TimeRange range) {
    switch (range) {
      case TimeRange.last24Hours:
        return 'Last 24 Hours';
      case TimeRange.last7Days:
        return 'Last 7 Days';
      case TimeRange.lastMonth:
        return 'Last Month';
      case TimeRange.allTime:
      default:
        return 'All Time';
    }
  }

  Widget _buildCountryList() {
    return ListView(
      children: _data.entries.where((countryEntry) {
        String country = countryEntry.key.toLowerCase();
        return country.contains(_searchQuery);
      }).map((countryEntry) {
        String country = countryEntry.key;
        Map<String, Map<String, List<Map<String, dynamic>>>> states =
            countryEntry.value;
        int totalCases = states.values.fold(
            0,
            (sum, cityMap) =>
                sum +
                cityMap.values.fold(0, (sum, cases) => sum + cases.length));

        return ExpansionTile(
          title: Text('$country - $totalCases cases',
              style: AppTextStyles.mediumTextStyles(fontSize: 16)),
          children: states.entries.where((stateEntry) {
            String state = stateEntry.key.toLowerCase();
            return state.contains(_searchQuery);
          }).map((stateEntry) {
            String state = stateEntry.key;
            Map<String, List<Map<String, dynamic>>> cities = stateEntry.value;
            int stateCases =
                cities.values.fold(0, (sum, cases) => sum + cases.length);

            return ExpansionTile(
              title: Text('$state - $stateCases cases',
                  style: AppTextStyles.mediumTextStyles(fontSize: 16)),
              children: cities.entries.where((cityEntry) {
                String city = cityEntry.key.toLowerCase();
                return city.contains(_searchQuery);
              }).map((cityEntry) {
                String city = cityEntry.key;
                List<Map<String, dynamic>> cases = cityEntry.value;
                int cityCases = cases.length;

                return ListTile(
                  title: Text('$city - $cityCases cases',
                      style: AppTextStyles.mediumTextStyles(fontSize: 16)),
                  trailing: InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AllCasesScreen(city: city, cases: cases))),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        'View All Details',
                        style: AppTextStyles.mediumTextStyles(fontSize: 14),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

class AllCasesScreen extends StatefulWidget {
  final String city;
  final List<Map<String, dynamic>> cases;

  const AllCasesScreen({super.key, required this.city, required this.cases});

  @override
  _AllCasesScreenState createState() => _AllCasesScreenState();
}

class _AllCasesScreenState extends State<AllCasesScreen> {
  String _sortOrder = 'asc';
  String _caseFilter = 'all';

  List<Map<String, dynamic>> get _sortedCases {
    List<Map<String, dynamic>> sortedCases = List.from(widget.cases);

    if (_caseFilter == 'newest') {
      sortedCases.sort((a, b) =>
          (b['timestamp'] as Timestamp).compareTo(a['timestamp'] as Timestamp));
    } else if (_caseFilter == 'oldest') {
      sortedCases.sort((a, b) =>
          (a['timestamp'] as Timestamp).compareTo(b['timestamp'] as Timestamp));
    }

    return sortedCases;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> symptomCounts = {};
    for (var caseEntry in _sortedCases) {
      List<String> symptoms = List<String>.from(caseEntry['symptoms']);
      for (var symptom in symptoms) {
        symptomCounts[symptom] = (symptomCounts[symptom] ?? 0) + 1;
      }
    }

    List<MapEntry<String, int>> sortedSymptomCounts =
        symptomCounts.entries.toList();
    sortedSymptomCounts.sort((a, b) => _sortOrder != 'desc'
        ? b.value.compareTo(a.value)
        : a.value.compareTo(b.value));

    return Scaffold(
      appBar: AppBar(
        title: Text('All Cases in ${widget.city}',
            style: AppTextStyles.mediumTextStyles(fontSize: 22)),
      ),
      body: ListView(
        children: [
          _buildFilters(),
          _buildSymptomCountTable(sortedSymptomCounts),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _sortedCases.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) {
                var caseEntry = _sortedCases[index];
                List<String> symptoms =
                    List<String>.from(caseEntry['symptoms']);
                DateTime caseDate =
                    (caseEntry['timestamp'] as Timestamp).toDate();

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Case ${index + 1}',
                        style: AppTextStyles.mediumTextStyles(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Case Date : ',
                              style: AppTextStyles.semiBoldTextStyles(
                                  fontSize: 14),
                            ),
                            TextSpan(
                              text: _formatDate(caseDate),
                              style:
                                  AppTextStyles.mediumTextStyles(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Symptoms :',
                          style:
                              AppTextStyles.semiBoldTextStyles(fontSize: 14)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: symptoms.map((symptom) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              symptom,
                              style: AppTextStyles.mediumTextStyles(
                                fontSize: 12,
                                textColor: AppColors.blackColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterChip(
                  label: Text('All Cases',
                      style: AppTextStyles.semiBoldTextStyles(fontSize: 14)),
                  selected: _caseFilter == 'all',
                  onSelected: (selected) {
                    setState(() {
                      _caseFilter = 'all';
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text('Newest',
                      style: AppTextStyles.semiBoldTextStyles(fontSize: 14)),
                  selected: _caseFilter == 'newest',
                  onSelected: (selected) {
                    setState(() {
                      _caseFilter = selected ? 'newest' : 'all';
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text('Oldest',
                      style: AppTextStyles.semiBoldTextStyles(fontSize: 14)),
                  selected: _caseFilter == 'oldest',
                  onSelected: (selected) {
                    setState(() {
                      _caseFilter = selected ? 'oldest' : 'all';
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildSymptomCountTable(
      List<MapEntry<String, int>> sortedSymptomCounts) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultColumnWidth: const FixedColumnWidth(150.0),
          border: TableBorder.all(color: Colors.grey, width: 1.0),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Symptom',
                      style: AppTextStyles.semiBoldTextStyles(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Count',
                          style:
                              AppTextStyles.semiBoldTextStyles(fontSize: 16)),
                      Spacer(),
                      Row(
                        children: [
                          InkWell(
                            hoverColor: Colors.transparent,
                            child: Icon(
                              size: 18,
                              Icons.arrow_upward,
                              color: _sortOrder == 'asc'
                                  ? AppColors.appColors
                                  : Colors.black,
                            ),
                            onTap: () {
                              setState(() {
                                _sortOrder = 'asc';
                              });
                            },
                          ),
                          InkWell(
                            hoverColor: Colors.transparent,
                            child: Icon(
                              size: 18,
                              Icons.arrow_downward,
                              color: _sortOrder == 'desc'
                                  ? AppColors.appColors
                                  : Colors.black,
                            ),
                            onTap: () {
                              setState(() {
                                _sortOrder = 'desc';
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ...sortedSymptomCounts.map((entry) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(entry.key,
                        style: AppTextStyles.mediumTextStyles(fontSize: 14)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(entry.value.toString(),
                        style: AppTextStyles.mediumTextStyles(fontSize: 14)),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays >= 1) {
      return DateFormat('d MMMM yyyy').format(date);
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
