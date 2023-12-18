import 'package:application_1/AllPages/ProfilePages/orderHistory.dart';
import 'package:application_1/restaurant_controller/restaurant_respository.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  RestaurantRepository _repository = RestaurantRepository();
  var orderHistoryData = [].obs;
  var selectedButton = "Active Order".obs;

  void getOrderHistory() {
    _repository.orderHistoryGet().then((value) {
      orderHistoryData(value.orderHistoryData);
      selectedButton = "Active Order".obs;
      if (!value.error) {
        Get.to(() => OrderHistory());
      }
    });
  }
}
