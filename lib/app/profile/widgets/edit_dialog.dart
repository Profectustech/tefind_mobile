import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
// import your CustomTextFormField and CustomButton and AppColors

class EditProfileDialog extends ConsumerStatefulWidget {
  const EditProfileDialog({super.key});

  @override
  ConsumerState<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {
  // Example state
  String initials = "LO";
  String? dp;
  String? dpName;
  String? dpSize;
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
      dpSize = getFileSize(file);
    });
  }

  String getFileSize(File dp) {
    int sizeInBytes = dp.lengthSync();
    double sizeInKB = sizeInBytes / 1024;
    double sizeInMB = sizeInKB / 1024;
    return sizeInMB > 1
        ? "${sizeInMB.toStringAsFixed(2)} MB"
        : "${sizeInKB.toStringAsFixed(2)} KB";
  }

  @override
  Widget build(BuildContext context) {
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
        padding:  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.h),
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
                                  "LO",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
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

            const SizedBox(height: 10),
            _buildLabel('Full Name'),
            const SizedBox(height: 5),
            CustomTextFormField(hint: ''),

            const SizedBox(height: 10),
            _buildLabel('Bio'),
            const SizedBox(height: 5),
            CustomTextFormField(hint: '', maxLines: 2),

            const SizedBox(height: 10),
            _buildLabel('Email'),
            const SizedBox(height: 5),
            CustomTextFormField(hint: ''),

            const SizedBox(height: 10),
            _buildLabel('Phone Number'),
            const SizedBox(height: 5),
            CustomTextFormField(
                hint: ''),
            const SizedBox(height: 10),
            _buildLabel('Location'),
            const SizedBox(height: 5),
            CustomTextFormField(hint: ''),

            const SizedBox(height: 20),
            CustomButton(
              label: 'Save Change',
              fillColor: AppColors.primaryColor,
              onPressed: () {
                // Save logic here
                Navigator.of(context).pop();
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
