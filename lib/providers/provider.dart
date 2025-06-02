import 'package:te_find/app/bottom_nav/nav_service.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/app_nav_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:te_find/providers/payment_provider.dart';
import 'package:te_find/providers/product_provider.dart';

class RiverpodProvider {
  static final appNavNotifier =
      ChangeNotifierProvider.autoDispose<AppNavNotifier>(
    (ref) => AppNavNotifier(),
  );

  static final accountProvider =
      ChangeNotifierProvider<AccountProvider>((ref) => AccountProvider());
  static final navStateProvider =
      ChangeNotifierProvider<NavStateProvider>((ref) => NavStateProvider());
  static final productProvider = ChangeNotifierProvider<ProductProvider>(
      (ref) => ProductProvider.init(reader: ref));
  static final paymentProvider = ChangeNotifierProvider<PaymentProvider>(
      (ref) => PaymentProvider.init(reader: ref));
}
