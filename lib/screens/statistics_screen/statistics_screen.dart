// ignore_for_file: avoid_types_as_parameter_names, library_private_types_in_public_api
import 'package:healthmini/utils/general_imports.dart';

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
      padding: const EdgeInsets.all(6.0),
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
