import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/widgets/back_button.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/animated_navigation.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/screen_size.dart';

class GetHelp extends ConsumerStatefulWidget {
  const GetHelp({super.key});

  @override
  ConsumerState<GetHelp> createState() => _LoadingHistoryState();
}

class _LoadingHistoryState extends ConsumerState<GetHelp> {
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
                          Text("Get Help",
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
                              SizedBox(height: 40.h),
                              Text(
                                'Get through to support',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
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
                                    height: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Call us',
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/call.svg",
                                              // width: 10,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              '07000725356',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/call.svg",
                                              // width: 10,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              '07000725356',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
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
                                    height: 120,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email Us',
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
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
                                            Text(
                                              'support@IHS.com',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ))
                    ])))));
  }
}
