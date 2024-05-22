import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppHelper {
  late BuildContext context;
  late DateTime currentBackPressTime;

  // ignore: no_leading_underscores_for_local_identifiers
  AppHelper.of(BuildContext _context) {
    context = _context;
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
            color: Colors.grey.withOpacity(0.4),
            child: const SpinKitFoldingCube(
              color: Colors.white,
              size: 50.0,
            )),
      );
    });
    return loader;
  }
}

Widget builderLoader(double height, double width) {
  return Container(
    height: height,
    width: width,
    color: Colors.grey.withOpacity(0.4),
    child: const Center(
      child: SpinKitFoldingCube(
        color: Colors.white,
        size: 50.0,
      ),
    ),
  );
}
