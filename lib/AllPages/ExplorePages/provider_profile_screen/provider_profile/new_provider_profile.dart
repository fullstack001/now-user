import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/package_screen.dart';
import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/preffered_availability_section.dart';
import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/total_card_section.dart';
import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/top_section.dart';
import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/bottom_section.dart';
import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/provider_rating_section.dart';
import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/service_title_section.dart';
import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/work_history.dart';
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';

import 'package:application_1/remote_model/provider_list/provider_profile_detail_model.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'bio_section.dart';
import 'hour_language_varified.dart';
import 'portfolio_section.dart';
import 'provider_payment_method.dart';

class _NewProviderProfileState extends State<NewProviderProfile>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: white,
          automaticallyImplyLeading: true,
          elevation: 2,
          iconTheme: IconTheme.of(context).copyWith(color: black),
          titleTextStyle: TextStyle(color: black, fontSize: 18),
          title: Text("Profile")),
      backgroundColor: Color(0xffF5F5F5),
      body: Column(children: [
        Flexible(
            flex: 9,
            child: Container(
              child: ListView(
                children: [
                  TopSection(provider: widget.data.provider),
                  TotalCardSection(provider: widget.data.provider),
                  widget.data.provider!.schedules!.isNotEmpty
                      ? PrefferedAvailable(
                          schedule: widget.data.provider!.schedules)
                      : Container(),
                  BioSection(bio: widget.data.provider!.bio),
                  widget.data.provider!.portfolios!.isNotEmpty
                      ? PortFolioSection(
                          portfolios: widget.data.provider!.portfolios)
                      : Container(),
                  WorkHistory(id: widget.data.provider.id),
                  ProviderRatingSection(
                    providerId: widget.data.provider.id,
                    userFeedbacksCount: widget.data.provider.userFeedbacksCount,
                  ),
                  ServiceTitleSection(
                      service: widget.data.provider!.providerServices),
                  PackageView(data: widget.data.provider!.packagePlans),
                  widget.data.provider!.paymentMethods.isNotEmpty
                      ? ProviderPaymentMethod(
                          paymentMethod: widget.data.provider!.paymentMethods,
                        )
                      : Container(),
                  HourLanguageVerified(
                    verifiedAt: widget.data.provider!.verifiedAt,
                  ),
                ],
              ),
            )),
        widget.fromHome
            ? Container()
            : BottomSectionProviderProfile(
                providerCompleteDetailData: widget.data,
              ),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();

    _registrationController.getFeedback(widget.data.provider!.id!.toInt());
  }

  final RegistrationController _registrationController = Get.find();

  var cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));
}

// ignore: must_be_immutable
class NewProviderProfile extends StatefulWidget {
  ProviderCompleteDetailData data;
  final fromHome;
  NewProviderProfile({Key? key, required this.data, this.fromHome = false})
      : super(key: key);

  @override
  State<NewProviderProfile> createState() => _NewProviderProfileState();
}
