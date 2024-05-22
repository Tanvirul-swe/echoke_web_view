// ignore_for_file: deprecated_member_use

import 'package:echoke_web_view/src/common/app_helper.dart';
import 'package:echoke_web_view/src/common/common_widget.dart';
import 'package:echoke_web_view/src/constant/app_colors.dart';
import 'package:echoke_web_view/src/constant/app_constant.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_bloc.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_state.dart';
import 'package:echoke_web_view/src/feature/home/presentation/widget/network_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await inAppWebViewController.canGoBack()) {
          inAppWebViewController.goBack();
          return false;
        }
        return context.mounted ? await onBackButtonPressed(context) : false;
      },
      child: Scaffold(
        // Bottom Navigation Bar for web view

        bottomNavigationBar: Container(
          height: AppConstant.buttonHeight,
          decoration: const BoxDecoration(
            color: AppColors.homeButtonNavigatorColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppConstant.borderRadius),
              topRight: Radius.circular(AppConstant.borderRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: AppConstant.blurRadius,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () async {
                  if (await inAppWebViewController.canGoBack()) {
                    inAppWebViewController.goBack();
                  } else {
                    await onBackButtonPressed(context);
                  }
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.amber),
              ),
              IconButton(
                  onPressed: () async {
                    // If can go forward then go forward else do nothing
                    if (await inAppWebViewController.canGoForward()) {
                      inAppWebViewController.goForward();
                    }
                  },
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.amber)),
              IconButton(
                onPressed: () {
                  inAppWebViewController.reload();
                },
                icon: const Icon(Icons.refresh, color: Colors.amber),
              ),
            ],
          ),
        ),
        body: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            if (state is NetworkFailure) {
              // If network failure then show network failure card
              // TODO : Customise the network failure card
              return const NetworkFailureCard();
            } else if (state is NetworkSuccess) {
              return SafeArea(
                child: Stack(
                  children: [
                    InAppWebView(
                      pullToRefreshController: PullToRefreshController(
                        options: PullToRefreshOptions(
                          color: AppColors.backgroundColor,
                        ),
                        onRefresh: () {
                          inAppWebViewController.reload();
                        },
                      ),
                      initialSettings: InAppWebViewSettings(
                        userAgent:
                            'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Mobile Safari/537.36',
                      ),
                      initialUrlRequest:
                          URLRequest(url: WebUri(AppConstant.WEB_URL)),
                      onWebViewCreated: (InAppWebViewController controller) {
                        inAppWebViewController = controller;
                      },
                      onLoadStart: (InAppWebViewController controller,
                          Uri? url) async {},
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                        setState(() {
                          _progress = progress / 100;
                        });
                      },
                    ),
                    // Show loader if progress is less than 1
                    //  TODO : Customise the loader
                    _progress < 1
                        ? Align(
                            alignment: Alignment.center,
                            child: builderLoader(
                                MediaQuery.of(context).size.height,
                                MediaQuery.of(context).size.width),
                          )
                        : const SizedBox.shrink(),
                    // Show progress bar if progress is less than 1
                    //  TODO : Customise the progress bar
                    _progress < 1
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: LinearProgressIndicator(
                                color: AppColors.progressColor,
                                value: _progress,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
