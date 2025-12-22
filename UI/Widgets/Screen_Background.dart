import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Utils/AssetsPaths.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(AssetsPaths.backgroundSVG,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),

        SafeArea(
            child: child
        ),

        // Center(
        //     child: SvgPicture.asset(AssetsPaths.logoSVG,
        //       height: 50,
        //     )
        // )
      ],
    );
  }
}
