import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/custom_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

customYMargin(double value) {
  return SizedBox(height: value);
}

customXMargin(double value) {
  return SizedBox(width: value);
}

final NumberFormat currencyFormat =
    NumberFormat.currency(decimalDigits: 2, symbol: "\u20A6");

Future<void> launchInWebViewOrVC(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    );
  } else {
    throw 'Could not launch $url';
  }
}

Timer? _debounceTimer;
debounce(Duration duration, VoidCallback action) {
  if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
  _debounceTimer = Timer(duration, action);
}

Future<void> launchPhone(String phone) async {
  if (await canLaunch("tel:$phone")) {
    print("call na");
    await launch(
      "tel:$phone",
    );
  } else {
    throw 'Could not launch $phone';
  }
}

showToast({String? title, String? message,Widget? icon}) {
//  showte_findSnackBar( message ?? '',icon, true );
  if (NavigatorService.navigationKey_.currentContext != null) {
    return showTopSnackBar(
        Overlay.of(NavigatorService.navigationKey_.currentContext!),
        Material(
          color: Colors.transparent,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.lightSuccessColor,
                border: Border.all(
                  color: AppColors.lightSuccessBorderColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title == null || title == '' ? "Success" : title,
                            style: TextStyle(
                                color: AppColors.toastTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 15)),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(message ?? '',
                            maxLines: 3,
                            style: TextStyle(
                              color: AppColors.toastTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12, // Adjust as needed
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
                  // SvgPicture.asset(
                  //   Assets.greenCheckIcon,
                  //   height: 24,
                  //   width: 24,
                  // ),
                ],
              )),
        ),
        padding: const EdgeInsets.all(30));
  }
  // if (NavigationService.navigationKey_.currentContext != null) {
  //   return showTopSnackBar(
  //     Overlay.of(NavigationService.navigationKey_.currentContext!),
  //     CustomSnackBar.success(
  //       backgroundColor: AppColors.green,
  //       message: message,
  //     ),
  //   );
  // }
}



showErrorToast({String? title, String? message,Widget? icon}) {
 // showte_findSnackBar( message ?? '',icon, false );
  if (NavigatorService.navigationKey_.currentContext != null) {
    return showTopSnackBar(
        Overlay.of(NavigatorService.navigationKey_.currentContext!),
        Material(
          color: Colors.transparent,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.lightErrorColor,
                border: Border.all(
                  color: AppColors.lightErrorBorderColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            title == null || title == ''
                                ? "Error Occurred"
                                : title,
                            style: TextStyle(
                                color: AppColors.toastTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 15)),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(message ?? '',
                            maxLines: 3,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: AppColors.toastTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ))),
                      ],
                    ),
                  ),
                  // SvgPicture.asset(
                  //   Assets.closeIcon,
                  //   height: 24,
                  //   width: 24,
                  // )
                ],
              )),
        ));
  }
  // return showTopSnackBar(
  //   Overlay.of(NavigationService.navigationKey_.currentContext!),
  //   CustomSnackBar.info(
  //     backgroundColor: AppColors.red,
  //     message: message,
  //   ),
  // );
}

String capitalize(val) {
  return "${val[0].toUpperCase()}${val.substring(1)}";
}

formatDate(value) {
  final df = DateFormat('dd-MM-yyyy');
  return df.format(DateTime.parse(value));
}

formatDateTime(value) {
  final df = DateFormat('d MMMM, y hh:mm a');
  return df.format(DateTime.parse(value));
}

class Status {
  static const sent = 'sent';
  static const delivered = 'delivered';
  static const read = 'read';
}

//Sanni height sizer
height(double value, BuildContext context) {
  return MediaQuery.of(context).size.height * value;
}

width(double value, BuildContext context) {
  return MediaQuery.of(context).size.width * value;
}

class Validators {
  static String? isLength(String? value, int length,
      {String fieldName = "Field"}) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    } else if (value.length != length) {
      return "Must be of length $length";
    } else {
      return null;
    }
  }

  static bool isBase64(String str) {
    try {
      base64.decode(str);
      if (kDebugMode) {
        print("it is base64");
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  String? isEmpty(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else {
      return null;
    }
  }

  String? isSignUpEmpty(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (RegExp(r'[0-9]').hasMatch(value)) {
      return 'Input should only contain text';
    }
    return null;
  }

  String? isAirtime(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (double.parse(value.replaceAll(",", "")) < 100.00) {
      return 'Amount can\'t be less than N100';
    } else {
      return null;
    }
  }

  String? isAirtime2(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (double.parse(value.replaceAll(",", "")) < 50.00) {
      return 'Amount can\'t be less than N50';
    } else {
      return null;
    }
  }

  String? isPhone(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (value.length >= 11 && value.length < 15) {
      return null;
    } else {
      return 'Invalid Phone number';
    }
  }

  String? isPin(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (value.length == 4) {
      return null;
    } else {
      return 'Invalid PIN';
    }
  }

  String? isTarget(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (double.parse(value.replaceAll(",", "")) < 500.00) {
      return 'Amount can\'t be less than N500';
    } else {
      return null;
    }
  }

  String? isRent(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (double.parse(value.replaceAll(",", "")) < 10000.00) {
      return 'Amount can\'t be less than N10,000';
    } else {
      return null;
    }
  }

  String? isLittle(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (double.parse(value.replaceAll(",", "")) < 100.00) {
      return 'Amount can\'t be less than N100';
    } else {
      return null;
    }
  }

  String? isVault(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (double.parse(value.replaceAll(",", "")) < 100000.00) {
      return 'Amount can\'t be less than N100,000';
    } else {
      return null;
    }
  }
  final NumberFormat currencyFormat =
  NumberFormat.currency(decimalDigits: 2, symbol: '\u20A6');

//
  String? isPassword(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must have at least one uppercase letter.';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must have at least one lowercase letter.';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must have at least one number.';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must have at least one special character.';
    } else if (value.length < 8) {
      return 'Password must be a minimum of 8 characters.';
    } else if (validateStructure(value)) {
      return null;
    } else {
      return null;
      // return "Passwords must:\nBe a minimum of 8 characters\nInclude at least one number(0-9) \nInclude one special character \nInclude at least one uppercase letter(A-Z)\nInclude at least one lowercase letter(a-z)";
    }
  }

  String? isEmail(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (validateEmail(value)) {
      return null;
    } else {
      return 'Invalid email';
    }
  }

  String? isEmail2(value) {
    if (value.isEmpty) {
      return null;
    } else if (validateEmail(value)) {
      return null;
    } else {
      return 'Invalid email';
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}

widthSizer(double value, BuildContext context, {figmaWidth = 412}) {
  // 412 is the default design screen width on figma
  return MediaQuery.of(context).size.width *
      (value / figmaWidth); // width size on figma
}

heightSizer(double value, BuildContext context, {figmaHeight = 870}) {
  // 870 is the default design screen height on figma
  return MediaQuery.of(context).size.height *
      (value / figmaHeight); // height size on figma
}

bool criteria1Satisfied = false;
bool criteria2Satisfied = false;
bool hasUppercaseLetter = false;
bool hasLowercaseLetter = false;
bool hasNumber = false;
bool hasSymbol = false;


