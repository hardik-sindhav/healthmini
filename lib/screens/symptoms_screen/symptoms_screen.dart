import 'package:healthmini/utils/general_imports.dart';

class SymptomsScreen extends StatefulWidget {
  const SymptomsScreen({super.key});

  @override
  State<SymptomsScreen> createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(microseconds: 100),
      () => Provider.of<SymptomsListProvider>(context, listen: false)
          .getSymptomsList(),
    );
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Find Disease',
              style: AppTextStyles.mediumTextStyles(fontSize: 22)),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Consumer<SymptomsListProvider>(
              builder: (context, symptomsListProvider, child) {
            switch (symptomsListProvider.symptomsListState) {
              case SymptomsListState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case SymptomsListState.loaded:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (screenWidth <= 650) {
                        return SymptomsMobileView(
                            dataList: symptomsListProvider.symptomsList,
                            selectedSymptomsList:
                                symptomsListProvider.selectedSymptomsList);
                      } else if (screenWidth > 650 && screenWidth <= 1024) {
                        return SymptomsTabletView(
                            dataList: symptomsListProvider.symptomsList,
                            selectedSymptomsList:
                                symptomsListProvider.selectedSymptomsList);
                      } else {
                        return SymptomsDesktopView(
                            dataList: symptomsListProvider.symptomsList,
                            selectedSymptomsList:
                                symptomsListProvider.selectedSymptomsList);
                      }
                    },
                  ),
                );
              case SymptomsListState.error:
                return const Text("Error");
              default:
                return const Center(child: Text('Welcome'));
            }
          }),
        ));
  }
}
