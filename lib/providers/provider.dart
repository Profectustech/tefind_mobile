import 'package:te_find/app/bottom_nav/nav_service.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/app_nav_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:te_find/providers/payment_provider.dart';
import 'package:te_find/providers/product_provider.dart';

import 'otherProvider.dart';

class RiverpodProvider {
  static final appNavNotifier =
      ChangeNotifierProvider.autoDispose<AppNavNotifier>(
    (ref) => AppNavNotifier(),
  );

  static final accountProvider = ChangeNotifierProvider<AccountProvider>(
          (ref) => AccountProvider.init(ref: ref));
  static final navStateProvider =
      ChangeNotifierProvider<NavStateProvider>((ref) => NavStateProvider());
  static final productProvider = ChangeNotifierProvider<ProductProvider>(
      (ref) => ProductProvider.init(reader: ref));
  static final paymentProvider = ChangeNotifierProvider<PaymentProvider>(
      (ref) => PaymentProvider.init(reader: ref));
  static final otherProvider =
  ChangeNotifierProvider<OtherProvider>((ref) => OtherProvider());
}
