import 'dart:async';

import 'package:echoke_web_view/src/common/common_widget.dart';
import 'package:echoke_web_view/src/constant/app_assets.dart';
import 'package:echoke_web_view/src/constant/app_colors.dart';
import 'package:echoke_web_view/src/constant/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  WebViewController controller = WebViewController();

  StreamController<double> progressController = StreamController<double>();

  @override
  void initState() {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');

            progressController.add(progress.toDouble());
            if (progress == 100) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(AppConstant.WEB_URL));

      

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          }
          return await onBackButtonPressed(context);
        },
        child: SafeArea(
            child: _isLoading
                ? Container(
                    color: AppColors.White,
                    child: StreamBuilder<double>(
                        stream: progressController.stream,
                        initialData: 0.0,
                        builder: (context, snapshot) {
                          double progress = snapshot.data ?? 0.0;
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  AppAssets.LOADINGJSON,
                                  width: MediaQuery.of(context).size.width - 20,
                                  height:
                                      MediaQuery.of(context).size.width - 20,
                                ),
                                LinearPercentIndicator(
                                    barRadius: const Radius.circular(10),
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    lineHeight: 14.0,
                                    percent: progress / 100,
                                    center: Text(
                                      '${progress.toInt()}%',
                                      style: const TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.4),
                                    linearGradient: const LinearGradient(
                                      colors: [
                                        Colors.blue,
                                        Colors.green,
                                      ],
                                      tileMode: TileMode.mirror,
                                    )),
                              ],
                            ),
                          );
                        }),
                  )
                : WebViewWidget(controller: controller)),
      ),
    );
  }
}
