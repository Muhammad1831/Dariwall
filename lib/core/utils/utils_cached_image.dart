import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/widgets/app_loading.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeInDuration;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final bool showLoadingProgress;
  final BoxShape? shape;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.borderRadius,
    this.backgroundColor,
    this.showLoadingProgress = true,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('assets/')) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.asset(imageUrl, width: width, height: height, fit: fit,
          errorBuilder: (context, error, stack) => _buildErrorWidget()),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        fadeInDuration: fadeInDuration,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: shape ?? BoxShape.rectangle,
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    if (placeholder != null) return placeholder!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.disabledColor,
        shape: shape ?? BoxShape.circle,
      ),
      child: showLoadingProgress ? AppLoading() : null,
    );
  }

  Widget _buildErrorWidget() {
    if (errorWidget != null) return errorWidget!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.disabledColor,
        shape: shape ?? BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      ),
    );
  }
}
