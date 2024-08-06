import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthmini/const/colors.dart';
import 'package:healthmini/provider/exercise_provider.dart';
import 'package:healthmini/provider/recipe_provider.dart';
import 'package:healthmini/utils/textstyles.dart';
import 'package:healthmini/widgets/network_image.dart';
import 'package:healthmini/widgets/shimmer_effect.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        HomeBanner(size: size),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Consumer<ExerciseListProvider>(
                      builder: (context, value, child) {
                        if (value.exerciseState == ExerciseState.loading) {
                          return const LoadingCard();
                        } else if (value.exerciseState == ExerciseState.error) {
                          return const ErrorCard(label: 'Exercise');
                        } else {
                          return InfoCard(
                            imageUrl: value.pexelsModel?.photos != null
                                ? value.pexelsModel!.photos![0].src?.portrait ?? ''
                                : '',
                            title: value.exerciseList.isNotEmpty
                                ? value.exerciseList[0].data?.exerciseName ?? ""
                                : "",
                            label: 'Exercise',
                            iconData: Icons.directions_run_rounded,
                          );
                        }
                      }),
                 ButtonCard(
                            imageUrl: "assets/svg/statistics_icon.svg",
                            label: 'Analysis',
                            iconData: Icons.assessment_outlined,
                            isCard: true,
                            title: '',
                            hideTitle: true,
                          ),
                    ]
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Consumer<RecipeListProvider>(
                      builder: (context, value, child) {
                        if (value.recipeState == RecipeState.loading) {
                          return const LoadingCard();
                        } else if (value.recipeState == RecipeState.error) {
                          return const ErrorCard(label: 'Recipe');
                        } else {
                          return InfoCard(
                            imageUrl: value.pexelsModel?.photos != null
                                ? value.pexelsModel!.photos![0].src?.portrait ?? ''
                                : '',
                            title: value.recipeList.isNotEmpty
                                ? value.recipeList[0].data?.recipeName ?? ""
                                : "",
                            label: 'Recipe',
                          );
                        }
                      }),
                   ButtonCard(
                    isCard: true,
                    label: 'Ai Assistant',
                    title: '',
                    hideTitle: true,
                    iconData: Icons.smart_toy_outlined,
                    onTab: () => Navigator.pushNamed(context, '/chat'),
                                     ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(top: 20),
      height: 250,
      width: size / 1.1,
      decoration: BoxDecoration(
        color: AppColors.appColors.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: -size / 15,
            left: -10,
            child: Lottie.asset('assets/lottie/ani_3.json', height: size / 2),
          ),
          Positioned(
            top: 50,
            right: 15,
            left: size / 2.1,
            child: Text(
                "Find your disease with just select or enter your symptoms we recommend you best hospital",
                textAlign: TextAlign.left,
                style: AppTextStyles.mediumTextStyles(fontSize: 15)),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: Container(
              height: 40,
              width: size / 2.5,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                "Try Free",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.health_and_safety, size: 15),
                  SizedBox(width: 5),
                  Text("Health"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    this.imageUrl,
    this.title,
    this.label,
    this.iconData,
  });

  final String? imageUrl;
  final String? title, label;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(top: 20),
      height: 220,
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          NetworkImages(imageUrl: imageUrl, fit: BoxFit.cover),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.60),
                    Colors.black.withOpacity(0.80),
                  ],
                ),
              ),
              child: SizedBox(
                height: 20,
                child: title != null && title!.length < 20
                    ? Text(
                  title ?? "",
                  style: AppTextStyles.mediumTextStyles(
                      textColor: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                )
                    : Marquee(
                  text: title ?? "No Data!",
                  style: AppTextStyles.mediumTextStyles(
                      textColor: Colors.white, fontSize: 14),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  startPadding: 0,
                  pauseAfterRound: const Duration(seconds: 2),
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Row(
                children: [
                  Icon(iconData ?? Icons.fastfood_outlined, size: 15),
                  const SizedBox(width: 5),
                  Text(
                    label ?? "",
                    style: AppTextStyles.mediumTextStyles(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    super.key,
    this.imageUrl,
    this.title,
    this.label,
    this.iconData,
    this.isCard,
    this.hideTitle, this.onTab,
  });

  final String? imageUrl;
  final String? title, label;
  final IconData? iconData;
  final bool? isCard, hideTitle;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Container(
      height: 220,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 10,
            left: 15,
            child: SvgPicture.asset(imageUrl??'assets/svg/health_icon.svg', height: size / 8),
          ),
          Positioned(
            top: 25,
            right: 15,
            left: size / 6,
            child: Text(
                title??"",
                textAlign: TextAlign.left,
                style: AppTextStyles.mediumTextStyles(fontSize: size/65)),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: InkWell(
              onTap: onTab,
              child: Container(
                height: size/15,
                width: size / 6,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                decoration:  BoxDecoration(
                  color: AppColors.appColors,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  "Try Free",
                  style: AppTextStyles.semiBoldTextStyles(
                    textColor: AppColors.whiteColor,
                    fontSize: size/40,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Row(
                children: [
                  Icon(iconData ?? Icons.fastfood_outlined, size: 15),
                  const SizedBox(width: 5),
                  Text(
                    label ?? "",
                    style: AppTextStyles.mediumTextStyles(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(top: 20),
      height: 220,
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: const ShimmerEffect(),
    );
  }
}

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(top: 20),
      height: 220,
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: Text(
          'Failed to load $label data',
          style: AppTextStyles.mediumTextStyles(
              textColor: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
