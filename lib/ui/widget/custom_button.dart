import 'package:flutter/material.dart';
import 'package:magangskipsi/shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final EdgeInsets margin;
  final Function() onPressed;

  const CustomButton(
      {Key? key,
      required this.title,
      this.width = 150,
      this.height = 60,
      this.margin = EdgeInsets.zero,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
        child: Text(
          title,
          style: textWhiteStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
