// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:healthmini/models/exercise_model.dart';
import 'package:healthmini/utils/general_imports.dart';

class ExerciseDetailView extends StatefulWidget {
  const ExerciseDetailView({
    super.key,
  });

  @override
  State<ExerciseDetailView> createState() => _ExerciseDetailViewState();
}

class _ExerciseDetailViewState extends State<ExerciseDetailView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseListProvider>(builder: (context, value, child) {
      String imageUrl = value.pexelsModel?.photos != null
          ? value.pexelsModel!.photos![0].src?.portrait ?? ''
          : '';
      return Scaffold(
        appBar: AppBar(
          title: Text(
            value.exerciseList[0].data?.exerciseName ?? "",
            style: AppTextStyles.mediumTextStyles(fontSize: 18),
          ),
          actions: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.only(right: 20
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.appColors,
                ),
                borderRadius: BorderRadius.circular(100)
              ),
              child: InkWell(
                hoverColor: Colors.transparent,
                onTap: () => openYoutubeWithQuery(value.exerciseList[0].data?.exerciseName ?? "daily exercise"),
                child: Row(children: [
                  SvgPicture.asset("assets/svg/youtube_icon.svg"),
                  const SizedBox(width: 5,),
                  Text("Watch on youtube",style: AppTextStyles.mediumTextStyles(fontSize: 12),),
                  const SizedBox(width: 3),
                ],),
              ),
            )
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return _buildDesktopLayout(context,
                data: value.exerciseList[0].data, imageUrl: imageUrl);
          } else if (constraints.maxWidth > 600) {
            return _buildTabletLayout(context,
                data: value.exerciseList[0].data, imageUrl: imageUrl);
          } else {
            return _buildMobileLayout(context,
                data: value.exerciseList[0].data, imageUrl: imageUrl);
          }
        }),
      );
    });
  }

  Widget _buildDesktopLayout(BuildContext context,
      {String? imageUrl, Data? data}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: NetworkImages(imageUrl: imageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: _buildDetailColumn(context, data: data),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context,
      {String? imageUrl, Data? data}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: NetworkImages(imageUrl: imageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: _buildDetailColumn(context, data: data),
          ),
        ],
      ),
    );
  }

  Future<void> openYoutubeWithQuery(String searchQuery) async {
    String youtubeUrl = 'https://www.youtube.com/results?search_query=$searchQuery';

    if (await canLaunchUrl(Uri.parse(youtubeUrl))) {
      await launch(youtubeUrl);
    } else {
      showCustomSnackbar(context, "Something went wrong. Please try again.", MessageType.error);
    }
  }

  Widget _buildMobileLayout(BuildContext context,
      {String? imageUrl, Data? data}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          NetworkImages(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: 300,
          ),
          const SizedBox(height: 20),
          _buildDetailColumn(context, data: data),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(BuildContext context, {Data? data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data?.exerciseName ?? "Exercise Name",
          style: AppTextStyles.mediumTextStyles(fontSize: 24),
        ),
        const SizedBox(height: 10),
        Text(
          data?.aasanName ?? "Aasan Name",
          style: AppTextStyles.mediumTextStyles(
              fontSize: 18, textColor: Colors.grey),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: "Duration: ",
            style: AppTextStyles.boldTextStyles(fontSize: 15),
            children: [
              TextSpan(
                text: data?.duration ?? "Unknown",
                style: AppTextStyles.mediumTextStyles(fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: "Difficulty Level: ",
            style: AppTextStyles.boldTextStyles(fontSize: 15),
            children: [
              TextSpan(
                text: data?.difficultyLevel ?? "Unknown",
                style: AppTextStyles.mediumTextStyles(fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Steps:",
          style: AppTextStyles.boldTextStyles(
              fontSize: 15), // Bold style for the label
        ),
        ...?data?.steps?.map((step) => Text(
              "- $step",
              style: AppTextStyles.mediumTextStyles(
                  fontSize: 16), // Normal style for the details
            )),
        const SizedBox(height: 20),
        Text(
          "Benefits:",
          style: AppTextStyles.boldTextStyles(
              fontSize: 15), // Bold style for the label
        ),
        ...?data?.benefit?.map((benefit) => Text(
              "- $benefit",
              style: AppTextStyles.mediumTextStyles(
                  fontSize: 16), // Normal style for the details
            )),
      ],
    );
  }
}
