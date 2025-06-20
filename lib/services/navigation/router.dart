import 'dart:io';

import 'package:flutter/material.dart';
import 'package:te_find/app/bottom_nav/bottom_nav.dart';
import 'package:te_find/app/bottom_nav/nav.dart';
import 'package:te_find/app/cart/cart_page.dart';
import 'package:te_find/app/forgotPassword/email_input_screen.dart';
import 'package:te_find/app/forgotPassword/set_new_password.dart';
import 'package:te_find/app/home/Sell/sell_items.dart';
import 'package:te_find/app/home/categories_page.dart';
import 'package:te_find/app/home/products/all_fashion_product.dart';
import 'package:te_find/app/home/confirmed_payment.dart';
import 'package:te_find/app/home/products/fashion_page.dart';
import 'package:te_find/app/home/pay_with_wallet.dart';
import 'package:te_find/app/home/products/product_detail.dart';
import 'package:te_find/app/home/products/view_all_products.dart';
import 'package:te_find/app/home/top_deal_fashion.dart';
import 'package:te_find/app/home/widgets/carousel_content.dart';
import 'package:te_find/app/login/login_screen.dart';
import 'package:te_find/app/notification.dart';
import 'package:te_find/app/onboarding/onboarding_screen_view.dart';
import 'package:te_find/app/orders/order_detail_page.dart';
import 'package:te_find/app/profile/add_new_address.dart';
import 'package:te_find/app/profile/listing_view_all.dart';
import 'package:te_find/app/settings/change_password_page.dart';
import 'package:te_find/app/settings/change_transaction_pin.dart';
import 'package:te_find/app/settings/delete_account.dart';
import 'package:te_find/app/profile/orders/my_oders_page.dart';
import 'package:te_find/app/profile/wishlight_page.dart';
import 'package:te_find/app/sign_up/set_password.dart';
import 'package:te_find/app/sign_up/signup.dart';
import 'package:te_find/app/sign_up/verify_account.dart';
import 'package:te_find/models/Products.dart';
import 'package:te_find/services/analytics_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/base_model.dart';
import 'package:te_find/utils/locator.dart';
import '../../app/cart/successful_transaction.dart';
import '../../app/forgotPassword/successful_reset_page.dart';
import '../../app/home/Sell/sell-stepper.dart';
import '../../app/home/all_brand_page.dart';
import '../../app/home/products/product_by_seller.dart';
import '../../app/profile/about_us.dart';
import '../../app/profile/help_and_support.dart';
import '../../app/profile/widgets/edit_dialog.dart';
import '../../app/settings/create_transaction_pin.dart';
import '../../app/settings/notifications_page.dart';
import '../../app/settings/privavy_and_security.dart';
import '../../app/settings/setting_page.dart';
import '../../models/BestSellerModel.dart';
import '../../models/CategoriesModel.dart';
import '../../models/MarketListModel.dart';
import '../../models/productModel.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case bottomNavigationRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const BottomNav(),
      );

    case loginScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const LoginScreen(),
      );

    case onBoardingScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const OnboardingScreen(),
      );
    case privacyAnsSecurity:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const PrivavyAndSecurity(),
      );

    case emailInputScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const EmailInputScreen(),
      );
    case confirmedPaymentPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ConfirmedPayment(),
      );
    case payWithWallet:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: PayWithWallet(),
      );
    case setNewPasswordRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SetNewPassword(),
      );
      case MyOrdersScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: MyOdersPage(),
      );


      case successfulResetPageScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow:  SuccessfulResetPage(),
      );
    case completeSignUp:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const CompleteSignUp(),
      );
    case setPasswordScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SetPasswordScreen(),
      );
    case signupScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Signup(),
      );

    case fashionScreenRoute:
      CategoriesModel categories = settings.arguments! as CategoriesModel;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: FashionPage(
          categories: categories,
        ),
      );
    case viewAllProducts:
      final headerName = settings.arguments! as String;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ViewAllProducts(
          headerName: headerName,
        ),
      );
    case productBySeller:
    //  final product = settings.arguments! as Products;
      return _getPageRoute(
          routeName: settings.name!,
          viewToShow: ProductBySeller(
             // product: product
          ));
    case productDetailScreenRoute:
      Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ProductDetail(
          newProducts: newProducts,
        ),
      );
    case categories:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: CategoriesPage(
         // newProducts: newProducts,
        ),
      );
      case carouselContent:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: CarouselContent(
         // newProducts: newProducts,
        ),
      );
      case sellItemScreens:
     Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SellItems(
          product: newProducts,
        ),
      );
      case orderDetailScreen:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: OrderDetailPage(
         // newProducts: newProducts,
        ),
      );

      case cartPageScreen:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: CartPage(
         // newProducts: newProducts,
        ),
      );
      case successfulTransactionscreen:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SuccessfulTransaction(
         // newProducts: newProducts,
        ),
      );
      case listingviewallProducts:
        List<Products> newProducts = settings.arguments! as List<Products>;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ListingViewAll(
          newProducts: newProducts,
        ),
      );
      case favouriteScreen:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: WishlistPage(
         // newProducts: newProducts,
        ),
      );
      case editProfileRoute:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: EditProfileDialog(
         // newProducts: newProducts,
        ),
      );
      case aboutUs:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AboutUs(
         // newProducts: newProducts,
        ),
      );   case helpAndSupport:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: HelpAndSupport(
         // newProducts: newProducts,
        ),
      );
      case notificationPage:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: NotificationPage(
         // newProducts: newProducts,
        ),
      ); case stepperExistingCustomer:
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SteperExistingCustomer(
         // newProducts: newProducts,
        ),
      );

    case allFashionScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AllFashionProduct(),
      );

    case topDealsFashionScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: TopDealFashion(),
      );

    case brandAvailableScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AllBrandPage(),
      );
    case notificationPageRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const NotificationPage(),
      );
    case addNewAddressScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const AddNewAddress(),
      );
    case settingsScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SettingPage(),
      );

    case changePasswordScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ChangePasswordPage(),
      );
    case notificationSettingScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const NotificationsPage(),
      );
    case deleteAccountScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const DeleteAccount(),
      );
    case changeTransactionPINScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ChangeTransactionPin(),
      );
   case createTransactionPin:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const CreateTransactionPin(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute(
    {required String routeName, required Widget viewToShow}) {
  locator<AnalyticsService>().setCurrentScreen(routeName);
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: Platform.isAndroid
                ? () async {
                    if (locator<BaseModel>().busy) {
                      return false;
                    } else {
                      return true;
                    }
                  }
                : null,
            child: viewToShow);
      });
}
