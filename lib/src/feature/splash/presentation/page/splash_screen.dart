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
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/HomePage',);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: AppColors.backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              MediaQuery.of(context).size.width * 0.4),
                          bottomRight: Radius.circular(
                              MediaQuery.of(context).size.width * 0.4),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              MediaQuery.of(context).size.width * 0.4),
                          bottomRight: Radius.circular(
                              MediaQuery.of(context).size.width * 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      AppAssets.LOGO,
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'HallaPay',
                            style: TextStyle(
                              color: AppColors.White,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: 'Store',
                              style: TextStyle(
                                color: Color(0xFFC6C6C6),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("بطاقات شحن الألعاب والمواقع العالمية",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.White,
                          fontWeight: FontWeight.normal,
                        )),
                    const Text("تسوق الان بكل امان وسرعة في التسليم",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.White,
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery.of(context).size.width * 0.4),
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.width * 0.4),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery.of(context).size.width * 0.4),
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.width * 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
