import 'package:flutter/material.dart';

const TextStyle logoTitleTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle subtitleTextStyle = TextStyle(
  fontSize: 23,
  color: Colors.black,
);

const TextStyle generalTitleTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.black,
);

class HomeBackgroundStyle {
  static const Color backgroundColor = Color.fromRGBO(121, 219, 172, 1.0);

  static const BoxShadow shadow = BoxShadow(
    color: Color.fromRGBO(158, 158, 158, 1),
    offset: Offset(0, 4),
    blurRadius: 6,
  );
  static const BorderRadius borderRadius = BorderRadius.only(
    topLeft: Radius.circular(15.0),
    topRight: Radius.circular(15.0),
    bottomLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(11.0),
  );
}

const double kBackgroundRatio = 0.25;

class HomePaddingStyle {
  static const EdgeInsets paddingTop =
      EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 30);
  static const EdgeInsets searchBarPadding =
      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 30);

  static const EdgeInsets manageRulesPadding =
      EdgeInsets.only(top: 10, left: 35);
  static const EdgeInsets rejectCallsPadding =
      EdgeInsets.only(top: 15, left: 35);
  static const EdgeInsets listViewPadding = EdgeInsets.only(top: 15, left: 35);
  static const EdgeInsets listViewHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 8.0);
}
