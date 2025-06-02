import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
TextEditingController _firstNameController = TextEditingController(text: accountProvider.currentUser.firstName);
TextEditingController _lastNameController = TextEditingController(text: accountProvider.currentUser.lastName);
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
    Future.microtask(() {
      _firstNameController = TextEditingController(text: accountProvider.currentUser.firstName);
      _lastNameController =  TextEditingController(text: accountProvider.currentUser.lastName);
    });
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
      appBar: UtilityAppBar(
        text: "Add Delivery Address",
        hasActions: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              CustomTextFormField(
                color: Colors.transparent,
                label: 'First Name*',
                controller: _firstNameController,
                validator: Validators().isEmpty,
              ),
              SizedBox(height: 13.h),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'Last Name*',
                controller: _lastNameController,
                validator: Validators().isEmpty,
              ),
              SizedBox(height: 13.h),
              IntlPhoneField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number*',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.w, color: Colors.grey),
                  ),
                ),
                initialCountryCode: 'NG',
                onChanged: (phone) {
                  _phoneController.text = phone.number;
                },
              ),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'Company Name',
                controller: _companyNameController,
              ),
              SizedBox(height: 13.h),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'Building Number',
                controller: _buildingNumber,
                inputType: TextInputType.number,
              ),
              SizedBox(height: 13.h),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'Street Address*',
                controller: _streetNumber,
                validator: Validators().isEmpty,
              ),
              SizedBox(height: 13.h),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'City*',
                controller: _cityContrller,
                validator: Validators().isEmpty,
              ),
              SizedBox(height: 13.h),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'State*',
                controller: _stateController,
                validator: Validators().isEmpty,
              ),
              SizedBox(height: 13.h),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'Postal Code',
                controller: _postalCode,
                inputType: TextInputType.number,
              ),
              SizedBox(height: 13.h),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'Address Title*',
                controller: _addressTitleController,
                validator: Validators().isEmpty,
              ),
              SizedBox(height: 13.h),
              CustomTextFormField(
                color: Colors.transparent,
                label: 'Note to Driver',
                controller: _noteToDriverController,
              ),
              SizedBox(height: 13.h),
              CheckboxListTile(
                side: BorderSide(color: Colors.grey),
                value: _isChecked,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isChecked = newValue ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.black,
                checkColor: AppColors.white,
                tristate: true,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Set as default",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                  label: "Save Address",
                  fillColor: AppColors.primaryColor,
                  onPressed: () {
                    accountProvider.createCustomerAddress(
                        _firstNameController.text,
                        _lastNameController.text,
                        _phoneController.text,
                        _companyNameController.text,
                        _buildingNumber.text,
                        _streetNumber.text,
                        _addressTitleController.text,
                        _cityContrller.text,
                        _postalCode.text,
                        _stateController.text,
                        _noteToDriverController.text,
                        _isChecked? 1 : 0);
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
