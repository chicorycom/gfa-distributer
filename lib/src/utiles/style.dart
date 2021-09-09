import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}

const kSpacingUnit = 10;

const Color kPrimaryColor = Colors.blue;
const Color KBackgroundColor = Color(0xDD181818);
const Color kPrimaryColorTran = Color(0xDD212121);
Color kGryColorText = Colors.grey.shade500;
const Color kSecondaryColor = Color(0xFF00ACC1);
Color kBackgroundColorTran = Colors.black.withOpacity(0.5);


const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

const kBottomTextStyle = TextStyle(
  fontSize: 21.0,
  fontWeight: FontWeight.bold,
);

const kFABTheme = FloatingActionButtonThemeData(
  backgroundColor: kSecondaryColor,
);

const kTextTheme = TextTheme(
  headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),

  headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
  bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
);

const kAppBarTheme = AppBarTheme(
  elevation: 0.0,
  textTheme: TextTheme(

    headline1: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  color: kPrimaryColorTran,
);

const kInputDecorationTheme = InputDecorationTheme(
  hintStyle: TextStyle(
    color: Colors.white70,
  ),
);

final kTitleTextStyle = TextStyle(
  fontSize: kSpacingUnit.w * 1.7,
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: kSpacingUnit.w * 1.3,
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: kSpacingUnit.w * 1.5,
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kViewTextStyle = TextStyle(fontSize: 12, color: Colors.grey.shade500);
final kVoteAverageTextStyle = TextStyle(fontWeight: FontWeight.w600,fontSize: 12);




//Switch theme
final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'RobotoMono',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
    color: kLightSecondaryColor,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    fontFamily: 'RobotoMono',
    bodyColor: kLightSecondaryColor,
    displayColor: kLightSecondaryColor,
  ),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'RobotoMono',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
    color: kDarkSecondaryColor,
  ),
  textTheme: ThemeData.light().textTheme.apply(
    fontFamily: 'RobotoMono',
    bodyColor: kDarkSecondaryColor,
    displayColor: kDarkSecondaryColor,
  ),
);

Widget loading =  Container(
  height: kSpacingUnit.w * 10,
  width: kSpacingUnit.w * 18,
  color: kDarkSecondaryColor,
  child: Center(
    child: Text('VMedias', style: TextStyle(fontWeight: FontWeight.w600, color: kDarkPrimaryColor, fontSize: 21),),
  ),
);

Widget filmLoading =  Container(
  height: kSpacingUnit.w * 22,
  width: kSpacingUnit.w * 16.2,
  color: kDarkSecondaryColor,
  child: Center(
    child: Text('VMedias', style: TextStyle(fontWeight: FontWeight.w600, color: kDarkPrimaryColor, fontSize: 21),),
  ),
);

Widget errorLoading = Container(
  height: kSpacingUnit.w * 10,
  width: kSpacingUnit.w * 18,
  color: kDarkSecondaryColor,
  child: Center(
    child: Icon(Icons.error),
  ),
);
