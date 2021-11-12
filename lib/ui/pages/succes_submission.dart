import 'package:flutter/material.dart';
import 'package:magangskipsi/shared/theme.dart';
import 'package:magangskipsi/ui/widget/custom_button.dart';

class SuccesSubmissionPage extends StatelessWidget {
  const SuccesSubmissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 150,
            margin: EdgeInsets.only(
              bottom: 80,
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/scheduling.png',
              ),
            )),
          ),
          Text(
            'Success Submission',
            style: textWhiteStyle.copyWith(
              fontSize: 26,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Silahkan tunggu satu sampai dua hari,Anda akan mendaptkan balasan berupa file surat',
            style: textWhiteStyle.copyWith(
              fontSize: 10,
              fontWeight: light,
            ),
            textAlign: TextAlign.center,
          ),
          CustomButton(
            title: 'My Submission',
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/MainPage', (route) => false);
            },
            width: 250,
            margin: EdgeInsets.only(top: 50),
          ),
        ],
      )),
    );
  }
}
