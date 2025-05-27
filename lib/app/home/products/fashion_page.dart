import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/home/products/selectedProduct.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/utils/app_colors.dart';
import '../../../models/CategoriesModel.dart';
import '../../../providers/account_provider.dart';
import '../../../utils/assets_manager.dart';
import '../../widgets/see_all_product.dart';

class FashionPage extends ConsumerStatefulWidget {
  final CategoriesModel categories;
  FashionPage({super.key, required this.categories});

  @override
  ConsumerState<FashionPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<FashionPage> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    List<Children> children = widget.categories.children ?? [];

    return Scaffold(
        appBar: UtilityAppBar(
          text: widget.categories.name ?? "",
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SeeAllProduct(onTap: () async {
                final products = await productProvider
                    .getProductLoading(widget.categories.name ?? '');
                if (products != null) {
                  productProvider.pushToAllScreen(
                    widget.categories.name ?? '',
                    products,
                  );
                }
              }),
              SizedBox(
                height: 20.h,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: children.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 1,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      final products = await productProvider
                          .getProductLoading(children[index].name ?? '');
                      if (products != null) {
                        productProvider.pushToAllScreen(
                          children[index].name ?? '',
                          products,
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 80.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blueGrey.withOpacity(0.05),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: children[index].image ?? '',
                            imageBuilder: (context, imageProvider) => ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Container(
                                height: 115,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                              child: SizedBox(
                                width: 30.w,
                                height: 30.h,
                                child: const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Image.asset(
                                Assets.laptopPowerbank,
                                height: 115,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          children[index].name ?? "",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackTextColor),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              ),
            ]),
          )),
        ));
  }
}
