import 'package:flutter/cupertino.dart';
import 'package:healthmini/utils/general_imports.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        fetchData();
      },
    );
  }

  void fetchData() {
    Provider.of<SymptomsListProvider>(context, listen: false)
        .sendSymptoms(context: context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Details',
              style: AppTextStyles.mediumTextStyles(fontSize: 22)),
        ),
        body: Consumer<SymptomsListProvider>(
            builder: (context, detailsProvider, child) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: detailsProvider.findSymptomsState ==
                      FindSymptomsState.loading
                  ? Center(
                      child: Lottie.asset("assets/lottie/loader.json",
                          frameRate: FrameRate.max,
                          repeat: true,
                          height: screenWidth <= 650
                              ? screenWidth / 4
                              : screenWidth > 650 && screenWidth <= 1024
                                  ? screenWidth / 6
                                  : screenWidth / 8),
                    )
                  : detailsProvider.detailsList.isNotEmpty
                      ? LayoutBuilder(
                          builder: (context, constraints) {
                            if (screenWidth <= 650) {
                              return DetailsMobileView(
                                detailsList: detailsProvider.detailsList,
                              );
                            } else if (screenWidth > 650 &&
                                screenWidth <= 1024) {
                              return DetailsMobileView(
                                detailsList: detailsProvider.detailsList,
                              );
                            } else {
                              return DetailsMobileView(
                                detailsList: detailsProvider.detailsList,
                              );
                            }
                          },
                        )
                      : Center(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              detailsProvider.message != ''
                                  ? detailsProvider.message
                                  : "No Details Found ! \nPlease Visit you near hospital.",
                              style:
                                  AppTextStyles.mediumTextStyles(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 150,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(2)),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.back),
                                    Text(
                                      "Go back",
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )));
        }));
  }
}
