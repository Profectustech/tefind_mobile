import 'dart:io';

import 'package:flutter/material.dart';
import 'package:te_find/app/bottom_nav/bottom_nav.dart';
import 'package:te_find/app/bottom_nav/nav.dart';
import 'package:te_find/app/forgotPassword/email_input_screen.dart';
import 'package:te_find/app/forgotPassword/set_new_password.dart';
import 'package:te_find/app/home/categories_page.dart';
import 'package:te_find/app/home/products/all_fashion_product.dart';
import 'package:te_find/app/home/check_out.dart';
import 'package:te_find/app/home/confirmed_payment.dart';
import 'package:te_find/app/home/products/fashion_page.dart';
import 'package:te_find/app/home/market/all_market_page.dart';
import 'package:te_find/app/home/pay_with_wallet.dart';
import 'package:te_find/app/home/products/product_detail.dart';
import 'package:te_find/app/home/products/view_all_products.dart';
import 'package:te_find/app/home/top_deal_fashion.dart';
import 'package:te_find/app/home/widgets/carousel_content.dart';
import 'package:te_find/app/login/login_screen.dart';
import 'package:te_find/app/negotiation%20screen/negotiations.dart';
import 'package:te_find/app/notification.dart';
import 'package:te_find/app/onboarding/onboarding_screen_view.dart';
import 'package:te_find/app/profile/add_new_address.dart';
import 'package:te_find/app/profile/faq_page.dart';
import 'package:te_find/app/profile/help_page.dart';
import 'package:te_find/app/profile/legal_terms_page.dart';
import 'package:te_find/app/profile/privacy_policy_page.dart';
import 'package:te_find/app/profile/term_of_use.dart';
import 'package:te_find/app/settings/change_password_page.dart';
import 'package:te_find/app/settings/change_transaction_pin.dart';
import 'package:te_find/app/settings/delete_account.dart';
import 'package:te_find/app/profile/delivery_address.dart';
import 'package:te_find/app/profile/orders/my_oders_page.dart';
import 'package:te_find/app/profile/personal_detail_page.dart';
import 'package:te_find/app/settings/setting_page.dart';
import 'package:te_find/app/profile/wallet_page.dart';
import 'package:te_find/app/profile/wishlight_page.dart';
import 'package:te_find/app/sign_up/set_password.dart';
import 'package:te_find/app/sign_up/set_up_profile.dart';
import 'package:te_find/app/sign_up/signup.dart';
import 'package:te_find/app/sign_up/verify_account.dart';
import 'package:te_find/app/sign_up/verify_email_or_password.dart';
import 'package:te_find/models/Products.dart';

import 'package:te_find/services/analytics_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/base_model.dart';
import 'package:te_find/utils/locator.dart';

import '../../app/forgotPassword/successful_reset_page.dart';
import '../../app/home/all_brand_page.dart';
import '../../app/home/products/product_by_seller.dart';
import '../../app/profile/sellers/seller_store_page.dart';
import '../../app/profile/sellers/sellers_page.dart';
import '../../app/settings/notifications_page.dart';
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

    case emailInputScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const EmailInputScreen(),
      );
    // newly added
    case setUpProfileRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SetUpProfile(),
      );
    case checkoutScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: CheckOutPage(),
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
    case verifyEmailorPasswordRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: VerifyEmailOrPassword(),
      );
    case PersonalDetail:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: PersonalDetailPage(),
      );
    case MyOrdersScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: MyOdersPage(),
      );
    case WalletPageScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: WalletPage(),
      );
    case WishlistScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: WishlistPage(),
      );
    case deliveryAddressScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: DeliveryAddress(),
      );
    //

      case successfulResetPageScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow:  SuccessfulResetPage(),
      );
    case verificationScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const VerificationScreen(),
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
  //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ProductDetail(
         // newProducts: newProducts,
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
    case helpScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const HelpPage(),
      );
    case legalTermsScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const LegalTermsPage(),
      );
    case privacyPolicyScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: PrivacyPolicyPage(),
      );

    case termsOfUseScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: TermOfUse(),
      );

    case sellersPageScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SellersPage(),
      );

      case sellersStorePage:
        final product = settings.arguments! as BestSellerModel;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SellerStorePage(product: product),
      );
    case FaqScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: FaqPage(),
      );
    case negotiationScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: Negotiations(),
      );

    case allMarketPage:
      MarketListModel model = settings.arguments! as MarketListModel;

      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AllMarketPage(model: model),
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
