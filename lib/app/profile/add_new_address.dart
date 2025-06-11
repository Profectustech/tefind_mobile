import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';

import '../../utils/app_colors.dart';
import '../../utils/helpers.dart';
import '../../utils/progress_bar_manager/utility_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class AddNewAddress extends ConsumerStatefulWidget {
  const AddNewAddress({super.key});

  @override
  ConsumerState createState() => _AddNewAddressState();
}

late AccountProvider accountProvider;
TextEditingController _firstNameController = TextEditingController();
TextEditingController _lastNameController = TextEditingController();
TextEditingController _companyNameController = TextEditingController();
TextEditingController _buildingNumber = TextEditingController();
TextEditingController _streetNumber = TextEditingController();
TextEditingController _cityContrller = TextEditingController();
TextEditingController _stateController = TextEditingController();
TextEditingController _postalCode = TextEditingController();
TextEditingController _addressTitleController = TextEditingController();
TextEditingController _noteToDriverController = TextEditingController();
TextEditingController _phoneController = TextEditingController();
bool _isChecked = false;




class _AddNewAddressState extends ConsumerState<AddNewAddress> {
  @override
  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   _firstNameController = TextEditingController(text: accountProvider.currentUser.firstName);
    //   _lastNameController =  TextEditingController(text: accountProvider.currentUser.lastName);
    // });
  }

  @override
  void dispose() {
    // _firstNameController.clear();
    // _lastNameController.clear();
    _companyNameController.clear();
    _buildingNumber.clear();
    _streetNumber.clear();
    _stateController.clear();
    _cityContrller.clear();
    _postalCode.clear();
    _addressTitleController.clear();
    _noteToDriverController.clear();
    _phoneController.clear();
    _isChecked = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: UtilityAppBar(
        text: "Add New Address",
        hasActions: false,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                color: Colors.transparent,
                hint: 'Enter full name',
                controller: _firstNameController,
                validator: Validators().isEmpty,
              ),

              SizedBox(height: 13.h),
              Text(
                'Phone Number',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                color: Colors.transparent,
                hint: 'Enter Phone Number',
                controller: _firstNameController,
                validator: Validators().isEmpty,
              ),
              // IntlPhoneField(
              //   controller: _phoneController,
              //   decoration: InputDecoration(
              //     labelText: 'Enter Phone Number',
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(width: 1.w, color: AppColors.greyLight),
              //     ),
              //   ),
              //   initialCountryCode: 'NG',
              //   onChanged: (phone) {
              //     _phoneController.text = phone.number;
              //   },
              // ),
              SizedBox(height: 13.h),
              Text(
                'Address',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextFormField(
              color: Colors.transparent,
              hint: 'Enter Street address',
              controller: _firstNameController,
              validator: Validators().isEmpty,
            ),
              SizedBox(height: 13.h),
              Text(
                'City',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'Enter City',
                controller: _cityContrller,
                validator: Validators().isEmpty,
              ),
              SizedBox(height: 13.h),
              Text(
                'State/Region',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'Enter State/Region',
                controller: _stateController,
                validator: Validators().isEmpty,
              ),
              SizedBox(height: 13.h),
              Text(
                'Enter Country',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),

              SizedBox(height: 13.h),
              CheckboxListTile(
                side: BorderSide(color: Colors.grey),
                value: _isChecked,
                activeColor: AppColors.primaryColor,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isChecked = newValue ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                checkColor: AppColors.white,
                tristate: true,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Set as default",
                  style: GoogleFonts.roboto(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                  label: "Add Address",
                  fillColor: AppColors.primaryColor,
                  onPressed: () {

                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
