import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_prfile_binding/bottom_section_controller.dart';
import 'package:application_1/AllPages/ExplorePages/service_timings_widget.dart';
import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/AllPages/chat/chat_request_widget.dart';
import 'package:application_1/AllPages/chat/chat_screen.dart';
import 'package:application_1/App_Routes/app_routes.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import '../../select_home_address_widget.dart';
import 'export_file.dart';

class BottomSectionProviderProfile extends StatelessWidget {
  ProviderCompleteDetailData providerCompleteDetailData;
  final ProfileScreenController _profileScreenController = Get.find();
  BottomSectionProviderProfile(
      {Key? key, required this.providerCompleteDetailData})
      : super(key: key);

  final RegistrationController _registrationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomSectionController>(
        init: BottomSectionController(),
        builder: (controller) {
          return Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (providerCompleteDetailData
                            .provider.providerProfile.hourlyRate ==
                        null)
                      Flexible(
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {
                            if (providerCompleteDetailData
                                    .provider.providerProfile.hourlyRate ==
                                null) {
                              if (controller.messageLabel.toLowerCase() ==
                                  "Chat Request".toLowerCase()) {
                                Get.dialog(ChatRequestWidget(
                                    providerId: providerCompleteDetailData
                                        .provider.id
                                        .toString(),
                                    onRequested: () {
                                      controller
                                          .updateMessageLable("Request sent");
                                      AppDialogUtils.successDialog(
                                          "Chat request sent successfully");

                                      Get.offNamedUntil(AppRoutes.TABSCREEN,
                                          (route) => false);
                                    }));
                                // _profileScreenController.sendChatRequest();
                              } else {
                                print(_profileScreenController
                                    .chatRequest
                                    .value
                                    .chatReqpestData
                                    .chatReqpestMessage
                                    .serviceRequestId);
                                Get.to(ChatScreen(
                                  receiverId: providerCompleteDetailData
                                      .provider.id
                                      .toString(),
                                  senderId:
                                      _registrationController.userData.value.id,
                                  orderId: _profileScreenController
                                      .chatRequest
                                      .value
                                      .chatReqpestData
                                      .chatReqpestMessage
                                      .serviceRequestId,
                                  name:
                                      "${providerCompleteDetailData.provider.firstName.toString().capitalizeFirst} ${providerCompleteDetailData.provider.lastName.toString().capitalizeFirst}",
                                ));
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.darkBlue),
                                  borderRadius: BorderRadius.circular(12)),
                              child: FittedBox(
                                child: Text(
                                  controller.messageLabel,
                                  style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: GestureDetector(
                        onTap: () {
                          // if (provider.providerServiceRequestsCount != 0) {
                          if (providerCompleteDetailData.provider.providerType
                                  .toString()
                                  .toLowerCase() ==
                              "Individual".toLowerCase()) {
                            _registrationController.checkDues();
                            return;
                          } else {
                            Get.to(SelectHomeAddressWidget(
                              home: false,
                              quotation: providerCompleteDetailData.provider
                                          .providerProfile.hourlyRate ==
                                      null
                                  ? true
                                  : false,
                            ));
                          }

                          // }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: AppColors.darkBlue,
                                border: Border.all(color: AppColors.darkBlue),
                                borderRadius: BorderRadius.circular(12)),
                            child: FittedBox(
                              child: Text(
                                "Book Provider",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
