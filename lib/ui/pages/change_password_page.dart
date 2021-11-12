import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../shared/theme.dart';

class ChangePass extends StatelessWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Text(
          'Ganti Password Akun',
          style: textBlackStyle.copyWith(fontSize: 19, fontWeight: semiBold),
        ),
      );
    }

    Widget inputSection() {
      Widget lastPassword() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password Terakhir',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
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

      Widget newPasswordInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password Baru',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 12,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password baru',
                  helperText: 'No more than 12 characters',
                  helperStyle: textBlackStyle.copyWith(
                    color: kRedColor,
                    fontSize: 8,
                    fontWeight: light,
                  ),
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

      Widget rePasswordInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ketik Ulang Password Baru',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
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

      Widget changeButton() {
        return Container(
          width: double.infinity,
          height: 60,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/SignInPage');
            },
            style: TextButton.styleFrom(
              backgroundColor: kRedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
            ),
            child: Text(
              'Ganti Password',
              style: textWhiteStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
          ),
        );
      }

      return Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 30,
          ),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(
              defaultRadius,
            ),
          ),
          child: Column(
            children: [
              lastPassword(),
              newPasswordInput(),
              rePasswordInput(),
              changeButton(),
            ],
          ));
    }

    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            title(),
            inputSection(),
          ],
        ),
      ),
    );
  }
}
