import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/account_provider.dart';
import '../../providers/provider.dart';
import '../../utils/assets_manager.dart';
import '../../utils/progress_bar_manager/utility_app_bar.dart';
import '../widgets/custom_profile_listTIle.dart';

class LegalTermsPage extends ConsumerStatefulWidget {
  const LegalTermsPage({super.key});

  @override
  ConsumerState createState() => _LegalTermsPageState();
}
late AccountProvider accountProvider;
class _LegalTermsPageState extends ConsumerState<LegalTermsPage> {
  @override
  Widget build(BuildContext context) {

    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(text: "Legal", hasActions: false),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), child: Column(children: [
        profileListTile(Assets.legalTerms, "Privacy Policy", (){
         accountProvider.privacyPolicy();
        }, addSpacer: true),
        Divider(thickness: 0.5,),
        profileListTile(Assets.legalTerms, "Terms of use", (){
          accountProvider.termsOfUse();
        }, addSpacer: true),

      ],),),
    );;
  }
}
