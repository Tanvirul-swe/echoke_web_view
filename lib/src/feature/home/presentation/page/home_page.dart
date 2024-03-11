// ignore_for_file: deprecated_member_use

import 'package:echoke_web_view/src/common/common_widget.dart';
import 'package:echoke_web_view/src/constant/app_colors.dart';
import 'package:echoke_web_view/src/constant/app_constant.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_bloc.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_event.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

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
      // onWillPop: () async {
      //   var isLastPage = await inAppWebViewController.canGoBack();

      //   if (isLastPage) {
      //     inAppWebViewController.goBack();
      //     return false;
      //   }

      //   return true;
      // },
      child: Scaffold(
        body: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            if (state is NetworkFailure) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Icon(
                      Icons.wifi_off,
                      size: 100,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'تاكد من اتصالك بالأنترنيت وحاول مرة اخرى',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Spacer(),
                    Container(
                      width: 80,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          NetworkBloc().add(NetworkObserve());
                        },
                        child: const Text(
                          "تحديث",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
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
                      onLoadStart:
                          (InAppWebViewController controller, Uri? url) async {
                        if (url
                            .toString()
                            .contains('https://t.me/hallapay_support')) {
                          inAppWebViewController.stopLoading();
                          inAppWebViewController.goBack();
                          // inAppWebViewController.reload();
                          const url = 'https://t.me/hallapay_support';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                          // inAppWebViewController.stopLoading();
                        }
                      },
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                        setState(() {
                          _progress = progress / 100;
                        });
                      },
                    ),
                    _progress < 1
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: LinearProgressIndicator(
                                color: AppColors.backgroundColor,
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
