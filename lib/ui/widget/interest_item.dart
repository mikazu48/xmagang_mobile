import 'package:flutter/material.dart';
import 'package:magangskipsi/shared/theme.dart';

class InterestItem extends StatelessWidget {
  final String text;
  const InterestItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            margin: EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/icon_chec.png'),
              ),
            ),
          ),
          Text(
            text,
            style: textBlackStyle.copyWith(
              fontSize: 10,
              fontWeight: reguler,
            ),
          )
        ],
      ),
    );
  }
}
