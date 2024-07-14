import 'package:flutter/material.dart';
import 'package:healthmini/const/colors.dart';

class SymptomsMobileView extends StatelessWidget {
  const SymptomsMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        SizedBox(height: 20,),
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shadowColor: AppColors.appColors,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: size,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.appColors.withOpacity(0.2),
            ),
          ),
        ),
        Text(data)
      ],
    );
  }
}
