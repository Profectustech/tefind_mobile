// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:te_find/app/profile/orders/order_status.dart';
// import 'package:te_find/models/product.dart';
// import 'package:te_find/utils/app_colors.dart';
// import 'package:te_find/utils/assets_manager.dart';
//
// class orderListView extends StatelessWidget {
//   const orderListView(
//       {super.key, required this.allProducts, required this.index});
//
//   final List<Product> allProducts;
//   final int index;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(5),
//                       image: DecorationImage(
//                           image: AssetImage(Assets.Tshirt),
//                           fit: BoxFit.cover))),
//               SizedBox(
//                 width: 10.w,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   allProducts[index].title == "Delivered"
//                       ? Container(
//                           decoration: BoxDecoration(
//                               color: AppColors.primaryColor,
//                               borderRadius: BorderRadius.circular(3)),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 5.0, vertical: 4),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset(Assets.DeliveredOrder),
//                                 SizedBox(
//                                   width: 5.w,
//                                 ),
//                                 Text(
//                                   "Delivered",
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                     color: AppColors.white,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       : allProducts[index].title == "Cancel"
//                           ? Container(
//                               decoration: BoxDecoration(
//                                   color: AppColors.grey,
//                                   borderRadius: BorderRadius.circular(3)),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 5.0, vertical: 4),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset(Assets.canceledOrder),
//                                     SizedBox(
//                                       width: 5.w,
//                                     ),
//                                     Text(
//                                       "Canceled",
//                                       style: TextStyle(
//                                         fontSize: 10,
//                                         color: AppColors.white,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.orange,
//                                   borderRadius: BorderRadius.circular(3)),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 5.0, vertical: 4),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     SvgPicture.asset(Assets.OutforDelivery),
//                                     SizedBox(
//                                       width: 5.w,
//                                     ),
//                                     Text(
//                                       "Out for Delivery",
//                                       style: TextStyle(
//                                         fontSize: 10,
//                                         color: AppColors.primaryColor,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                   SizedBox(
//                     height: 5.w,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Ashluxe Tshirt Kalakuta",
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Spacer(),
//               allProducts[index].title == "Cancel"
//                   ? SizedBox.shrink()
//                   : allProducts[index].title == "Delivered"
//                       ? Container(
//                           height: 26,
//                           width: 76,
//                           decoration: BoxDecoration(
//                               color: AppColors.primaryColor,
//                               borderRadius: BorderRadius.circular(5)),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 5, horizontal: 10),
//                             child: Text(
//                               "View Timeline",
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.white),
//                             ),
//                           ),
//                         )
//                       : GestureDetector(
//                 onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderStatus())); },
//
//                         child: Container(
//                             height: 26,
//                             width: 76,
//                             decoration: BoxDecoration(
//                                 color: AppColors.primaryColor,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 10),
//                               child: Text(
//                                 "Track item",
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.white),
//                               ),
//                             ),
//                           ),
//                       )
//             ],
//           ),
//
//           SizedBox(
//             height: 5.h,
//           ),
//           Row(
//             children: [
//               SvgPicture.asset(Assets.orderIcon),
//               SizedBox(
//                 width: 5.w,
//               ),
//               Text(
//                 "Order ID",
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.grey),
//               ),
//               SizedBox(
//                 width: 5.w,
//               ),
//               Text(
//                 "SALDKF83984",
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.black),
//               ),
//               SizedBox(
//                 width: 16.w,
//               ),
//               Text(
//                 "Estimated Delivery Date",
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.grey),
//               ),
//               SizedBox(
//                 width: 5.w,
//               ),
//               Text(
//                 "Jan 24, 2025",
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.black),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           Divider() //
//         ],
//       ),
//     );
//   }
// }
