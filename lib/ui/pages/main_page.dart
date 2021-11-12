import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magangskipsi/cubit/page_cubit.dart';
import 'package:magangskipsi/ui/pages/boards.dart';
import 'package:magangskipsi/ui/pages/home_page.dart';
import 'package:magangskipsi/ui/pages/settings.dart';
import 'package:magangskipsi/ui/widget/custom_butoom_nav.dart';
import '../../shared/theme.dart';

class MainxPage extends StatelessWidget {
  const MainxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return BoardPage();
        case 2:
          return Settingspage();

        default:
          return HomePage();
      }
    }

    Widget customButtomNav() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 45,
          margin: EdgeInsets.only(
              bottom: 30,
              left: defaultMargin,
              top: defaultMargin,
              right: defaultMargin),
          decoration: BoxDecoration(
            color: kBackGroundColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButtomNavItem(
                index: 0,
                imgaeUrl: 'assets/icon_home.png',
                // isSelected: true,
              ),
              CustomButtomNavItem(
                index: 1,
                imgaeUrl: 'assets/icon_board.png',
              ),
              CustomButtomNavItem(
                index: 2,
                imgaeUrl: 'assets/icon_settings.png',
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: kBackGroundColor,
          body: Stack(
            children: [
              buildContent(currentIndex),
              customButtomNav(),
            ],
          ),
        );
      },
    );
  }
}
