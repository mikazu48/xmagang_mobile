import 'package:flutter/material.dart';
import 'package:magangskipsi/shared/theme.dart';
import 'package:magangskipsi/ui/widget/custom_button.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 20,
        ),
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/profile.png",
            ),
          ),
        ),
      );
    }

    Widget titlenama() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: 3,
        ),
        child: Center(
          child: Text(
            'Dani Safiar',
            style: textBlackStyle.copyWith(
              fontSize: 15,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget textEvalap() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        margin: EdgeInsets.only(top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/EvaluasiPage');
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
              ),
              child: Text(
                'Evaluasi dan Laporan Magang',
                style: textWhiteStyle.copyWith(
                  color: kBlueColor,
                  fontSize: 15,
                  fontWeight: light,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget textchangePassword() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
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
                'Ganti password',
                style: textWhiteStyle.copyWith(
                  color: kBlueColor,
                  fontSize: 15,
                  fontWeight: light,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonLogout() {
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
            CustomButton(
              title: 'Log Out',
              width: 200,
              onPressed: () {
                Navigator.pushNamed(context, '/SignInPage');
              },
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        header(),
        titlenama(),
        textEvalap(),
        textchangePassword(),
        buttonLogout()
      ],
    );
  }
}
