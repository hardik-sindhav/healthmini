import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthmini/const/colors.dart';
import 'package:healthmini/models/symptoms_list_model.dart';
import 'package:healthmini/provider/symptoms_list_provider.dart';
import 'package:healthmini/utils/snackbar.dart';
import 'package:healthmini/utils/textstyles.dart';
import 'package:healthmini/widgets/custom_network_image.dart';
import 'package:provider/provider.dart';

class SymptomsTabletView extends StatefulWidget {
  final List<SymptomsListModel>? dataList;
  final List<String>? selectedSymptomsList;

  const SymptomsTabletView(
      {super.key, this.dataList, this.selectedSymptomsList});

  @override
  State<SymptomsTabletView> createState() => _SymptomsTabletViewState();
}

class _SymptomsTabletViewState extends State<SymptomsTabletView> {
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
        const SizedBox(height: 30),
        Text(
          "Your symptoms : ",
          style: AppTextStyles.semiBoldTextStyles(
              fontSize: size / 40, textColor: AppColors.blackColor),
        ),
        const SizedBox(height: 20),
        widget.selectedSymptomsList!.isEmpty
            ? Align(
                alignment: Alignment.center,
                child: Text(
                  "No symptoms please select or enter your symptoms.",
                  style: AppTextStyles.normalTextStyles(
                      fontSize: size / 35, textColor: Colors.black87),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(10),
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
                                margin: const EdgeInsets.only(
                                    bottom: 10, right: 10),
                                padding: EdgeInsets.symmetric(
                                    vertical: size / 300,
                                    horizontal: size / 80),
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
                                            fontSize: size / 50,
                                            textColor: AppColors.whiteColor),
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(
                                        Icons.close_rounded,
                                        color: AppColors.whiteColor,
                                        size: size / 30,
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
                                horizontal: 20, vertical: 5),
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
                                      fontSize: size / 80,
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
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey),
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
                    contentPadding: const EdgeInsets.only(bottom: 1),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "Or Select Symptoms",
                style: AppTextStyles.normalTextStyles(),
              ),
            ),
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
            crossAxisCount: 3, // More columns for tablets
            mainAxisExtent: size / 12,
            crossAxisSpacing: 8,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.only(bottom: 3),
              width: size,
              height: 50,
              decoration: BoxDecoration(
                  color: widget.selectedSymptomsList!
                          .contains(widget.dataList?[index].name)
                      ? AppColors.appColors
                      : AppColors.whiteColor,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
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
                    Expanded(
                      child: Text(
                        widget.dataList?[index].name ?? "",
                        style:
                            AppTextStyles.mediumTextStyles(fontSize: size / 40),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    widget.selectedSymptomsList!
                            .contains(widget.dataList?[index].name)
                        ? const Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            color: Colors.white,
                          )
                        : Container(),
                    SizedBox(width: 5),
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
        showCustomSnackbar(
            context, "Symptom added successfully", MessageType.success);
        setState(() {
          textEditingController?.clear();
        });
      } else {
        showCustomSnackbar(
            context, "Symptom already added!", MessageType.warning);
      }
    }
  }
}
