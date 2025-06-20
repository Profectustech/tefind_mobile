import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:te_find/utils/helpers.dart';
import '../../../providers/account_provider.dart';
import '../../../providers/provider.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class EditProfileDialog extends ConsumerStatefulWidget {
  const EditProfileDialog({super.key});

  @override
  ConsumerState<EditProfileDialog> createState() => _EditProfileDialogState();
}



class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {
  late AccountProvider accountProvider;
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController userName = TextEditingController();

  // Example state
  String? dp;
  String? dpName;
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
    accountProvider.updateUserprofileImage(dp, dpName);
  }

  @override
  void initState() {
    Future.microtask(() {
      accountProvider.updateUserNameController.text =
          accountProvider.currentUser.name ?? '';
      emailController.text =
          accountProvider.currentUser.email ?? '';
      phoneNumber.text = accountProvider.currentUser.phoneNumber ?? '';
      userName.text = accountProvider.currentUser.username ?? '';

    });
    super.initState();
  }

  @override
  void dispose() {
    accountProvider.updateUserNameController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style:
              GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 72.h,
                        width: 72.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: AppColors.primaryColor,
                          ),
                          // color: dp == null ? ColorThemes.cyan : null,
                          image: dp != null
                              ? DecorationImage(
                                  image: FileImage(File(dp!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: dp == null
                            ? Center(
                                child: Text(
                                  accountProvider.currentUser.name!.isNotEmpty
                                      ? accountProvider.currentUser.name![0]
                                          .toUpperCase()
                                      : '',
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            takePicture();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(width: 3, color: Colors.white),
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
                  Text(
                    'Tap to change profile photo',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildLabel('First Name'),
            const SizedBox(height: 5),
            CustomTextFormField(
              enable: false,
                controller: accountProvider.updateUserNameController,
                hint: 'Enter your full name'),
            const SizedBox(height: 10),
            _buildLabel('Last Name'),
            const SizedBox(height: 5),
            CustomTextFormField(
                controller: accountProvider.updateUserNameController,
                hint: 'Enter your full name'),
            const SizedBox(height: 10),
            _buildLabel('Username'),
            const SizedBox(height: 5),
            CustomTextFormField(
                controller: userName,
                enable: false,
            ),

            const SizedBox(height: 10),
            _buildLabel('Email'),
            const SizedBox(height: 5),
            CustomTextFormField(
              controller: emailController,
                enable: false,
                hint: ''),
            const SizedBox(height: 10),
            _buildLabel('Phone Number'),
            const SizedBox(height: 5),
            CustomTextFormField(
              controller: phoneNumber,
                enable: false,
                hint: ''),
            const SizedBox(height: 10),
            _buildLabel('Bio'),
            const SizedBox(height: 5),
            CustomTextFormField(
              maxLines: 3,
              //controller: accountProvider.lastNameController,
              hint: "Enter your Bio",
              // validator: Validators().isSignUpEmpty,
            ),
            // const SizedBox(height: 10),
            // _buildLabel('Location'),
            // const SizedBox(height: 5),
            // CustomTextFormField(hint: ''),
            SizedBox(height: 80.h),
            CustomButton(
              label: 'Save Change',
              fillColor: AppColors.primaryColor,
              onPressed: () async {
                if (accountProvider.updateUserNameController.text.isEmpty) {
                  showErrorToast(message: 'Please enter your full name');
                  return;
                }
                bool success = await accountProvider.updateUser();
                if (success) {
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 14),
    );
  }
}
