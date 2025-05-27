import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saleko/app/widgets/back_button.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/animated_navigation.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/screen_size.dart';

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
        body: SafeArea(
            child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        children: [
                          CustomBackButton(),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Notifications",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.greenText)),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                            color: Colors.grey.shade100,
                                            width: 2)),
                                    width: Responsive.width(context),
                                    // height: 105,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/sms.svg",
                                              // width: 10,
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
                                                  'Incoming Vehicle:',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'You have Truck CR2034 coming your way',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  '12 May 2024, 2:43pm',
                                                  style: TextStyle(
                                                      color: Color(0xff545454),
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 10.h),
                              InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                            color: Colors.grey.shade100,
                                            width: 2)),
                                    width: Responsive.width(context),
                                    //height: 105,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/sms.svg",
                                              // width: 10,
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
                                                  'Incoming Vehicle:',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'You have Truck CR2034 coming your way',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  '12 May 2024, 2:43pm',
                                                  style: TextStyle(
                                                      color: Color(0xff545454),
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 10.h),
                              InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                            color: Colors.grey.shade100,
                                            width: 2)),
                                    width: Responsive.width(context),
                                    // height: 105,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/sms.svg",
                                              // width: 10,
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
                                                  'Incoming Vehicle:',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'You have Truck CR2034 coming your way',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  '12 May 2024, 2:43pm',
                                                  style: TextStyle(
                                                      color: Color(0xff545454),
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 10.h),
                              InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                            color: Colors.grey.shade100,
                                            width: 2)),
                                    width: Responsive.width(context),
                                    //  height: 105,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/sms.svg",
                                              // width: 10,
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
                                                  'Incoming Vehicle:',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'You have Truck CR2034 coming your way',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  '12 May 2024, 2:43pm',
                                                  style: TextStyle(
                                                      color: Color(0xff545454),
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 10.h),
                              InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                            color: Colors.grey.shade100,
                                            width: 2)),
                                    width: Responsive.width(context),
                                    // height: 105,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/sms.svg",
                                              // width: 10,
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
                                                  'Incoming Vehicle:',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'You have Truck CR2034 coming your way',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  '12 May 2024, 2:43pm',
                                                  style: TextStyle(
                                                      color: Color(0xff545454),
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ))
                    ])))));
  }
}
