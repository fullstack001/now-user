import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/export_file.dart';
import 'package:application_1/remote_model/provider_list/complete_and_ongoing_model.dart';
import 'package:application_1/resources/repositories/service_repository.dart';

class WorkHistoryController extends GetxController {
  bool isLoading = true;

  List<Datum> completeService = [];
  List<Datum> ongoingService = [];
  CompleteAndOngoingServices completeAndOngoingServices =
      CompleteAndOngoingServices();
  Future<void> getCompleteServices(id) async {
    isLoading = false;
    completeService.clear();
    ongoingService.clear();

    await ServiceReposiotry()
        .getCompleteAndOngoingServices(id: id)
        .then((CompleteAndOngoingServices? completeAndOngoingServices) {
      if (completeAndOngoingServices != null) {
        if (!completeAndOngoingServices.error) {
          for (var i = 0; i < completeAndOngoingServices.data.length; i++) {
            if (completeAndOngoingServices.data[i].workingStatus != null) {
              if (completeAndOngoingServices.data[i].isCompleted == 1 &&
                  completeAndOngoingServices.data[i].workingStatus == "ENDED") {
                completeService.add(completeAndOngoingServices.data[i]);
              } else if (completeAndOngoingServices.data[i].isCompleted == 0 &&
                  completeAndOngoingServices.data[i].workingStatus ==
                      "STARTED") {
                ongoingService.add(completeAndOngoingServices.data[i]);
              }
            }
          }
        }
        isLoading = true;
      }
    });

    update();
  }

  @override
  void onInit() {
    super.onInit();

    cardIndex = 0;
  }

  int cardIndex = 0;
  increamentIndexofCard() {
    cardIndex++;
    update();
  }

  decreamentIndexofCard() {
    if (cardIndex > 0) {
      cardIndex--;
    }
    update();
  }

  resetIndex() {
    cardIndex = 0;
    print(cardIndex);
    update();
  }

  final width = Get.width * 0.8;
  final ScrollController scrollController = ScrollController();
  void animateToIndex(int index) {
    scrollController.animateTo(
      index * width,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
