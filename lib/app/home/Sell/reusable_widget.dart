import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/services/navigation/route_names.dart';
import '../../../services/navigation/navigator_service.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/locator.dart';

AppBar buildAppBarCustom({
  required BuildContext context,
  String? title,
  Widget? action,
  bool? isHomeNavigation,
  Function()? onTap,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark),
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios, size: 18,), //SvgPicture.asset('images/arrow_left.svg'),
      onPressed: () {
        if (onTap != null) {
          onTap();
        } else {
          if (isHomeNavigation == true) {
            locator<NavigatorService>()
                .pushAndRemoveUntil(bottomNavigationRoute);
          } else {
            Navigator.pop(context);
          }
        }
      },
    ),
    title: Text(
      title ?? "",
      style: GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.w600),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    actions: [action ?? const SizedBox.shrink()],
  );
}

class DashIndicator extends StatelessWidget {
  final int currentIndex;
  const DashIndicator({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(6, (index) {
        final Color color = _getDashColor(index);
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            height: 4.h,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(3.r))),
          ),
        );
      }),
    );
  }

  Color _getDashColor(int index) {
    if (index < currentIndex) {
      return Colors.green; // Interacted dashes
    } else if (index == currentIndex) {
      return Colors.blue; // Current dash
    } else {
      return Colors.grey; // Not yet interacted
    }
  }
}


class DashThreeIndicator extends StatelessWidget {
  final int currentIndex;
  final int? length;
  const DashThreeIndicator(
      {super.key, required this.currentIndex, this.length});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(length ?? 3, (index) {
        final Color color = _getDashColor(index);
        return Expanded(
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 6.w),
            height: 4.h,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(3.r))),
          ),
        );
      }),
    );
  }

  Color _getDashColor(int index) {
    if (index < currentIndex) {
      return AppColors.primaryColor; // Interacted dashes
    } else if (index == currentIndex) {
      return AppColors.primaryColor; // Current dash
    } else {
      return AppColors.greyLight; // Not yet interacted
    }
  }
}
