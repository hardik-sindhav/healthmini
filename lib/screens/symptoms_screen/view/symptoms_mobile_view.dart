import 'package:flutter/cupertino.dart';
import 'package:healthmini/models/symptoms_list_model.dart';
import 'package:healthmini/utils/general_imports.dart';

class SymptomsMobileView extends StatefulWidget {
  final List<SymptomsListModel>? dataList;
  final List<String>? selectedSymptomsList;
  const SymptomsMobileView(
      {super.key, this.dataList, this.selectedSymptomsList});

  @override
  State<SymptomsMobileView> createState() => _SymptomsMobileViewState();
}

class _SymptomsMobileViewState extends State<SymptomsMobileView> {
  TextEditingController? textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Text(
          "Your symptoms : ",
          style: AppTextStyles.semiBoldTextStyles(
              fontSize: size / 25, textColor: AppColors.blackColor),
        ),
        const SizedBox(
          height: 10,
        ),
        widget.selectedSymptomsList!.isEmpty
            ? Align(
                alignment: Alignment.center,
                child: Text(
                  "No symptoms please select or enter your symptoms.",
                  style: AppTextStyles.normalTextStyles(
                      fontSize: size / 30, textColor: Colors.black87),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: List.generate(
                          widget.selectedSymptomsList!.length,
                          (index) => Container(
                                margin:
                                    const EdgeInsets.only(bottom: 5, right: 5),
                                padding: EdgeInsets.symmetric(
                                    vertical: size / 100,
                                    horizontal: size / 40),
                                decoration: BoxDecoration(
                                    color: AppColors.appColors,
                                    borderRadius: BorderRadius.circular(100)),
                                child: InkWell(
                                  onTap: () =>
                                      Provider.of<SymptomsListProvider>(context,
                                              listen: false)
                                          .removeSymptoms(index),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        widget.selectedSymptomsList?[index] ??
                                            "",
                                        style: AppTextStyles.semiBoldTextStyles(
                                            fontSize: size / 35,
                                            textColor: AppColors.whiteColor),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.close_rounded,
                                        color: AppColors.whiteColor,
                                        size: size / 26,
                                      )
                                    ],
                                  ),
                                ),
                              )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            if (widget.selectedSymptomsList!.length > 1) {
                              Navigator.pushNamed(context, '/details_page');
                            } else {
                              showCustomSnackbar(
                                  context,
                                  "Pls select 2 - 4 symptoms to get good result.",
                                  MessageType.warning);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Next",
                                  style: AppTextStyles.semiBoldTextStyles(
                                      fontSize: size / 35,
                                      textColor: AppColors.whiteColor),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  cursorColor: AppColors.appColors,
                  onSubmitted: (value) => addSymptoms(),
                  onEditingComplete: () => addSymptoms(),
                  style: AppTextStyles.mediumTextStyles(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 2),
                    hintText: "Enter your symptoms",
                    hintStyle: AppTextStyles.mediumTextStyles(fontSize: 14),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => addSymptoms(),
                icon: const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Or Select Symptoms",
                  style: AppTextStyles.normalTextStyles(),
                )),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.dataList?.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: size / 8,
              crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.only(bottom: 10),
              width: size,
              height: 60,
              decoration: BoxDecoration(
                  color: widget.selectedSymptomsList!
                          .contains(widget.dataList?[index].name)
                      ? AppColors.appColors
                      : AppColors.whiteColor,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4)),
              child: InkWell(
                onTap: () =>
                    Provider.of<SymptomsListProvider>(context, listen: false)
                        .selectedSymptoms(widget.dataList?[index].name ?? ""),
                child: Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: widget.dataList?[index].image ?? "",
                      height: size / 14,
                      width: size / 14,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.dataList?[index].name ?? "",
                        style:
                            AppTextStyles.mediumTextStyles(fontSize: size / 30),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    widget.selectedSymptomsList!
                            .contains(widget.dataList?[index].name)
                        ? const Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            color: Colors.white,
                          )
                        : Container()
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void addSymptoms() {
    String? trimmedValue = textEditingController?.text.trim();
    if (trimmedValue!.isNotEmpty) {
      bool value = Provider.of<SymptomsListProvider>(context, listen: false)
          .enterSymptoms(trimmedValue);
      if (value == true) {
        // showCustomSnackbar(
        //     context, "Symptom added successfully", MessageType.success);
        setState(() {
          textEditingController?.clear();
        });
      } else {
        showCustomSnackbar(
            context, "Symptom already added !", MessageType.warning);
      }
    }
  }
}
