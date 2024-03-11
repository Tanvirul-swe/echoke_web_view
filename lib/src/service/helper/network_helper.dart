import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_bloc.dart';
import 'package:echoke_web_view/src/feature/home/presentation/bloc/network_event.dart';

class NetworkHelper {

  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        NetworkBloc().add(NetworkNotify());
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }
}
