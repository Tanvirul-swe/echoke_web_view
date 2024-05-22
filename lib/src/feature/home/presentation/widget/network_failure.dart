
import 'package:echoke_web_view/src/constant/app_constant.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_bloc.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_event.dart';
import 'package:flutter/material.dart';

class NetworkFailureCard extends StatelessWidget {
  const NetworkFailureCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            AppConstant.noInternetSub,
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
                AppConstant.tryAgain,
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
  }
}
