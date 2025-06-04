import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/back_button.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/animated_navigation.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/screen_size.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() => _LoadingHistoryState();
}

class _LoadingHistoryState extends ConsumerState<NotificationPage> {
  final AnimatedNavigation _animatedNavigation = AnimatedNavigation();
  TextEditingController emailController = TextEditingController();
  late AccountProvider accountProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.greenText),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Today', style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightTextBlack
                      ), ),
                      SizedBox(height: 10.h),
                      InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.r)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      spreadRadius: 0,
                                      blurRadius: 2,
                                      offset: Offset(0, 0.2))
                                ],
                                // border: Border.all(
                                //     color: Colors.grey.shade100, width: 2)
                              ),
                            width: Responsive.width(context),
                            // height: 105,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.lightPurple),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/images/cart.svg",
                                          color:  Colors.purple
                                          // width: 10,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Price dropped for "Luxury Leather Handbag" - Now ₦45,000',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          '10mins ago',
                                          style: GoogleFonts.roboto(
                                              color: Color(0xff545454),
                                              fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: 10.h),
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
