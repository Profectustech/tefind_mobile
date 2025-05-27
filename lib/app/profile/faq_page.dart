// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:saleko/app/widgets/search_box.dart';
// import 'package:saleko/utils/app_colors.dart';
// import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
// import 'package:flutter/gestures.dart';
// import 'package:url_launcher/url_launcher.dart';
//
//
// class FaqPage extends ConsumerStatefulWidget {
//   const FaqPage({super.key});
//
//   @override
//   ConsumerState createState() => _FaqPageState();
// }
// int expandedIndex = -1; // Tracks which card is expanded
//
// final List<Map<String, dynamic>> faqItems = [
//   {
//     "question": "How do I become a merchant on Saleko?",
//     "answer": "If you wish to set up shop on Saleko, click here for a step by step guide on creating a merchant profile.",
//     "color": AppColors.primaryColor,
//     url
//
//   },
//   {
//     "question": "How do I shop on Saleko?",
//     "answer": "If you wish to shop from local markets, click here for a step by step guide on creating a buyer profile on Saleko.",
//     "color": Colors.orange
//   },
//   {
//     "question": "My order has payment issues",
//     "answer": "If you have any issues relating to making payments on our platform, please reach out to our customer support representatives for immediate assistance through our website's chat box. You can locate the chat box via the chat icon at the bottom right-hand corner of your screen. Once you click on the icon, a chat window will open up, and you'll be connected with one of our support agents.\n \n For further assistance with this issue, please send an email to support@saleko.ng.\n \n We understand that sometimes, technical glitches happen, but we're committed to making sure that your experience with us at Saleko is a smooth one. So take a deep breath, relax and let's get this sorted out.",
//     "color": Colors.purple
//   },
//   {
//     "question": "I would like to advertise my product on Saleko",
//     "answer": "To advertise your products on Saleko, please reach out to us at info@saleko.ng or call 07000SALEKO.",
//     "color": Colors.black
//   },
//   {
//     "question": "Order cancellation issue",
//     "answer": "If your order was cancelled or if you would like to cancel your order, please reach out to our customer support representatives for immediate assistance through our website's chat box. You can locate the chat box via the chat icon at the bottom right-hand corner of your screen. Once you click on the icon, a chat window will open up, and you'll be connected with one of our support agents.\n \nFor further assistance call 07000SALEKO or email the support team at support@saleko.ng.",
//     "color": Colors.deepOrange
//   },
//   {
//     "question": "I need help tracking my order",
//     "answer": "Need help tracking an order? Click here for more information",
//     "color": Colors.purple
//   },
//   {
//     "question": "I have issues with ny Delivered Product",
//     "answer": "Please know that we take all customer complaints seriously and we're here to help resolve this issue for you as quickly as possible. We want you to have the best experience possible with our service, and we're committed to making it right. Let's work together to figure out what went wrong and how we can fix it.\n\nClick here to find out how to resolve issues you may have with your order.",
//     "color": AppColors.primaryColor
//   },
//   {
//     "question": "Order returns & refunds",
//     "answer": "We're truly sorry to hear that you're not satisfied with your order and that you're considering a refund. We take all customer feedback seriously, and we want to make sure that we do everything we can to address your concerns and make things right.\nClick here to find out how to go about returns and refunds.",
//     "color": Colors.deepOrange
//   },
//   {
//     "question": "Pickup Locations",
//     "answer": "We currently have multiple pickup locations available for your convenience, and we are always looking to expand our network to better serve our customers.\nClick here to find out more about our pickup locations.",
//     "color": Colors.black
//   },
// ];
//
// class _FaqPageState extends ConsumerState<FaqPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: UtilityAppBar(text: "FAQ", hasActions: false,),
//       body: SingleChildScrollView(
//         child: Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), child:
//           Column(
//             children: [
//               Text("We’re here to help you with anything and everything on Saleko.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
//               SizedBox(height: 20.h,),
//               SearchBox(hint: "Search for help"),
//               SizedBox(height: 20.h,),
//               Container(
//                 height: 600.h,
//                 child: ListView.builder(
//                   physics: BouncingScrollPhysics(),
//                   padding: EdgeInsets.zero,
//                   itemCount: faqItems.length,
//                   itemBuilder: (context, index) {
//                     final item = faqItems[index];
//                     final isExpanded = expandedIndex == index;
//
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           expandedIndex = isExpanded ? -1 : index;
//                         });
//                       },
//                       child: Transform.translate(
//                         offset: Offset(0, index == 0 ? 0 : -10), // Overlaps containers
//                         child: AnimatedContainer(
//                           duration: Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                           padding: EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: isExpanded ? item["color"] : item["color"],
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(9.96),
//                               topRight: Radius.circular(9.96),
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item["question"],
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               if (isExpanded) ...[
//                                 SizedBox(height: 10),
//                                 Text(
//                                   item["answer"],
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//
//
//             ],
//
//           ),),
//       ),
//     );
//   }
// }
//
//
//
// Widget buildClickableText(String fullText, String url) {
//   const linkText = 'click here';
//   final linkIndex = fullText.toLowerCase().indexOf(linkText);
//
//   if (linkIndex == -1) return Text(fullText); // no "click here" found
//
//   final before = fullText.substring(0, linkIndex);
//   final after = fullText.substring(linkIndex + linkText.length);
//
//   return RichText(
//     text: TextSpan(
//       style: const TextStyle(color: Colors.black), // default style
//       children: [
//         TextSpan(text: before),
//         TextSpan(
//           text: linkText,
//           style: const TextStyle(
//             color: Colors.blue,
//             decoration: TextDecoration.underline,
//           ),
//           recognizer: TapGestureRecognizer()
//             ..onTap = () async {
//               final uri = Uri.parse(url);
//               if (await canLaunchUrl(uri)) {
//                 await launchUrl(uri, mode: LaunchMode.externalApplication);
//               }
//             },
//         ),
//         TextSpan(text: after),
//       ],
//     ),
//   );
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/widgets/search_box.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FaqPage extends ConsumerStatefulWidget {
  const FaqPage({super.key});

  @override
  ConsumerState createState() => _FaqPageState();
}

int expandedIndex = -1;

final List<Map<String, dynamic>> faqItems = [
  {
    "question": "How do I become a merchant on Saleko?",
    "answer": "If you wish to set up shop on Saleko, click here for a step by step guide on creating a merchant profile.",
    "color": AppColors.primaryColor,
    "url": "https://saleko.ng/become-a-seller"// "https://flutter.dev"
  },
  {
    "question": "How do I shop on Saleko?",
    "answer": "If you wish to shop from local markets, click here for a step by step guide on creating a buyer profile on Saleko.",
    "color": Colors.orange,
    "url": "https://saleko.ng/create-buyers-profile"
  },
  {
    "question": "My order has payment issues",
    "answer":
    "If you have any issues relating to making payments on our platform, please reach out to our customer support representatives for immediate assistance through our website's chat box. You can locate the chat box via the chat icon at the bottom right-hand corner of your screen. Once you click on the icon, a chat window will open up, and you'll be connected with one of our support agents.\n\nFor further assistance with this issue, please send an email to support@saleko.ng.",
    "color": Colors.purple
  },
  {
    "question": "I would like to advertise my product on Saleko",
    "answer":
    "To advertise your products on Saleko, please reach out to us at info@saleko.ng or call 07000SALEKO.",
    "color": Colors.black
  },
  {
    "question": "Order cancellation issue",
    "answer":
    "If your order was cancelled or if you would like to cancel your order, please reach out to our customer support representatives for immediate assistance through our website's chat box. You can locate the chat box via the chat icon at the bottom right-hand corner of your screen. Once you click on the icon, a chat window will open up, and you'll be connected with one of our support agents.\n\nFor further assistance call 07000SALEKO or email the support team at support@saleko.ng.",
    "color": Colors.deepOrange
  },
  {
    "question": "I need help tracking my order",
    "answer": "Need help tracking an order? Click here for more information",
    "color": Colors.purple,
    "url": "https://saleko.ng/track-my-order"
  },
  {
    "question": "I have issues with my Delivered Product",
    "answer":
    "Please know that we take all customer complaints seriously and we're here to help resolve this issue for you as quickly as possible. We want you to have the best experience possible with our service, and we're committed to making it right. Let's work together to figure out what went wrong and how we can fix it.\n\nClick here to find out how to resolve issues you may have with your order.",
    "color": AppColors.primaryColor,
    "url": "https://saleko.ng/disputes"
  },
  {
    "question": "Order returns & refunds",
    "answer":
    "We're truly sorry to hear that you're not satisfied with your order and that you're considering a refund. We take all customer feedback seriously, and we want to make sure that we do everything we can to address your concerns and make things right.\nClick here to find out how to go about returns and refunds.",
    "color": Colors.deepOrange,
    "url": "https://saleko.ng/disputes"
  },
  {
    "question": "Pickup Locations",
    "answer":
    "We currently have multiple pickup locations available for your convenience, and we are always looking to expand our network to better serve our customers.\nClick here to find out more about our pickup locations.",
    "color": Colors.black,
    "url": "https://saleko.ng/pickup-locations"
  },
];

class _FaqPageState extends ConsumerState<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UtilityAppBar(
        text: "FAQ",
        hasActions: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Text(
                "We’re here to help you with anything and everything on Saleko.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              // SizedBox(height: 20.h),
              // SearchBox(hint: "Search for help"),
              SizedBox(height: 20.h),
              Container(
                height: 600.h,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: faqItems.length,
                  itemBuilder: (context, index) {
                    final item = faqItems[index];
                    final isExpanded = expandedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          expandedIndex = isExpanded ? -1 : index;
                        });
                      },
                      child: Transform.translate(
                        offset: Offset(0, index == 0 ? 0 : -10),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: item["color"],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(9.96),
                              topRight: Radius.circular(9.96),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["question"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (isExpanded) ...[
                                SizedBox(height: 10),
                                item["answer"]
                                    .toString()
                                    .toLowerCase()
                                    .contains("click here") &&
                                    item.containsKey("url")
                                    ? buildClickableText(
                                    context, item["answer"], item["url"])
                                    : Text(
                                  item["answer"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildClickableText(BuildContext context, String fullText, String url) {
  const linkText = 'click here';
  final linkIndex = fullText.toLowerCase().indexOf(linkText);

  if (linkIndex == -1) {
    return Text(
      fullText,
      style: TextStyle(color: Colors.white, fontSize: 12),
    );
  }

  final before = fullText.substring(0, linkIndex);
  final after = fullText.substring(linkIndex + linkText.length);

  return RichText(
    text: TextSpan(
      style: const TextStyle(color: Colors.white, fontSize: 12),
      children: [
        TextSpan(text: before),
        TextSpan(
          text: linkText,
          style: const TextStyle(
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WebViewPage(url: url),
                ),
              );
            },
        ),
        TextSpan(text: after),
      ],
    ),
  );
}

// WebView page
class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({super.key, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool isLoading = true; // To control the loading state

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(
        // showing a loading indicator for good user experience
        onPageStarted: (_) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (_) {
          setState(() {
            isLoading = false;
          });
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saleko")),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

