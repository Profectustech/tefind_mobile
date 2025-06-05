import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/utils/app_colors.dart';

import '../../utils/assets_manager.dart';
import '../../utils/progress_bar_manager/utility_app_bar.dart';

class HelpAndSupport extends ConsumerStatefulWidget {
  const HelpAndSupport({super.key});

  @override
  ConsumerState createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends ConsumerState<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UtilityAppBar(
        text: "Help & Support",
        hasActions: false,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Popular Topics',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              spacing: 10.w,
              children: [
                Expanded(
                  child: PopularTopicWidget(
                    topic: 'Payment Issues',
                    imagePath: Assets.paymentIssues,
                  ),
                ),
                Expanded(
                  child: PopularTopicWidget(
                    topic: 'Shipping & Delivery',
                    imagePath: Assets.shippingIcon,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              spacing: 10.w,
              children: [
                Expanded(
                  child: PopularTopicWidget(
                    topic: 'Returns & Refunds',
                    imagePath: Assets.returnIcon,
                  ),
                ),
                Expanded(
                  child: PopularTopicWidget(
                    topic: 'Buyer Protection',
                    imagePath: Assets.privacyIcon,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Support Options',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            AboutUsOptions(
              title: 'FAQ',
              image: 'faq',
            ),
            SizedBox(
              height: 10.h,
            ),
            AboutUsOptions(
              title: 'Contact Support',
              image: 'support',
            ),
            SizedBox(
              height: 10.h,
            ),
            AboutUsOptions(
              title: 'Live Chat',
              image: 'liveChat',
              isAvailable: true,
            ),
            SizedBox(
              height: 10.h,
            ),
            AboutUsOptions(
              title: 'Help Center',
              image: 'helpCenter',
            ),
          ],
        ),
      ),
    );
  }
}

class PopularTopicWidget extends StatelessWidget {
  final String topic;
  final String imagePath;

  const PopularTopicWidget({
    super.key,
    required this.topic,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148.w,
      height: 65.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(color: AppColors.greyLight, borderRadius:
      BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(imagePath),
          SizedBox(height: 5.h,),
          Text(
            topic,
            style: GoogleFonts.roboto(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],

      ),


    );
  }
}
class AboutUsOptions extends StatelessWidget {
  final String title;
  final String image;
  final bool isAvailable;

  const AboutUsOptions({
    super.key,
    required this.title,
    required this.image,
    this.isAvailable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.greyLight,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/$image.svg',
                color: AppColors.primaryColor,
                height: 15,
              ),
            ),
            SizedBox(width: 15.w),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            if (isAvailable)
              Text(
                'Available',
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
              ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
