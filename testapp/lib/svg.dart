import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgBackground extends StatelessWidget {
  final String assetPath;
  final Widget child;
  final BoxFit fit;

  const SvgBackground({
    super.key,
    required this.assetPath,
    required this.child,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // SVG Background
        Positioned.fill(child: SvgPicture.asset(assetPath, fit: fit)),

        // Foreground Content
        child,
      ],
    );
  }
}
