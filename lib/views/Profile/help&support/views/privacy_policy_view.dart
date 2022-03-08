import 'package:fishe_tender_fisher/common/app_bar.dart';
import 'package:fishe_tender_fisher/constants.dart';
import 'package:fishe_tender_fisher/controllers/help_support_controller.dart';
import 'package:fishe_tender_fisher/services/user_provier.dart';
import 'package:fishe_tender_fisher/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);
  static final String routeName = '/privacy_policy';

  @override
  _PrivacyPolicyViewState createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        child: Column(
          children: [
            AppBarWidget(
              title: LocaleKeys.help_and_support_privacy.tr(),
              cangoback: true,
              function: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: FutureBuilder(
                future: HelpSupportController.getPrivacyPolicy(
                    Provider.of<UserProvider>(context, listen: false)
                        .user
                        .token!),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 483.h,
                      width: 355.w,
                      margin: EdgeInsets.only(left: 18.w, right: 17.w),
                      child: SingleChildScrollView(
                        child: Html(
                            data: snapshot.data![0],
                            style: {
                              "body,h1,tr,td,head": Style(
                                fontSize: FontSize(12.0.sp),
                                color: ksecondaryTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            },
                            onLinkTap: (String? url,
                                RenderContext context,
                                Map<String, String> attributes,
                                dom.Element? element) {
                              launch(url!);
                              //open URL in webview, or launch URL in browser, or any other logic here
                            }),
                      ),
                    );
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
