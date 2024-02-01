import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> onBackButtonPressed(BuildContext context) async {
  bool exitApp = await showCupertinoDialog(
      context: context,
      builder: (BuildContext contex) {
        return CupertinoAlertDialog(
          title: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(
                width: 10,
              ),
              Text(
                "Are you sure?",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ],
          ),
          content: const Text(
            'Do you  want to close app?',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Yes')),
          ],
        );
      });
  return exitApp;
}
