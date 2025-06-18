import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/map_helper.dart';

import '../../../providers/account_provider.dart';
import '../../../providers/otherProvider.dart';
import '../../../providers/provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../widgets/custom_text_form_field.dart';

class SellOnboarding extends ConsumerStatefulWidget {
  const SellOnboarding({super.key});

  @override
  ConsumerState createState() => _SellOnboardingState();
}

class _SellOnboardingState extends ConsumerState<SellOnboarding> {
  late OtherProvider otherProvider;
  late AccountProvider accountProvider;
  String? dp;
  String? dpName;

  LatLng? selectedLatLng;
  String? selectedAddress;

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController userName = TextEditingController();

  takePicture() async {
    final imagePicker = ImagePicker();
    File file = File(await imagePicker
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((pickedFile) => pickedFile!.path));

    setState(() {
      dp = file.path;
      dpName = file.path.split('/').last;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(()  {
      accountProvider.sellerFullNameController.text =
          accountProvider.currentUser.name ?? '';
      accountProvider.sellerPhoneNumber.text = accountProvider.currentUser.phoneNumber ?? '';
      accountProvider.sellerUsername.text = accountProvider.currentUser.username ?? '';

    });
  }

  @override
  Widget build(BuildContext context) {
    otherProvider = ref.watch(RiverpodProvider.otherProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Image
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      image: accountProvider.dp != null
                          ? DecorationImage(
                        image: FileImage(File(accountProvider.dp!)),
                        fit: BoxFit.cover,
                      )
                          : null,
                      shape: BoxShape.circle,
                      color: AppColors.greyLight,
                    ),
                    child: accountProvider.dp == null
                        ? Center(
                      child: SvgPicture.asset(
                        Assets.userProfile,
                        color: AppColors.grey,
                      ),
                    )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: (){
                        accountProvider.takePicture();
                      },
                      child: Container(
                        height: 32.h,
                        width: 32.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            /// Full Name
            labelText('Full Name'),
            CustomTextFormField(
              hint: "Enter your full name",
              controller: accountProvider.sellerFullNameController,
              enable: false,
            ),
            SizedBox(height: 20.h),

            /// User Name
            labelText('User Name'),
            CustomTextFormField(
              hint: "Enter your user name",
              controller: accountProvider.sellerUsername,
              enable: false,
            ),
            SizedBox(height: 20.h),

            /// Business Name
            labelText('Business Name (Optional)'),
            CustomTextFormField(
              controller: accountProvider.sellerBcName,
              hint: "Enter your business name",
            ),
            SizedBox(height: 20.h),

            /// Phone Number
            labelText('Phone Number'),
            CustomTextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              hint: "Enter your phone number",
              controller: accountProvider.sellerPhoneNumber,
            ),
            SizedBox(height: 20.h),

            /// BVN
            labelText('BVN'),
            CustomTextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              hint: "Enter your BVN number",
              controller: accountProvider.sellerBvn,
            ),
            SizedBox(height: 20.h),

            /// Bio
            labelText('Bio'),
            CustomTextFormField(
              controller: accountProvider.sellerBio,
              maxLines: 5,
              hint: "Tell buyers about yourself and your business",
            ),
            SizedBox(height: 20.h),

            SizedBox(height: 30.h),

            /// Next Button
            CustomButton(
              onPressed: () {
                // You can pass selectedLatLng and selectedAddress to the provider here if needed
                otherProvider.regPosition(1);
              },
              label: 'Next',
              fillColor: AppColors.primaryColor,
              buttonTextColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget labelText(String label) {
    return Text(
      label,
      style: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
