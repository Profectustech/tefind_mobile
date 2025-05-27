import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saleko/app/widgets/back_button.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/app/widgets/custom_text_form_field.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/animated_navigation.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/screen_size.dart';
import 'package:image_picker/image_picker.dart';

class LoadingWayBill2 extends ConsumerStatefulWidget {
  const LoadingWayBill2({super.key});

  @override
  ConsumerState<LoadingWayBill2> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends ConsumerState<LoadingWayBill2> {
  final AnimatedNavigation _animatedNavigation = AnimatedNavigation();
  final NavigatorService _navigatorService = NavigatorService();

  late AccountProvider accountProvider;
  String counter = "0";
  String? imagePath;
  String? imageMeter;
  bool success = false;
  pickSignature() async {
    final imagePicker = ImagePicker();
    File file = File(await imagePicker
        .pickImage(
          source: ImageSource.gallery,
        )
        .then((pickedFile) => pickedFile!.path));
    setState(() {
      setState(() {
        imagePath = file.path;
      });
    });
  }

  pickMeter() async {
    final imagePicker = ImagePicker();
    File file = File(await imagePicker
        .pickImage(
          source: ImageSource.gallery,
        )
        .then((pickedFile) => pickedFile!.path));
    setState(() {
      setState(() {
        imageMeter = file.path;
      });
    });
  }

  // Uint8List? data;
  // String? dataSubmit;
  // final SignatureController _controller = SignatureController(
  //   penStrokeWidth: 2,
  //   penColor: Colors.white,
  //   exportBackgroundColor: AppColors.white,
  //   exportPenColor: Colors.black,
  //   onDrawStart: () => print('onDrawStart called!'),
  //   onDrawEnd: () => print('onDrawEnd called!'),
  // );
  // @override
  // void initState() {
  //   super.initState();
  //   _controller.addListener(() => print('Value changed'));
  // }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
        body: Stack(
      children: [
        // GoogleMap(
        //   myLocationButtonEnabled: true,
        //   mapType: MapType.normal,
        //   myLocationEnabled: true,
        //   initialCameraPosition: CameraPosition(
        //     target: LatLng(
        //       accountProvider.userPosition.latitude,
        //       accountProvider.userPosition.longitude,
        //     ),
        //     zoom: 19.0,
        //   ),
        // ),
        Positioned(
          top: 60.h,
          left: 10.w,
          right: 24.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(
            top: Responsive.height(context) / 4,
          ),
          // margin: EdgeInsets.all(20),
          width: Responsive.width(context),
          height: 600.h,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
              ],
              color: Color(0xffF7F7F6),
              // border: Border.all(
              //  // color: AppColors.buttonDisabled,
              //   width: 1.5,
              // ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              )),
          child: SingleChildScrollView(
              child: success
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Submission successful",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SvgPicture.asset(
                          "assets/images/done.svg",
                          width: 200,
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        CustomButton(
                          fillColor: AppColors.greenFade,
                          buttonTextColor: AppColors.greenSecond,
                          label: "Go to Home page",
                          onPressed: () {
                            _navigatorService
                                .pushAndRemoveUntil("IHSHomeScreen");
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        accountProvider.role == "Depo Analyst"
                            ? Text(
                                "Loading WayBill",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )
                            : Text(
                                "Dispense WayBill",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Name of Driver",
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(),
                        SizedBox(
                          height: 20,
                        ),
                        // InkWell(
                        //     onTap: () {
                        //       pickSignature();
                        //     },
                        //     child: Container(
                        //       width: Responsive.width(context),
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           border: Border.all(
                        //             color: AppColors.greenFade,
                        //             width: 1.5,
                        //           ),
                        //           borderRadius: BorderRadius.all(
                        //             Radius.circular(10.r),
                        //           )),
                        //       padding: EdgeInsets.all(20),
                        //       child: imagePath == null
                        //           ? Column(
                        //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 CircleAvatar(
                        //                   backgroundColor: AppColors.greenFade,
                        //                   child: SvgPicture.asset(
                        //                     "assets/images/edit.svg",
                        //                     // width: 10,
                        //                   ),
                        //                 ),
                        //                 SizedBox(
                        //                   height: 20,
                        //                 ),
                        //
                        //               ],
                        //             )
                        //           : Image.file(File(imagePath!)),
                        //     )),

                        Text(
                          "Input the driver signature",
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // data == null
                        //     ? Column(
                        //         children: [
                        //           Signature(
                        //             controller: _controller,
                        //             height: 300,
                        //             backgroundColor: AppColors.primaryColor,
                        //           ),
                        //           Container(
                        //             decoration: const BoxDecoration(
                        //                 color: Colors.black),
                        //             child: Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceEvenly,
                        //               mainAxisSize: MainAxisSize.max,
                        //               children: <Widget>[
                        //                 IconButton(
                        //                   icon: const Icon(Icons.check),
                        //                   color: Colors.white,
                        //                   onPressed: () async {
                        //                     if (_controller.isNotEmpty) {
                        //                       var sign = await _controller
                        //                           .toPngBytes();
                        //                       setState(() {
                        //                         data = sign;
                        //                         dataSubmit =
                        //                             base64.encode(sign!);
                        //                       });
                        //                     }
                        //                   },
                        //                 ),
                        //                 IconButton(
                        //                   icon: const Icon(Icons.undo),
                        //                   color: Colors.white,
                        //                   onPressed: () {
                        //                     setState(() => _controller.undo());
                        //                   },
                        //                 ),
                        //                 IconButton(
                        //                   icon: const Icon(Icons.redo),
                        //                   color: Colors.white,
                        //                   onPressed: () {
                        //                     setState(() => _controller.redo());
                        //                   },
                        //                 ),
                        //                 IconButton(
                        //                   icon: const Icon(Icons.clear),
                        //                   color: Colors.white,
                        //                   onPressed: () {
                        //                     setState(() => _controller.clear());
                        //                   },
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     : Container(),
                        // data != null
                        //     ? Center(
                        //         child: Image.memory(
                        //         data!,
                        //         // color: AppColors.white,
                        //       ))
                        //     : Container(),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        InkWell(
                            onTap: () {
                              pickMeter();
                            },
                            child: Container(
                              width: Responsive.width(context),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: AppColors.greenFade,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  )),
                              padding: EdgeInsets.all(20),
                              child: imageMeter == null
                                  ? Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColors.greenFade,
                                          child: SvgPicture.asset(
                                            "assets/images/camera.svg",
                                            // width: 10,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Take a picture of the meter",
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Image.file(File(imageMeter!)),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          fillColor: AppColors.primaryColor,
                          label: "Next",
                          onPressed: () {
                            setState(() {
                              success = true;
                            });
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    )),
        )
      ],
    ));
  }
}
