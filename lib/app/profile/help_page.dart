import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/account_provider.dart';
import '../../providers/provider.dart';
import '../../utils/assets_manager.dart';
import '../../utils/progress_bar_manager/utility_app_bar.dart';
import '../widgets/custom_profile_listTIle.dart';

class HelpPage extends ConsumerStatefulWidget {
  const HelpPage({super.key});

  @override
  ConsumerState createState() => _HelpPageState();
}

late AccountProvider accountProvider;

class _HelpPageState extends ConsumerState<HelpPage> {
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@te_find.ng',
      query: Uri.encodeFull('Subject: Support Request'),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      showToast(message: "Could not open email app");
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      showToast(message: "Could not open email app");
    }
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(text: "Help", hasActions: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileListTile(
              Assets.chatIcon,
              "Chat",
              () {
                _launchURL("https://wa.me/2347002255725");
              },
              addSpacer: true,
            ),
            Divider(
              thickness: 0.3,
            ),
            // // profileListTile(Assets.chatIcon, "Call",
            // //     () => _launchPhoneDialer("02018891693"),
            // //     addSpacer: true),
            // Divider(
            //   thickness: 0.3,
            // ),
            profileListTile(Assets.smsIcon, "Email", () => _launchEmail(),
                addSpacer: true),
            Divider(
              thickness: 0.4,
            ),
            profileListTile(Assets.twitterIcon, "Twitter", () {
              _launchURL("https://twitter.com/te_find_ng");
            }, addSpacer: true),
            Divider(
              thickness: 0.3,
            ),
            profileListTile(Assets.instagramIcon, "Instagram", () {
              _launchURL("https://www.instagram.com/te_find.ng/");
            }, addSpacer: true),
            Divider(
              thickness: 0.3,
            ),
            SizedBox(height: 20.h,),
            Text(
              "Our dedicated customer\nsupport will be available from:\nMONDAY-FRIDAY: 9am - 4:30pm WAT",
              style: TextStyle(color: AppColors.grey),
            )
            // profileListTile(Assets.instagramIcon, "Facebook", () {
            //   _launchURL("https://www.facebook.com/te_find.com.ng");
            // }, addSpacer: true),
          ],
        ),
      ),
    );
    ;
  }
}
