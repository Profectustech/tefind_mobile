import 'package:flutter/material.dart';

class AppColors {
  // NOTE: Colors that are currently not used anywhere in the app
  // have been commented out.

  static const Color accent = Color(0xFFEFF6FF);
  static const Color tabColorGreen = Color.fromRGBO(8, 76, 63, 0.15);
  static const Color pink = Color.fromRGBO(238, 2, 2, 0.1);
  static const Color lightPink = Color.fromRGBO(245, 0, 0, 0.05);

  static const Color baseWhite = Color(0xFFFCFFFD);
  static const Color black = Color(0xFF000000);
  static  Color lightTextBlack =  HexColor.fromHex("#4B5563");
  static  Color lightGreen =  HexColor.fromHex("#DCFCE7");
  static  Color lightGreen2 =  Color.fromRGBO(64, 210, 161, 0.05);
  //static  Color lightGreen2 =  HexColor.fromHex("#40D2A1");
  static  Color cyan =  HexColor.fromHex("#DBEAFE");
  static  Color lightPurple =  HexColor.fromHex("#F3E8FF");
  static  Color lightYellow =  HexColor.fromHex("#FEF3C7");
  static  Color scaffoldBackgroundColor =  HexColor.fromHex("#FAFAFA");

  static const Color faintBlack = Color.fromRGBO(75, 85, 99, 1);
  static const Color blackTextColor = Color(0xFF1B1C1E);
  static const Color blueTextColor = Color(0xFF1C265D);
  static const Color blueDeeperText = Color(0xFF1C1939);
  static const Color greenLightest = Color.fromRGBO(8, 76, 63, 0.05);
  static const Color greenLighter = Color.fromRGBO(166, 174, 190, 1);
  static const Color dividerColor = Color.fromRGBO(28, 28, 28, 0.1);

  static const Color buttonDisabled = Color(0xFFAAAAAA);
  static const Color danger = Color(0xFFEA2A2A);
  static const Color darkGreen2 = Color(0xFF333B00);
  static const Color error = Color(0xFF8C0900);
  static const Color fadedBlack = Color(0xFF060D23);
  static const Color lightWhite = Color(0xFFDEE1F2);
  static const Color lightWhiteBg = Color(0xFFF0F7FF);
  static const Color primaryColor = Color.fromRGBO(60, 181, 181, 1);
  static const Color secondaryColor = Color(0xFF088158);
  static const Color shadowGrey = Color(0xFF111111);
  static const Color successGreen = Color(0xFF0C7731);
  static const Color transparentBlack = Color(0x99000000);
  static const Color warning = Color(0xFF754E00);
  static const Color warningRed = Color(0xFFE00000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color containerWhite = Color.fromRGBO(250, 250, 250, 1);
  static const Color grey = Color(0xFF8E8E8E);
  static const Color greyLight = Color(0xFFE7E9EA);

  static const Color greyButton = Color (0xFFDADADA);
  // static const Color greyText = Color(0xFF4F4F4F);
  static  Color greyText = HexColor.fromHex("#6B7280");
  static  Color greyLight2 = HexColor.fromHex("#F9FAFB");
  static  Color orange = HexColor.fromHex("#FF7D54");
  static  Color yellow = HexColor.fromHex("#EAB308");
  static const Color greyButtonText = Color (0xFF6B6B6B);

  static const Color greyFaint = Color(0xFFE8ECF4);
  static const Color backgroundColor = Color(0xffF7F7F6);

  static const Color whiteTextColor = Color(0xFFFCFCFC);
  //Red
  static const Color red = Color(0xFFD32027);
  //Green
  static const Color green = Color(0xFF0BCD74);
  static const Color greenSecond = Color(0xFF088158);
  static const Color greenText = Color(0xFF002E15);
  static const Color greenFade = Color(0xFFDFEFE9);
  static const Color green2 = Color(0xFF34A853);
  static const Color greenFade2 = Color(0xFFD8F3DF);

  static const Color purple = Color(0xFFE7E5FF);

 // static const Color yellow = Color(0xffFCF7E1);

  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);

  static Color lightErrorBorderColor = HexColor.fromHex("#F4B0A1");
  static Color lightErrorColor = HexColor.fromHex("#FFF5F3");
  static Color toastTextColor = HexColor.fromHex("#2F3F53");

  static Color lightSuccessBorderColor = HexColor.fromHex("#48C1B5");
  static Color lightSuccessColor = HexColor.fromHex("#F6FFF9");
}
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}