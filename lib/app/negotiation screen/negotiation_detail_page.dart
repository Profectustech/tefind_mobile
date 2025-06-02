import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/negotiation%20screen/accept_bottomNav.dart';
import 'package:te_find/models/message_models.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';

import '../../utils/assets_manager.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/custom_button.dart';
import 'negotiation_bottomNav1.dart';

class NegotiationDetailPage extends ConsumerStatefulWidget {
  const NegotiationDetailPage({super.key});

  @override
  ConsumerState createState() => _NegotiationDetailPageState();
}

bool isNegotiating = true;

Widget? bottomNavigationWidget;

class _NegotiationDetailPageState extends ConsumerState<NegotiationDetailPage> {
  @override
  void initState() {
    super.initState();
    bottomNavigationWidget = InitialBottomNavigator(
      accept: onAccept,
      cancel: onCancel,
    );
  }

  void onAccept() {
    setState(() {
      bottomNavigationWidget = AcceptBottomnav();
      Navigator.pop(context);
    });
  }

  void onCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UtilityAppBar(text: "Details"),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 104.h), // Space below the fixed container
                    Text(
                      "Negotiation Begins",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return Align(
                          alignment: message.isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              crossAxisAlignment: message.isUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.end,
                              children: [
                                if (!message.isUser)
                                  Container(
                                    height: 27,
                                    width: 27,
                                    decoration: BoxDecoration(
                                        color: AppColors.greenFade,
                                        shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                        Assets.customerService),
                                  ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: message.isUser
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      // Message content container
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: message.isUser
                                              ? AppColors.greyLight
                                              : AppColors.primaryColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(12),
                                            topRight: const Radius.circular(12),
                                            bottomLeft: message.isUser
                                                ? const Radius.circular(12)
                                                : Radius.zero,
                                            bottomRight: message.isUser
                                                ? Radius.zero
                                                : const Radius.circular(12),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              message.content,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: message.isUser
                                                    ? AppColors.black
                                                    : AppColors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              message.timestamp,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: message.isUser
                                                      ? AppColors.grey
                                                      : AppColors.greenFade),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        message.sender,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                if (message.isUser)
                                  Container(
                                    height: 27,
                                    width: 27,
                                    decoration: BoxDecoration(
                                        color: AppColors.greenFade,
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.person),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            // Fixed product detail container
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  CustomBottomSheet.show(
                    context: context,
                    isDismissible: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Details",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close)),
                            ],
                          ),
                          Divider(),
                          SizedBox(
                            height: 30.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 121,
                                width: 121,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.55, color: AppColors.grey)),
                                child: Image.asset(
                                  Assets.laptopPowerbank,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "NP Sound Speaker NPFKJSK",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Qty: 3",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.grey),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Original Price",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "#\900,000",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: AppColors.grey,
                                            decorationThickness: 2,
                                            color: AppColors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "each",
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Vendor",
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "SmithField",
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Negotiation Status",
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      isNegotiating
                                          ? Text(
                                              "Negotiation Expired",
                                              style: TextStyle(
                                                  color: AppColors.red,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Text(
                                              "Ongoing Negotiation",
                                              style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: 84.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.55, color: AppColors.grey),
                        ),
                        child: Image.asset(
                          Assets.laptopPowerbank,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "NP Sound Speaker NPFKJSK",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            "Original Price: ₦900,000.00",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: AppColors.grey),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: bottomNavigationWidget);
  }
}
