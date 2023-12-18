import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_prfile_binding/provider_profile_binding.dart';

import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/model/chat_request/chat_reqpest_response.dart';
import 'package:application_1/model/provider_time_slots/provider_time_data.dart';
import 'package:application_1/model/provider_time_slots/provider_timeslots_response.dart';
import 'package:application_1/model/provider_time_slots/quot_errors.dart';
import 'package:application_1/remote_model/provider_list/provider_profile_detail_model.dart';
import 'package:application_1/remote_model/service_questions/service_question_questions.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../remote_model/provider_list/provider_list_response_model.dart';
import '../provider_profile_screen/provider_profile/new_provider_profile.dart';

class ProfileScreenController extends GetxController {
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();

  var number = "".obs;
  var token = "".obs;
  var providerId = "".obs;
  var providerTiming = ProviderTimeData().obs;
  var selectedDates = [].obs;
  var selectedDate = "".obs;
  var selectedTimeSlot = [].obs;
  var selectedProvider = ProviderListData().obs;
  var chatRequest = ChatReqpestResponse().obs;
  int count = 0;
  var time;
  var blockSlot = false.obs;
  var providerProfileDetails = ProviderProfileCompleteDetail().obs;

  getProviderProfileDetail(id, {fromProject = false}) async {
    AppDialogUtils.dialogLoading();

    String authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);

    await _serviceReposiotry
        .getProviderProfileData(authToken, id.toString())
        .then((ProviderProfileCompleteDetail? response) {
      AppDialogUtils.dismiss();
      if (response != null) {
        if (!response.error!) {
          providerProfileDetails(response);
          providerProfileDetails.refresh();
          Get.to(
              NewProviderProfile(
                data: response.data,
                fromHome: fromProject,
              ),
              binding: ProviderProfileBinding());
        }
      }
    });
  }

  // void getServiceTimmings(ProviderListData data,
  //     {fromHome, int? orderId}) async {
  //   AppDialogUtils.dialogLoading();
  //   bool home = fromHome ?? false;
  //   try {
  //     String authToken =
  //         await SharedRefrence().getString(key: ApiUtills.authToken);
  //     token(authToken);
  //     ProviderTimeslotsResponse response = await _serviceReposiotry
  //         .getServiceTimmings(authToken, data.id.toString());
  //     if (!response.error) {
  //       AppDialogUtils.dismiss();
  //       // AppDialogUtils.successDialog("OTP resend successfully");
  //       providerTiming(response.providerTimeData);
  //       // Get.to(ServiceTimings());

  //     } else {
  //       AppDialogUtils.dismiss();
  //       // AppDialogUtils.errorDialog("Failed to resend OTP");
  //     }
  //     if (home) {
  //       Get.to(ServiceTimings(home: home, orderId: orderId));
  //     } else {
  //       // Get.to(ProviderProfile(data: data));

  //     }
  //   } catch (e) {
  //     AppDialogUtils.dismiss();
  //     print("error");
  //   }
  // }D

// List<Schedule>
  checkSlot({date, year, month, fullDate}) {
    // var providerTimeslotsData = providerTiming.value.providerTimeslotsData;
    late String _dayName;
    if (fullDate != null) {
      _dayName = DateFormat.EEEE().format(fullDate);
    }
    List<Schedule> providerTimeslotsData =
        providerProfileDetails.value.data.provider.schedules ?? [];

    List<BlockedSlot> providerBlockSlots =
        providerProfileDetails.value.data.provider.blockedSlots ?? [];
    List<ServiceAndBlockSlots> serviceAndBlock = [];
    print(DateFormat.EEEE().format(fullDate));
    if (providerTimeslotsData.isNotEmpty) {
      for (var i = 0; i < providerTimeslotsData.length; i++) {
        Schedule _schedule = providerTimeslotsData[i];
        if (_schedule.day == _dayName) {
          if (providerBlockSlots.isNotEmpty) {
            for (var i = 0; i < providerBlockSlots.length; i++) {
              BlockedSlot _blockedSlot = providerBlockSlots[i];
              print(DateFormat.EEEE().format(_blockedSlot.date));
              if (DateFormat.EEEE().format(_blockedSlot.date) == _dayName &&
                  date == _blockedSlot.date.day) {
                serviceAndBlock.add(ServiceAndBlockSlots(
                    providerId: _blockedSlot.providerId,
                    fromTime: _blockedSlot.fromTime,
                    day: DateFormat.EEEE().format(_blockedSlot.date),
                    partiallyBlock: true,
                    date: _blockedSlot.date.toString(),
                    toTime: _blockedSlot.toTime));
              } else if (_blockedSlot.fromTime == null &&
                  _blockedSlot.toTime &&
                  DateFormat.EEEE().format(_blockedSlot.date) == _dayName &&
                  date == _blockedSlot.date.day) {
                serviceAndBlock.add(ServiceAndBlockSlots(
                    providerId: _blockedSlot.providerId,
                    fromTime: _blockedSlot.fromTime,
                    day: DateFormat.EEEE().format(_blockedSlot.date),
                    date: _blockedSlot.date.toString(),
                    completeBlock: true,
                    toTime: _blockedSlot.toTime));
              } else if (checkInBlockSlot(providerBlockSlots, fullDate)) {
                serviceAndBlock.add(ServiceAndBlockSlots(
                    providerId: _blockedSlot.providerId,
                    fromTime: _blockedSlot.fromTime,
                    day: DateFormat.EEEE().format(_blockedSlot.date),
                    date: _blockedSlot.date.toString(),
                    completeBlock: true,
                    toTime: _blockedSlot.toTime));
              }
            }

            if (serviceAndBlock.isEmpty) {
              serviceAndBlock.add(ServiceAndBlockSlots(
                  providerId: _schedule.providerId,
                  fromTime: _schedule.fromTime,
                  day: _schedule.day,
                  toTime: _schedule.toTime));
            }
          } else {
            serviceAndBlock.add(ServiceAndBlockSlots(
                providerId: _schedule.providerId,
                fromTime: _schedule.fromTime,
                day: _schedule.day,
                toTime: _schedule.toTime));
          }
        }
      }
    }
    return serviceAndBlock.toList();
    // serviceAndBlock.add(ServiceAndBlockSlots(
    //     providerId: _schedule.providerId,
    //     fromTime: _schedule.fromTime,
    //     day: _schedule.day,
    //     block: false,
    //     toTime: _schedule.toTime));
    // List<Schedule> timeSlots = [];
    // for (int index = 0; index < (providerTimeslotsData ?? []).length; index++) {
    // ProviderTimeslotsData obj = providerTimeslotsData[index];
    // ProviderSchedule time = obj.providerSchedule;

    // if (time.month == month.toString() &&
    //     time.year == year.toString() &&
    //     time.date == date.toString()) {
    // if (obj.start.contains(":")) {
    //   Schedule timeSlot = Schedule();
    //   timeSlot.fromTime = obj.start;
    //   timeSlot.id = obj.id;
    //   timeSlot.toTime = obj.start;
    //   timeSlot.day = obj;
    //   // timeSlot.createdAt = obj.createdAt;
    //   // timeSlot.updatedAt = obj.updatedAt;
    //   timeSlots.add(timeSlot);
    // }
    //   }
    // }

    // return timeSlots;
  }

  bool checkInBlockSlot(List<BlockedSlot> providerBlockSlots, DateTime day) {
    int count = 0;
    if (providerBlockSlots.isNotEmpty) {
      print(providerBlockSlots);
      for (var i = 0; i < providerBlockSlots.length; i++) {
        if (providerBlockSlots[i].date.day == day.day &&
            providerBlockSlots[i].date.year == day.year &&
            providerBlockSlots[i].date.month == day.month) {
          for (var h = int.parse(
                  providerBlockSlots[i].fromTime.toString().splitBefore(":"));
              h <=
                  int.parse(
                      providerBlockSlots[i].toTime.toString().splitBefore(":"));
              h++) {
            count++;
          }
          if (count == 24) {
            return true;
          } else {
            return false;
          }
        }
      }
    }
    return false;
  }

  void bookNow(
      {body,
      question,
      home,
      orderId,
      imageList,
      onsubmit,
      tabScreenController,
      flag = false}) async {
    if (!flag) {
      AppDialogUtils.dialogLoading();
    }
    try {
      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      token(authToken);
      ProviderTimeslotsResponse response = await _serviceReposiotry.bookNow(
        authToken,
        body,
        home: home,
        orderId: orderId,
        imageList: imageList,
      );
      if (!response.error) {
        AppDialogUtils.dismiss();
        if (tabScreenController != null) {
          tabScreenController.setTabIndex(1);
        }
        if (onsubmit != null) {
          onsubmit();
        }

        // AppDialogUtils.successDialog("Service booked successfully");
      } else {
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(getErrors(response.quotErrors));
      }
    } catch (e) {
      // count = 0;
      AppDialogUtils.dismiss();
      print("error $e");
    }
  }

  String getErrors(QuotErrors quotErrors) {
    if (quotErrors.detail != null) {
      return quotErrors.detail;
    }
    if (quotErrors.address != null) {
      return quotErrors.address;
    }
    if (quotErrors.isHourly != null) {
      return quotErrors.isHourly;
    }

    return "Server internal error";
  }

  void sendChatRequest(body, List<ServiceQuestionQuestions> question,
      {onRequested}) async {
    AppDialogUtils.dialogLoading();

    String authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    // token(authToken);
    await _serviceReposiotry
        .sendChatRequest(authToken, body, question)
        .then((ChatReqpestResponse? response) {
      Get.back(canPop: true);
      AppDialogUtils.dismiss();
      if (response != null) {
        if (!response.error) {
          chatRequest(response);
          if (onRequested != null) {
            onRequested();
          }
        } else {
          AppDialogUtils.errorDialog(response.message);
        }
      }
    });
  }

  void payDueAmount({Map<dynamic, dynamic>? body, bool? flag, onUpdate}) async {
    if (!flag!) {
      AppDialogUtils.dialogLoading();
    }
    try {
      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      token(authToken);
      var response = await _serviceReposiotry.payDueAmount(
        authToken,
        body!,
      );
      if (!response['error']) {
        AppDialogUtils.dismiss();
        AppDialogUtils.successDialog("Amount paid successfully");
        if (onUpdate != null) {
          onUpdate();
        }
      } else {
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(response['message']);
      }
    } catch (e) {
      // count = 0;
      AppDialogUtils.dismiss();
      print("error $e");
    }
  }
}

class ServiceAndBlockSlots {
  String? fromTime;
  String? toTime;
  String? date;
  bool? partiallyBlock;
  bool? completeBlock;
  int providerId;
  String? day;
  bool? completeDaybooked;

  ServiceAndBlockSlots(
      {this.fromTime,
      this.toTime,
      this.completeBlock = false,
      this.partiallyBlock = false,
      this.date,
      this.day,
      this.completeDaybooked = false,
      required this.providerId});
}
