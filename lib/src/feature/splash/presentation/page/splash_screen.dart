import 'package:echoke_web_view/src/constant/app_assets.dart';
import 'package:echoke_web_view/src/constant/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Wait 3 seconds to call the next screen (Home Page)
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/HomePage',);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Container(
            color: AppColors.White,
            child: Center(child: Image.asset(AppAssets.LOGO, width: 200, height: 200))),
    );
  }
}
