import 'package:echoke_web_view/src/feature/error/presentation/page/error_404_page.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_bloc.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_event.dart';
import 'package:echoke_web_view/src/feature/home/presentation/page/home_page.dart';
import 'package:echoke_web_view/src/feature/splash/presentation/page/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/HomePage':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => NetworkBloc()..add(NetworkObserve()),
              child: const HomePage()),
        );

      case '/SplashScreen':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      default:
        return MaterialPageRoute(builder: (_) => const Error404Screen());
    }
  }
}
