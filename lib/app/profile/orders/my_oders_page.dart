import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/home/confirmed_payment.dart';
import 'package:saleko/app/home/widgets/order_listview.dart';
import 'package:saleko/models/product.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';

class MyOdersPage extends ConsumerStatefulWidget {
  MyOdersPage({super.key});

  @override
  ConsumerState<MyOdersPage> createState() => _MyOdersPageState();
}

class _MyOdersPageState extends ConsumerState<MyOdersPage> {
  late AccountProvider accountProvider;

  @override
  Widget build(BuildContext context) {
   // final allProducts = ref.watch(productsProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(text: "My Orders"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index) {
              return orderListView(
                allProducts: [],
                index: index,
              );
            }),
      ),
    );
  }
}
