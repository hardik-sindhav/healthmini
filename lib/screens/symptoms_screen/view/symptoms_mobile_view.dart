import 'package:flutter/material.dart';
import 'package:healthmini/const/colors.dart';
import 'package:healthmini/models/symptoms_list_model.dart';
import 'package:healthmini/utils/textstyles.dart';

class SymptomsMobileView extends StatelessWidget {
  final List<SymptomsListModel>? dataList;
  const SymptomsMobileView({super.key, this.dataList});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        SizedBox(
          height: 20,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: dataList?.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: size/8, crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              margin: EdgeInsets.only(bottom: 10),
              width: size,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                children: [
                  Image.network(
                    dataList?[index].image ?? "",
                    height: size/14,
                    width: size/14,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    dataList?[index].name ?? "",
                    style: AppTextStyles.mediumTextStyles(fontSize: 18),
                  )
                ],
              ),
            );
          },
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Or Enter Manual",
                  style: AppTextStyles.normalTextStyles(),
                )),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    );
  }
}
