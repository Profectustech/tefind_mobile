import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:te_find/app/widgets/custom_profile_listTIle.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/utils/assets_manager.dart';

import '../../providers/account_provider.dart';
import '../../utils/progress_bar_manager/utility_app_bar.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState createState() => _SettingPageState();
}
late AccountProvider accountProvider;
class _SettingPageState extends ConsumerState<SettingPage> {
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(text: "Settings", hasActions: false),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), child: Column(children: [
        profileListTile(Assets.changePasswordIcon, "Change Password", accountProvider.changePassword, addSpacer: true),
        Divider(thickness: 0.3,),
       // profileListTile(Assets.transactionPinIcon, "Change Transaction PIN", accountProvider.changeTransactionPIN, addSpacer: true),
       // Divider(thickness: 0.4,),
        profileListTile(Assets.notificationIcon, "Notification Settings", accountProvider.notificationSetting, addSpacer: true),
        Divider(thickness: 0.3,),
        profileListTile(Assets.logOutIcon, "Close Account", accountProvider.closeAccount, addSpacer: true),

      ],),),
    );
  }
}
