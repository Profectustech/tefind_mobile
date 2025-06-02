import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/utils/app_colors.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  late final WebViewController _controller;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://te_find.ng/privacy-policy"))
      ..setNavigationDelegate(NavigationDelegate(
        // showing a loading indicator for good user experience
        onPageStarted: (_) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (_) {
          setState(() {
            isLoading = false;
          });
        },
      ));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                child: Stack(
                  children: [
                    WebViewWidget(controller: _controller),
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                  ],
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}
