// ignore_for_file: avoid_types_as_parameter_names, library_private_types_in_public_api
import 'package:healthmini/utils/general_imports.dart';
import 'package:intl/intl.dart';

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
  String _selectedGender = 'all';
  RangeValues _selectedAgeRange = const RangeValues(0, 100);

  List<Map<String, dynamic>> get _sortedCases {
    List<Map<String, dynamic>> sortedCases = List.from(widget.cases);

    // Filter by gender
    if (_selectedGender != 'all') {
      sortedCases = sortedCases
          .where((caseEntry) => caseEntry['gender'] == _selectedGender)
          .toList();
    }

    // Filter by age range
    sortedCases = sortedCases.where((caseEntry) {
      String ageStr = caseEntry['age'] ?? '0';
      int age = int.tryParse(ageStr) ?? 0;
      return age >= _selectedAgeRange.start && age <= _selectedAgeRange.end;
    }).toList();

    // Sort by case date
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
    Map<String, int> genderCounts = {'Male': 0, 'Female': 0, 'Other': 0};
    Map<String, String> ageCounts = {};

// Example: Iterate through your sorted cases
    for (var caseEntry in _sortedCases) {
      // Count Symptoms
      List<String> symptoms = List<String>.from(caseEntry['symptoms']);
      for (var symptom in symptoms) {
        symptomCounts[symptom] = (symptomCounts[symptom] ?? 0) + 1;
      }

      // Count Genders
      String gender = caseEntry['gender'] ?? 'Other';
      if (genderCounts.containsKey(gender)) {
        genderCounts[gender] = (genderCounts[gender] ?? 0) + 1;
      }

      // Count Ages
      String ageStr = caseEntry['age'] ?? '0';
      int age = int.tryParse(ageStr) ?? 0;
      String ageGroup = '${(age ~/ 10) * 10}-${(age ~/ 10) * 10 + 9}';

      int currentCount = int.tryParse(ageCounts[ageGroup] ?? '0') ?? 0;

      ageCounts[ageGroup] = (currentCount + 1).toString();
    }

    List<MapEntry<String, int>> sortedSymptomCounts =
        symptomCounts.entries.toList();
    sortedSymptomCounts.sort((a, b) => _sortOrder != 'desc'
        ? b.value.compareTo(a.value)
        : a.value.compareTo(b.value));

    double size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('All Cases in ${widget.city}',
            style: AppTextStyles.mediumTextStyles(fontSize: 22)),
        actions: [
          Text(
            "Total Cases : ${_sortedCases.length}",
            style: AppTextStyles.mediumTextStyles(fontSize: 14),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: ListView(
        children: [
          _buildFilters(),
          _sortedCases.isEmpty
              ? Container()
              : size <= 700
                  ? Column(
                      children: [
                        _buildSymptomCountTable(sortedSymptomCounts),
                        const SizedBox(height: 20),
                        _buildGenderChart(genderCounts),
                        const SizedBox(height: 20),
                        _buildAgeChart(ageCounts),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                            child:
                                _buildSymptomCountTable(sortedSymptomCounts)),
                        const SizedBox(width: 20),
                        Expanded(child: _buildGenderChart(genderCounts)),
                        const SizedBox(width: 20),
                        Expanded(child: _buildAgeChart(ageCounts)),
                      ],
                    ),
          _sortedCases.isEmpty
              ? Center(
                  child: Text(
                    "No data found !",
                    style: AppTextStyles.mediumTextStyles(fontSize: 20),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _sortedCases.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemBuilder: (context, index) {
                    var caseEntry = _sortedCases[index];
                    List<String> symptoms =
                        List<String>.from(caseEntry['symptoms']);
                    DateTime caseDate =
                        (caseEntry['timestamp'] as Timestamp).toDate();

                    String patientAge = (caseEntry['age'].toString());
                    String patientGender = (caseEntry['gender'].toString());

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
                                  text: 'Patient Age : ',
                                  style: AppTextStyles.semiBoldTextStyles(
                                      fontSize: 14),
                                ),
                                TextSpan(
                                  text: patientAge,
                                  style: AppTextStyles.mediumTextStyles(
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Patient Gender : ',
                                  style: AppTextStyles.semiBoldTextStyles(
                                      fontSize: 14),
                                ),
                                TextSpan(
                                  text: patientGender,
                                  style: AppTextStyles.mediumTextStyles(
                                      fontSize: 14),
                                ),
                              ],
                            ),
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
                                  style: AppTextStyles.mediumTextStyles(
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Symptoms :',
                              style: AppTextStyles.semiBoldTextStyles(
                                  fontSize: 14)),
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
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
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
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterChip(
                  label: Text('All Genders',
                      style: AppTextStyles.semiBoldTextStyles(fontSize: 14)),
                  selected: _selectedGender == 'all',
                  onSelected: (selected) {
                    setState(() {
                      _selectedGender = 'all';
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text('Male',
                      style: AppTextStyles.semiBoldTextStyles(fontSize: 14)),
                  selected: _selectedGender == 'Male',
                  onSelected: (selected) {
                    setState(() {
                      _selectedGender = selected ? 'Male' : 'all';
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text('Female',
                      style: AppTextStyles.semiBoldTextStyles(fontSize: 14)),
                  selected: _selectedGender == 'Female',
                  onSelected: (selected) {
                    setState(() {
                      _selectedGender = selected ? 'Female' : 'all';
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text('Other',
                      style: AppTextStyles.semiBoldTextStyles(fontSize: 14)),
                  selected: _selectedGender == 'Other',
                  onSelected: (selected) {
                    setState(() {
                      _selectedGender = selected ? 'Other' : 'all';
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Age Range:',
                style: AppTextStyles.semiBoldTextStyles(fontSize: 14),
              ),
              Expanded(
                child: RangeSlider(
                  values: _selectedAgeRange,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  labels: RangeLabels(
                    '${_selectedAgeRange.start.round()}',
                    '${_selectedAgeRange.end.round()}',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _selectedAgeRange = values;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
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
                      const Spacer(),
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

  Widget _buildAgeChart(Map<String, String> ageCounts) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Age Distribution',
            style: AppTextStyles.semiBoldTextStyles(fontSize: 16),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: _buildAgeChartSections(ageCounts),
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForAgeRange(String ageRange, List<String> sortedAgeRanges) {
    // Define a list of colors to use
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      Colors.teal,
      Colors.amber,
      Colors.lime,
      Colors.indigo,
      Colors.brown,
      Colors.pink,
    ];

    int index = sortedAgeRanges.indexOf(ageRange.trim());

    return colors[index % colors.length];
  }

  List<PieChartSectionData> _buildAgeChartSections(
      Map<String, String> ageCounts) {
    final sortedAgeRanges = ageCounts.keys.toList()..sort();

    final total = ageCounts.values.fold<int>(0, (sum, count) {
      final value = int.tryParse(count) ?? 0;
      return sum + value;
    });

    return ageCounts.entries.map((entry) {
      final value = int.tryParse(entry.value) ?? 0;
      final percentage =
          total > 0 ? (value / total * 100).toStringAsFixed(1) : '0.0';

      return PieChartSectionData(
        color: _getColorForAgeRange(entry.key, sortedAgeRanges),
        value: value.toDouble(),
        title: '${entry.key}\n$percentage%\n(${entry.value} cases)',
        radius: 60,
        titleStyle: AppTextStyles.mediumTextStyles(
            fontSize: 12, textColor: Colors.white),
      );
    }).toList();
  }

  Widget _buildGenderChart(Map<String, int> genderCounts) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender Distribution',
            style: AppTextStyles.semiBoldTextStyles(fontSize: 16),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: _buildGenderChartSections(genderCounts),
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildGenderChartSections(
      Map<String, int> genderCounts) {
    final total = genderCounts.values.fold(0, (sum, count) => sum + count);

    return genderCounts.entries.map((entry) {
      final value = entry.value.toDouble();
      final percentage =
          total > 0 ? (value / total * 100).toStringAsFixed(1) : '0.0';

      return PieChartSectionData(
        color: _getColorForGender(entry.key),
        value: value,
        title: '${entry.key}\n$percentage%\n(${entry.value} cases)',
        radius: 60,
        titleStyle: AppTextStyles.mediumTextStyles(
            fontSize: 12, textColor: Colors.white),
      );
    }).toList();
  }

  Color _getColorForGender(String gender) {
    switch (gender) {
      case 'Male':
        return Colors.blue;
      case 'Female':
        return Colors.pink;
      case 'Other':
        return Colors.purple;
      default:
        return Colors.grey;
    }
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
