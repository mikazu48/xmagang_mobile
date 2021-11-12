import 'package:flutter/material.dart';
import 'package:magangskipsi/cubit/page_cubit.dart';
import 'package:magangskipsi/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButtomNavItem extends StatelessWidget {
  final int index;
  final String imgaeUrl;
  // final bool isSelected;

  const CustomButtomNavItem({
    Key? key,
    required this.index,
    required this.imgaeUrl,
    // this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PageCubit>().setPage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Image.asset(
            imgaeUrl,
            width: 24,
            height: 24,
            color: context.read<PageCubit>().state == index
                ? kPrimaryColor
                : kgreyColor,
          ),
          Container(
            width: 50,
            height: 3,
            decoration: BoxDecoration(
              color: context.read<PageCubit>().state == index
                  ? kPrimaryColor
                  : kTransparentColor,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ],
      ),
    );
  }
}
