import 'package:echoke_web_view/src/constant/app_constant.dart';
import 'package:echoke_web_view/src/routing/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
    await Permission.camera.request();
    await Permission.photos.request();
    await Permission.storage.request();

  runApp(const Root());
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: AppConstant.APP_NAME,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: '/HomePage',
    );
  }
}
