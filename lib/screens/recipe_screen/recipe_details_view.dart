// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:healthmini/models/recipe_model.dart';
import 'package:healthmini/utils/general_imports.dart';

class RecipeDetailView extends StatefulWidget {
  const RecipeDetailView({
    super.key,
  });

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeListProvider>(builder: (context, value, child) {
      String imageUrl = value.pexelsModel?.photos != null
          ? value.pexelsModel!.photos![0].src?.portrait ?? ''
          : '';
      return Scaffold(
        appBar: AppBar(
          title: Text(
            value.recipeList[0].data?.recipeName ?? "",
            style: AppTextStyles.mediumTextStyles(fontSize: 18),
          ),
          actions: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.appColors),
                  borderRadius: BorderRadius.circular(100)),
              child: InkWell(
                hoverColor: Colors.transparent,
                onTap: () => openYoutubeWithQuery(
                    value.recipeList[0].data?.recipeName ?? "recipe"),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/youtube_icon.svg"),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Watch on youtube",
                      style: AppTextStyles.mediumTextStyles(fontSize: 12),
                    ),
                    const SizedBox(width: 3),
                  ],
                ),
              ),
            )
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return _buildDesktopLayout(context,
                data: value.recipeList[0].data, imageUrl: imageUrl);
          } else if (constraints.maxWidth > 600) {
            return _buildTabletLayout(context,
                data: value.recipeList[0].data, imageUrl: imageUrl);
          } else {
            return _buildMobileLayout(context,
                data: value.recipeList[0].data, imageUrl: imageUrl);
          }
        }),
      );
    });
  }

  Widget _buildDesktopLayout(BuildContext context,
      {String? imageUrl, Data? data}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
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
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context,
      {String? imageUrl, Data? data}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
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
      ),
    );
  }

  Future<void> openYoutubeWithQuery(String searchQuery) async {
    String youtubeUrl =
        'https://www.youtube.com/results?search_query=$searchQuery';

    if (await canLaunchUrl(Uri.parse(youtubeUrl))) {
      await launch(youtubeUrl);
    } else {
      showCustomSnackbar(context, "Something went wrong. Please try again.",
          MessageType.error);
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
          data?.recipeName ?? "Recipe Name",
          style: AppTextStyles.mediumTextStyles(fontSize: 24),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: "Cook Time: ",
            style: AppTextStyles.boldTextStyles(fontSize: 15),
            children: [
              TextSpan(
                text: data?.cookTime ?? "Unknown",
                style: AppTextStyles.mediumTextStyles(fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: "Serving Size: ",
            style: AppTextStyles.boldTextStyles(fontSize: 15),
            children: [
              TextSpan(
                text: data?.servingSize ?? "Unknown",
                style: AppTextStyles.mediumTextStyles(fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Ingredients:",
          style: AppTextStyles.boldTextStyles(fontSize: 15),
        ),
        ...?data?.ingredients?.map((ingredient) => Text(
              "- $ingredient",
              style: AppTextStyles.mediumTextStyles(fontSize: 16),
            )),
        const SizedBox(height: 20),
        Text(
          "How to Cook:",
          style: AppTextStyles.boldTextStyles(fontSize: 15),
        ),
        ...?data?.howToCook?.map((step) => Text(
              "- $step",
              style: AppTextStyles.mediumTextStyles(fontSize: 16),
            )),
        const SizedBox(height: 20),
        Text(
          "Benefits:",
          style: AppTextStyles.boldTextStyles(fontSize: 15),
        ),
        ...?data?.benefit?.map((benefit) => Text(
              "- $benefit",
              style: AppTextStyles.mediumTextStyles(fontSize: 16),
            )),
        const SizedBox(height: 20),
        if (data?.nutritionalInformation != null) ...[
          Text(
            "Nutritional Information:",
            style: AppTextStyles.boldTextStyles(fontSize: 15),
          ),
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
            },
            children: [
              _buildTableRow(
                  "Calories", data?.nutritionalInformation?.calories),
              _buildTableRow("Protein", data?.nutritionalInformation?.protein),
              _buildTableRow("Fat", data?.nutritionalInformation?.fat),
              _buildTableRow(
                  "Carbohydrates", data?.nutritionalInformation?.carbohydrates),
              _buildTableRow("Sugar", data?.nutritionalInformation?.sugar),
            ],
          ),
          const SizedBox(height: 20),
        ],
        if (data?.dietaryTags != null) ...[
          Text(
            "Dietary Tags:",
            style: AppTextStyles.boldTextStyles(fontSize: 15),
          ),
          const SizedBox(
            height: 5,
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: data!.dietaryTags!.map((tag) {
              final random = Random();
              final color = AppColors()
                  .tagColors[random.nextInt(AppColors().tagColors.length)];
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: AppTextStyles.mediumTextStyles(
                    fontSize: 16,
                    textColor: Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  TableRow _buildTableRow(String title, String? value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: AppTextStyles.boldTextStyles(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value ?? "Unknown",
            style: AppTextStyles.mediumTextStyles(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
