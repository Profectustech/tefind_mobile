import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:te_find/utils/screen_size.dart';

import '../home/products/product_detail_fullScreen.dart';
import '../home/widgets/product_gridview.dart';

class WishlistPage extends ConsumerStatefulWidget {
  const WishlistPage({super.key});

  @override
  ConsumerState<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends ConsumerState<WishlistPage> {
  final balanceVisibilityProvider = StateProvider<bool>((ref) => false);
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      productProvider.setMyWishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My favourite lists',
          style:
          GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (productProvider.wishListProduct?.isEmpty ?? false)
                  ? GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 9,
              crossAxisSpacing: 6,
              childAspectRatio: 0.72,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              //  final feed = productProvider.allProduct![index];
              //return ProductGridview();
            },
          )
                  : Center(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Image.asset(
                            Assets.wishListEmpty,
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Your wishlist is feeling lonely.',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Show it some love!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey,
                            ),
                          ),
                          SizedBox(height: 30),
                          // Add "Start Shopping" button here if needed
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
