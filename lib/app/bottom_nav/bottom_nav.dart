// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:te_find/app/profile/profile.dart';
// import 'package:te_find/app/widgets/custom_bottom_sheet.dart';
// import 'package:te_find/providers/provider.dart';
// import 'package:te_find/utils/app_colors.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:te_find/providers/account_provider.dart';

// class BottomNavigation extends ConsumerStatefulWidget {
//   const BottomNavigation({super.key});

//   @override
//   ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends ConsumerState<BottomNavigation> {
//   int _selectedIndex = 0;
//   late AccountProvider accountProvider;

//   void _onPageChange(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     accountProvider = ref.watch(RiverpodProvider.accountProvider);
//     Widget getViewForIndexHome(int index) {
//       switch (index) {
//         case 0:
//         // return const Profile();
//         case 1:
//         // return const Profile();
//         // case 2:
//         //   return Container();
//         case 3:
//         // return const Profile();
//         case 4:
//         // return const Profile();
//         default:
//         // return const Profile();
//       }
//     }

//     List<Widget> pages = [
//       // const Profile(),
//       // const Profile(),
//       // const Profile(),
//       // const Profile()
//     ];

//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: getViewForIndexHome(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         onTap: _onPageChange,
//         // backgroundColor: AppColors.white,
//         items: [
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               _selectedIndex == 0
//                   ? "assets/images/home_active.svg"
//                   : "assets/images/home.svg",
//               width: 23.0,
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               _selectedIndex == 1
//                   ? "assets/images/search_active.svg"
//                   : "assets/images/search.svg",
//               width: 23.0,
//             ),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Container(
//               height: 23,
//             ),
//             label: 'Order',
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               _selectedIndex == 3
//                   ? "assets/images/message_active.svg"
//                   : "assets/images/message.svg",
//               width: 23.0,
//             ),
//             label: 'Support',
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               _selectedIndex == 4
//                   ? "assets/images/user_active.svg"
//                   : "assets/images/user.svg",
//               width: 23.0,
//             ),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: AppColors.blueTextColor,
//         unselectedLabelStyle: const TextStyle(color: AppColors.grey),
//       ),
//     );
//   }
// }
