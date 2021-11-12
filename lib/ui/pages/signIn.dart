import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:magangskipsi/ui/widget/custom_button.dart';
import '../../shared/theme.dart';
import '/../../globals.dart' as globals;
import 'package:http/http.dart' as http;

var ctrlUsername = TextEditingController();
var ctrlController = TextEditingController();

class MahasiswaLogin {
  final String ID;
  final String NPM;
  final String nama_lengkap;

  MahasiswaLogin({
    required this.ID,
    required this.NPM,
    required this.nama_lengkap,
  });

  factory MahasiswaLogin.fromJson(Map<String, dynamic> json) {
    return MahasiswaLogin(
      ID: json['id'].toString(),
      NPM: json['NPM'],
      nama_lengkap: json['nama_lengkap'],
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Widget title() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 30),
    //     child: Text(
    //       'Pendaftaran Magang BiU',
    //       style: textBlackStyle.copyWith(fontSize: 19, fontWeight: semiBold),
    //     ),
    //   );
    // }

    Future<void> hitLogin() async {
      if (ctrlUsername.text.isNotEmpty && ctrlController.text.isNotEmpty) {
        var response = await http.post(
            Uri.parse(globals.API_URL + "mahasiswa/login"),
            body: ({
              'username': ctrlUsername.text,
              'password': ctrlController.text
            }));
        if (response.statusCode == 200) {
          MahasiswaLogin mhsData =
              MahasiswaLogin.fromJson(jsonDecode(response.body));
          Navigator.pushNamed(context, '/MainPage');
          globals.Sessions_UserID = mhsData.ID;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Anda berhasil login sebagai : " + mhsData.nama_lengkap)));
        }
        if (response.statusCode == 300) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Username atau password anda salah!")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Terjadi kesalahan di API !")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Harap isi username / password anda !")));
      }
    }

    Widget logo() {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/logo.png",
            ),
          ),
        ),
      );
    }

    Widget inputSection() {
      Widget usernameInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlUsername,
                decoration: InputDecoration(
                  hintText: 'Your NPM',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget passwordInput() {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Your BDay',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      )),
                ),
              ),
            ],
          ),
        );
      }

      Widget textForgetPass() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ChangePass');
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                ),
                child: Text(
                  'Lupa Password',
                  style: textWhiteStyle.copyWith(
                    color: kRedColor,
                    fontSize: 10,
                    fontWeight: light,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      }

      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kBackGroundColor,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        child: Column(
          children: [
            usernameInput(),
            passwordInput(),
            textForgetPass(),
            CustomButton(
              title: 'Log In',
              width: 200,
              onPressed: () {
                hitLogin();
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            // title(),
            logo(),
            inputSection(),
          ],
        ),
      ),
    );
  }
}
