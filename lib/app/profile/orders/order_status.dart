import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/progress_bar_manager/utility_app_bar.dart';
import '../../widgets/custom_button.dart';

class OrderStatus extends ConsumerStatefulWidget {
  const OrderStatus({super.key});

  @override
  ConsumerState createState() => _OrderStatusState();
}

class _OrderStatusState extends ConsumerState<OrderStatus> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: UtilityAppBar(text: "Order Status"),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.orderIcon,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Order ID",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "SALDKF83984",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Assets.DeliveredOrder),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Delivered",
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Order Details",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey, width: 1),
                          image: DecorationImage(
                              image: AssetImage(Assets.Tshirt),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ashluxe Tshirt Kalakuta",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "QTY : 1",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "N15,000.00",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                    label: "Buy Again",
                    fillColor: AppColors.primaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: AppColors.black,
                ),
                Text(
                  "Summary",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Divider(
                  color: AppColors.black,
                ),
                SizedBox(
                  height: 10.h,
                ),
                InfoOrderWidget(
                  label: 'Subtotal',
                  value: 'N15,000.00',
                ),
                SizedBox(
                  height: 5.h,
                ),
                InfoOrderWidget(
                  label: 'Delivery Fee',
                  value: 'N1,840.00',
                ),
                SizedBox(
                  height: 5.h,
                ),
                InfoOrderWidget(
                  label: 'Service Fee',
                  value: 'N1000.00',
                ),
                SizedBox(
                  height: 5.h,
                ),
                InfoOrderWidget(
                  label: 'Total:',
                  value: 'N17,840.00',
                ),
                SizedBox(
                  height: 5.h,
                ),
                InfoOrderWidget(
                  label: 'Payment Method',
                  value: 'Paystack',
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: AppColors.black,
                ),
                Text(
                  "Delivery Information",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Divider(
                  color: AppColors.black,
                ),
                SizedBox(
                  height: 10.h,
                ),
                InfoOrderWidget(
                  label: 'Delivery Method',
                  value: 'Door Step Delivery',
                ),
                SizedBox(
                  height: 5.h,
                ),
                InfoOrderWidget(
                  label: 'Delivery Address',
                  value: 'Michelle Customer10,\nTest Avenue, Lekki,\nLagos.',
                ),
                SizedBox(
                  height: 5.h,
                ),
                InfoOrderWidget(
                  label: 'Contact No.:',
                  value: '+2348023143557',
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    height: 52,
                    decoration: BoxDecoration(
                        color: AppColors.greenLightest,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(Assets.returnPolicy),
                        SizedBox(
                          width: 5.w,
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black), // Default text style
                            children: [
                              TextSpan(
                                text:
                                    "The return period will end on 30 Jan, 2025 - \n",
                              ),
                              TextSpan(
                                text: "Access our Return Policy",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Order Status",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Timeline",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(
                  height: 430,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      LiveTrackingDelivery("Order Placed", "24 Dec, 2024", isLast: false),
                      LiveTrackingDelivery("Order Confirmed", "24 Dec, 2024", isLast: false),
                      LiveTrackingDelivery("Waiting to be Shipped", "24 Dec, 2024", isLast: false),
                      LiveTrackingDelivery("Order Shipped", "24 Dec, 2024", isLast: false),
                      LiveTrackingDelivery("Out for Delivery", "24 Dec, 2024", isLast: false),
                      LiveTrackingDelivery("Delivered", "24 Dec, 2024", isLast: true),
                    ],
                  ),
                ),
                Text(
                  "Live Tracking",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 547,
                  decoration: BoxDecoration(
                      color: AppColors.greenLightest,
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(width: 2, color: AppColors.primaryColor)),
                )
              ],
            )),
      ),
    );
  }

  Widget LiveTrackingDelivery(String title, String date, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              DottedLine(
                direction: Axis.vertical,
                dashLength: 4,
                dashGapLength: 4,
                lineLength: 60,
                lineThickness: 2,
                dashColor: AppColors.primaryColor,
              ),
          ],
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

class InfoOrderWidget extends StatelessWidget {
  final String label;
  final String value;
  const InfoOrderWidget({
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
          ),
        ),
      ],
    );
  }}
