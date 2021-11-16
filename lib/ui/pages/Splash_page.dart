import 'dart:async';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/MainPage');
    });
    super.initState();
  }

  Widget textBY() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Text(
        'Copyright © 2021 Xaviar',
        style: textWhiteStyle.copyWith(fontSize: 8, fontWeight: light),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 200),
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/logo.png",
                  ),
                ),
              ),
            ),
            textBY(),
          ],
        ),
      ),
    );
  }
}
