import 'package:healthmini/utils/general_imports.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews',
            style: AppTextStyles.mediumTextStyles(fontSize: 22)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int columns;
          if (constraints.maxWidth > 900) {
            columns = 3;
          } else if (constraints.maxWidth > 600) {
            columns = 2;
          } else {
            columns = 1;
          }

          return StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('reviews').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildShimmer(context, columns);
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text(
                  'No reviews available',
                  style: AppTextStyles.mediumTextStyles(fontSize: 16),
                ));
              } else {
                final reviews = snapshot.data!.docs
                    .map((doc) => doc.data() as Map<String, dynamic>)
                    .toList();
                return _buildList(context, reviews, columns);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildShimmer(BuildContext context, int columns) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int shimmerColumns;
        if (constraints.maxWidth > 900) {
          shimmerColumns = 3;
        } else if (constraints.maxWidth > 600) {
          shimmerColumns = 2;
        } else {
          shimmerColumns = 1;
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: (10 / shimmerColumns).ceil(), // Number of rows
            itemBuilder: (context, rowIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(shimmerColumns, (columnIndex) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 16,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      width: double.infinity,
                                      height: 16,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildList(
      BuildContext context, List<Map<String, dynamic>> reviews, int columns) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: (reviews.length / columns).ceil(),
        itemBuilder: (context, rowIndex) {
          final startIndex = rowIndex * columns;
          final endIndex = startIndex + columns;
          final rowReviews = reviews.sublist(startIndex,
              endIndex > reviews.length ? reviews.length : endIndex);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowReviews.map((review) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: _buildReviewCard(review),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: NetworkImages(imageUrl: review['image_url'] ?? ''),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name']!,
                      style: AppTextStyles.boldTextStyles(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      review['location']!,
                      style: AppTextStyles.mediumTextStyles(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review['review']!,
            style: AppTextStyles.normalTextStyles(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
