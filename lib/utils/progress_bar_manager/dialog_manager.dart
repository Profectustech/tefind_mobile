import 'package:flutter/material.dart';
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

  void _showDialog(ProgressRequest request) async {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 1,
        dismissable: false,
        // backgroundColor: const Color(0x33000000),
        animationDuration: const Duration(milliseconds: 500),
        loadingWidget:

                Image.asset(
                  'assets/images/logo_green.gif',
                  width: 225,
                ),

            );



    progressDialog.show(); // show dialog
  }
}
