import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
  });

  @override
  Widget build(BuildContext context) {
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
      color: backgroundColor ?? Colors.grey[200],
      child: showLoadingProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : null,
    );
  }

  Widget _buildErrorWidget() {
    if (errorWidget != null) return errorWidget!;

    return Container(
      width: width,
      height: height,
      color: backgroundColor ?? Colors.grey[200],
      child: const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      ),
    );
  }
} 