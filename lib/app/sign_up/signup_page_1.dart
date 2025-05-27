import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/app/widgets/custom_text_form_field.dart';
import 'package:saleko/utils/helpers.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

class Signup1Screen extends ConsumerStatefulWidget {
  const Signup1Screen({super.key});

  @override
  ConsumerState<Signup1Screen> createState() => _Signup1ScreenState();
}

final NavigatorService _navigation = NavigatorService();
void login() {
  _navigation.navigateTo(loginScreenRoute);
}

class _Signup1ScreenState extends ConsumerState<Signup1Screen> {
  late AccountProvider accountProvider;


  @override
  void initState() {
    super.initState();
    Future.microtask((){
      accountProvider.emailController.addListener(accountProvider.checkActive);

    });
  }
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            centerTitle: true,
            text: 'Login',
            onTap: () {
              login();
            }),
        body: Form(
          key: accountProvider.formKeySignup,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 20.0, left: 20, top: 10, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your email or phone number",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "We will sent an OTP verification to you",
                  style: GoogleFonts.sourceSans3(
                      textStyle: TextStyle(fontSize: 14, color: Colors.grey)),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    value: accountProvider.emailPhone,
                    icon: const Icon(
                      Icons.expand_more,
                      size: 28,
                    ),
                    hint: const Text(
                      'Email or phone number',
                      style: TextStyle(
                          fontWeight: FontWeight.w200, color: Colors.grey),
                    ),
                    items: accountProvider.dropDownItems.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      accountProvider.setEmailPhone(newValue ?? '');
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (accountProvider.emailPhone == 'Email Address')
                  CustomTextFormField(
                    validator: Validators().isEmail,
                    controller: accountProvider.emailController,
                    inputType: TextInputType.emailAddress,
                    label: "Email Address",
                  ),
                if (accountProvider.emailPhone == 'Phone Number')
                  IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                    ),
                    initialCountryCode: 'NG',
                    onChanged: (phone) {
                      accountProvider.phoneController.text = phone.completeNumber;
                    },
                    onSaved: (phone) {
                      accountProvider.phoneController.text = phone!.completeNumber;
                    },
                    showCountryFlag: true,
                    showDropdownIcon: true,
                  ),



                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: CustomButton(
                      fillColor:  accountProvider.emailController.text.isNotEmpty || accountProvider.phoneController.text.isNotEmpty
                          ? AppColors.primaryColor
                          : AppColors.grey,
                      label: 'Send code',
                      onPressed: accountProvider.startRegistration),
                )
              ],
            ),
          ),
        ));
  }
}
