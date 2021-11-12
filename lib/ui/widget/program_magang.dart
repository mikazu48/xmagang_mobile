import 'package:flutter/material.dart';
import 'package:magangskipsi/shared/theme.dart';
import 'package:magangskipsi/ui/pages/Intern_KMI.dart';
import 'package:magangskipsi/ui/pages/Intern_bumn.dart';
import 'package:magangskipsi/ui/pages/Intern_personals.dart';

class ProgramMagang extends StatelessWidget {
  final String name;
  final int menu_code;
  final String imageUrl;

  const ProgramMagang(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.menu_code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (menu_code == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Magangpersonals(),
            ),
          );
        } else if (menu_code == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MagangBumn(),
            ),
          );
        } else if (menu_code == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MagangKMI(),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 50,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  image: AssetImage(
                    imageUrl,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textBlackStyle.copyWith(
                    fontSize: 11,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
