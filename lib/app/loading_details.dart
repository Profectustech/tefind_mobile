import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/widgets/back_button.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/screen_size.dart';

class LoadingDetails extends ConsumerStatefulWidget {
  const LoadingDetails({super.key});

  @override
  ConsumerState<LoadingDetails> createState() => _EmailInpuScreenState();
}

class _EmailInpuScreenState extends ConsumerState<LoadingDetails> {
  final NavigatorService _navigation = NavigatorService();
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
                          Text("Loading Details",
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
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: "",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 50.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.contain),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    CircleAvatar(
                                              radius: 25,
                                              child: Image.asset(
                                                "assets/images/logo.jpg",
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Paul Anifowoshe",
                                              style: TextStyle(
                                                //color: AppColors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Recipient",
                                              style: TextStyle(
                                                  //  color: AppColors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              "ORDB1234",
                                              style: TextStyle(
                                                  color: AppColors.greyText,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(children: [
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: AppColors.greenSecond,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          child: Text(
                                            'Completed',
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF7F7F7),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.r),
                                            )),
                                        padding: EdgeInsets.all(2),
                                        child: SvgPicture.asset(
                                          "assets/images/truck.svg",
                                          color: AppColors.greenSecond,
                                          // width: 10,
                                        ),
                                      ),
                                    ])
                                  ]),
                              SizedBox(height: 30.h),
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        color: Colors.grey.shade100, width: 2)),
                                width: Responsive.width(context),
                                height: Responsive.height(context) / 1.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/location.svg",
                                              // width: 10,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            CircleAvatar(
                                              radius: 2,
                                              backgroundColor: AppColors.green,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            CircleAvatar(
                                              radius: 2,
                                              backgroundColor: AppColors.green,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            CircleAvatar(
                                              radius: 2,
                                              backgroundColor: AppColors.green,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            SvgPicture.asset(
                                              "assets/images/circle.svg",
                                              color: AppColors.greenSecond,
                                              // width: 10,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Start Location',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.grey),
                                            ),
                                            Text(
                                              '32 Samwell Sq, Chevron',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Delivery Location',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.grey),
                                            ),
                                            Container(
                                                width: 300,
                                                child: Text(
                                                  '21b, Karimu Kotun Street, Ogbomosho Road, Anthony Ikeja',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Tank Filled No',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.greyText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      'Fill0001112',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Quantity Deposited',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.greyText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '30,000 Litres',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Initial Dip',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.greyText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '3',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Final Dip',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.greyText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Gen set 1hr',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.greyText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '2',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Gen set 2 hr',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.greyText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '2',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Meter image(s)',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.grey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Image.asset("assets/images/meter.png")
                            ],
                          ))
                    ])))));
  }
}
