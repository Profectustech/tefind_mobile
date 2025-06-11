import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/locator.dart';
import 'package:te_find/utils/progress_bar_manager/busy_dialog.dart';
import 'package:te_find/utils/progress_bar_manager/dialog_models.dart';
import 'package:te_find/utils/progress_bar_manager/dialog_service.dart';

class ProgressManager extends StatefulWidget {
  final Widget child;
  const ProgressManager({required this.child});

  _ProgressManagerState createState() => _ProgressManagerState();
}

class _ProgressManagerState extends State<ProgressManager> {
  final ProgressService _progressService = locator<ProgressService>();

  @override
  void initState() {
    super.initState();
    _progressService.registerProgressListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  // void _showDialog(ProgressRequest request) async {
  //   ArsProgressDialog progressDialog = ArsProgressDialog(
  //     context,
  //     blur: 1,
  //     dismissable: false,
  //     animationDuration: const Duration(milliseconds: 500),
  //     loadingWidget: Center(
  //       child: SizedBox(
  //         height: 100.h,
  //         width: 100.h,
  //         child: Stack(
  //           alignment: Alignment.center,
  //           children: [
  //             SizedBox(
  //               height: 60.h,
  //               width: 60.h,
  //               child: CircularProgressIndicator(
  //                 strokeWidth: 6.0,
  //                 valueColor: AlwaysStoppedAnimation(AppColors.primaryColor), // Customize color
  //               ),
  //             ),
  //             SvgPicture.asset(
  //               'assets/images/app_icon.svg',
  //               height: 50.h, // Adjust to fit inside the circular indicator
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  //
  //   progressDialog.show(); // show dialog
  // }
  void _showDialog(ProgressRequest request) async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
      context,
      blur: 2,
      dismissable: false,
      // backgroundColor: const Color(0x33000000),
      animationDuration: const Duration(milliseconds: 500),
      loadingWidget: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
            SizedBox(
              height: 70.h,
              width: 70.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 60.h,
                    width: 60.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 4.0,
                      valueColor: AlwaysStoppedAnimation(AppColors.primaryColor), // Customize color
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/app_icon.svg',
                    height: 40.h, // Adjust to fit inside the circular indicator
                  ),
                ],
              ),
            ),
          )),
    );

    progressDialog.show(); // show dialog
  }

}
