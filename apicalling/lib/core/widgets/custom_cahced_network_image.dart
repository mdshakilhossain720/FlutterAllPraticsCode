import 'package:apicalling/core/constants/app_colors.dart';
import 'package:apicalling/core/widgets/custom_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;
  final double? shimmerBorderRadius;
  final Color? bgColor;
  final bool showProgressIndicator;
  final IconData? errorIcon;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.shimmerBorderRadius,
    this.bgColor = Colors.transparent,
    this.showProgressIndicator = false,
    this.errorIcon = Icons.photo,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == "" ||
        imageUrl.isEmpty ||
        !Uri.tryParse(imageUrl)!.hasScheme == true) {
      return errorWidget ??
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(0),
              color: AppColors.primaryColor.withValues(alpha: .1),
            ),
            child: Icon(errorIcon, color: AppColors.primaryColor),
          );
    }
    return Container(
      clipBehavior: Clip.hardEdge,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        color: bgColor,
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: width,
        height: height,
        placeholder: (context, url) =>
            placeholder ??
            (showProgressIndicator
                ? CustomShimmerWidget(
                    width: width,
                    height: height,
                    borderRadius: shimmerBorderRadius,
                  )
                : const SizedBox()),
        errorWidget: (context, url, error) =>
            errorWidget ??
            const Center(child: Icon(Icons.photo, color: AppColors.gray50)),
      ),
    );
  }
}
