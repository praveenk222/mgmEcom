import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/no_internet.webp',
                width: 163,
                height: 163,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "No internet connection!!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Check your connection or try again",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
