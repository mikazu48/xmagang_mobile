library magangskripsi.globals;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Public Version
String BASE_URL = "https://vrsltz.com/xmagang/";
String API_URL = "https://vrsltz.com/xmagang/public/api/";

String Sessions_UserID = "";

class CoreFacade {
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Sedang memproses data...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class MessageResult {
  final String message;

  MessageResult({required this.message});

  factory MessageResult.fromJson(Map<String, dynamic> json) {
    return MessageResult(
      message: json['message'],
    );
  }
}
