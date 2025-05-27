import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/home/products/selectedProduct.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/utils/app_colors.dart';
import '../../../models/CategoriesModel.dart';
import '../../../models/Products.dart';
import '../../../providers/account_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../utils/assets_manager.dart';
import '../../widgets/see_all_product.dart';
import '../widgets/product_gridview.dart';

class ProductBySeller extends ConsumerStatefulWidget {
  final Products product;
  ProductBySeller({super.key,
    required this.product
  });

  @override
  ConsumerState<ProductBySeller> createState() => _ProductBySellerState();
}
class _ProductBySellerState extends ConsumerState<ProductBySeller> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();

  @override
  void initState() {
    Future.microtask(() {
      setState(() {
         productProvider.setMyProductByMerchant(
            widget.product.seller?.merchantId?? "");
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    productProvider  = ref.watch(RiverpodProvider.productProvider);
    return Scaffold(
        appBar: UtilityAppBar(
          text: "${widget.product.seller?.shopTitle??""}",
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  FutureBuilder<List<Products>>(
                    future: productProvider.productBySeller,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.data!.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                            snapshot.data!.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 9,
                              crossAxisSpacing: 6,
                              childAspectRatio: 0.65,
                            ),
                            itemBuilder: (context, index) {
                              Products product = snapshot.data![index];
                              return ProductGridview(newProducts: product);
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 100,
                                ),
                                Text(
                                  'Network error',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Network error'),
                                SizedBox(
                                  height: 100,
                                ),
                              ],
                            ));
                      } else {
                        return Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                "No products for this categories",
                                style: TextStyle(fontSize: 14, color: AppColors.black),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),

                ]),
              )),
        ));
  }
}
