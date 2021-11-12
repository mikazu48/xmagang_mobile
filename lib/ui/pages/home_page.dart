import 'package:flutter/material.dart';
import 'package:magangskipsi/shared/theme.dart';
import 'package:magangskipsi/ui/widget/program_magang.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        height: 65,
        decoration: BoxDecoration(
          color: kBackGroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.only(
          left: defaultMargin,
          top: 30,
          right: defaultMargin,
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/profile.png',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Howdy,\nDani Safiar',
                    style: textBlackStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icon_notification.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget programMagang() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: defaultMargin,
          right: defaultMargin,
          bottom: 3,
        ),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 3,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              width: 300,
              height: 3,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            Text(
              'Program Magang Bina Insani',
              style: textBlackStyle.copyWith(
                fontSize: 17,
                fontWeight: semiBold,
              ),
            ),
            Container(
              width: 300,
              height: 3,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              width: 200,
              height: 3,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            ProgramMagang(
              imageUrl: 'assets/icon_office.png',
              name: 'Program Magang\nPersonal\n(PMP)',
              menu_code: 1,
            ),
            ProgramMagang(
              imageUrl: 'assets/bumn.png',
              name: 'Program Magang\nMahasiswa Bersetifikat\n(PMMB)',
              menu_code: 2,
            ),
            ProgramMagang(
              imageUrl: 'assets/kmi.png',
              name: 'Program Magang\nKampus Merderka Indonesia\n(PMKMI)',
              menu_code: 3,
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        header(),
        programMagang(),
      ],
    );
  }
}
