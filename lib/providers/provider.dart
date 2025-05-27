import 'package:saleko/app/bottom_nav/nav_service.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/app_nav_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saleko/providers/payment_provider.dart';
import 'package:saleko/providers/product_provider.dart';

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
