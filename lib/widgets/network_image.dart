

import 'package:healthmini/utils/general_imports.dart';

class NetworkImages extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;
  final BoxFit? fit;
  final String dummyErrorUrl;

  const NetworkImages({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.dummyErrorUrl = "assets/images/no_image_placeholder.png",
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      width: width,
      height: height,
      image: CachedNetworkImageProvider(imageUrl ?? ""),
      placeholderBuilder: (context) {
        return _buildShimmerPlaceholder();
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorImage();
      },
      fit: fit!,
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }

  Widget _buildErrorImage() {
    return Image.asset(
      dummyErrorUrl,
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
