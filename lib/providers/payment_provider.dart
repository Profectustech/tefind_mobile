import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:te_find/models/CartModel.dart';
import 'package:te_find/models/CategoriesModel.dart';
import 'package:te_find/models/MarketListModel.dart';
import 'package:te_find/models/Products.dart';
import 'package:te_find/models/WishListModel.dart';
import 'package:te_find/models/brandListModel.dart';
import 'package:te_find/models/featured_product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:te_find/models/util_model.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/repository/payment_repository.dart';
import 'package:te_find/repository/product_repository.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/base_model.dart';
import 'package:te_find/utils/enums.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/productModel.dart';

class PaymentProvider extends BaseModel {
  final Ref reader;

  PaymentProvider.init({
    required this.reader,
  });

  final _paymentRepository = PaymentRepository();

  String reference = '';

  num? _cartId;

  num? get cartId => _cartId;

  changeCartId(num? value) {
    _cartId = value;
    notifyListeners();
  }

  NavigatorService _navigation = NavigatorService();
  initiatePayment() async {
    setBusy(true);
    HTTPResponseModel res =
        await _paymentRepository.initiatePayment(_cartId ?? 0);
    setBusy(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      reference = res.data[0]['reference'];
      notifyListeners();
      showHalfScreenWebViewDialog(
        url: res.data[0]['authorization_url'],
        onDialogClosed: () {
          verifyPayment(_cartId ?? 0);
        },
      );
      return true;
    } else {
      return [];
    }
  }

  void showHalfScreenWebViewDialog({
    required String url,
    required VoidCallback onDialogClosed,
  }) {
    showModalBottomSheet(
      context: NavigatorService.navigationKey_.currentContext!,
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.8,
        child: WebViewSheet(url: url, onDialogClosed: onDialogClosed),
      ),
    );
  }

  verifyPayment(num cartId) async {
    setBusy(true);
    HTTPResponseModel res = await _paymentRepository.verifyPayment(
        {"cart_id": cartId, "type": "blusalt", "reference": reference});
    setBusy(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      reader
          .watch(RiverpodProvider.navStateProvider)
          .setCurrentTabTo(newTabIndex: 0);
      _navigation.pushAndRemoveUntil(bottomNavigationRoute);
      return true;
    } else {
      _navigation.pushAndRemoveUntil(bottomNavigationRoute);
    }
  }
}

class WebViewSheet extends StatefulWidget {
  final String url;
  final VoidCallback onDialogClosed;

  const WebViewSheet({
    Key? key,
    required this.url,
    required this.onDialogClosed,
  }) : super(key: key);

  @override
  State<WebViewSheet> createState() => _WebViewSheetState();
}

class _WebViewSheetState extends State<WebViewSheet> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (_) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    widget.onDialogClosed(); // Trigger callback on close
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: Scaffold(
          appBar: AppBar(
              title: Text('Payment'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      widget.onDialogClosed();
                    })
              ]),
          body: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ));
  }
}
