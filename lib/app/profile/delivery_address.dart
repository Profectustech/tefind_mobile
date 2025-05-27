import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/widgets/search_box.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/provider.dart';

class DeliveryAddress extends ConsumerStatefulWidget {
  const DeliveryAddress({super.key});

  @override
  ConsumerState<DeliveryAddress> createState() => _DeliveryAddressState();
}


class _DeliveryAddressState extends ConsumerState<DeliveryAddress> {

late AccountProvider accountProvider;
@override
void initState() {
  Future.microtask(() {
     final accountProvider = ref.read(RiverpodProvider.accountProvider);
    accountProvider.getCustomerAddress();

  });
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    final accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(
        text: "Delivery Address",
        hasActions: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // SearchBox(
            //   hint: "Search for saved address",
            // ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: accountProvider.addNewAddress,
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text("Add New Address")
                ],
              ),



            ),
            SizedBox(
              height: 20.h,
            ),
        Expanded(
          child: ListView.separated(
            itemCount: accountProvider.addressList?.length ?? 0,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final address = accountProvider.addressList?[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 2.h),
                leading: CircleAvatar(
                  backgroundColor: Colors.teal.shade100,
                  child: Container(
                    height: 27.h,
                      width: 27.w,
                      decoration: BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),

                      child: const Icon(Icons.location_on, color: AppColors.white, size: 20,)),
                ),
                title: Text(
                  address?.addressTitle ?? "",
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                subtitle: Text('${address?.address}, ${address?.city} ${address?.state}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.grey),),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                },
              );
            },
          ),),

          ],
        ),
      ),
    );
  }
}
