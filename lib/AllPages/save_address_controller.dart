import 'dart:convert';
import 'package:application_1/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:application_1/AllPages/ExplorePages/orderDone.dart';
import 'package:application_1/model/add_address/add_address_model.dart';
import 'package:application_1/model/card/credit_card_data.dart';
import 'package:application_1/model/card/credit_card_model.dart';
import 'package:application_1/model/menu_types.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SaveAddressController extends GetxController {
  var address = "".obs;
  var zipCode = "".obs;
  var flatNumber = "".obs;
  var selectedIndex = 2.obs;
  var crditCards = [].obs;
  var selectedCard = CreditCardData().obs;
  var addressModel = AddAddressModel().obs;
  ServiceReposiotry reposiotry = ServiceReposiotry();

  var cardIndex = 0.obs;
  var addressIndex = 0.obs;
  var addressList = [].obs;

  var checkOutList = [].obs;

  var index = 0.obs;
  var cardDeleteLoading = false.obs;

  setAddressListTile(int index) {
    this.index(index);
    this.index.refresh();
    addressList.refresh();
  }

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  setAddress(String add, String zip) {
    address(add);
    zipCode(zip);
    zipCode.refresh();
    addressModel.value.zipCode = zip;
    addressModel.value.address = add;
  }

  Future<void> getAddressFromLatLong(LatLng position, type) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    placemarks = placemarks.reversed.toList();
    Placemark place = placemarks[0];
    if (placemarks.length > 1) {
      place = placemarks[1];
    }
    var addresss =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    print("$addresss");
    for (int index = 0; index < (placemarks).length; index++) {
      Placemark value = placemarks[index];
      if (value.postalCode.toString().isNotEmpty) {
        if (type == "zip") {
          var code = value.postalCode.toString();
          setAddress(address.value, code);
          break;
        } else if (type == "zip&add") {
          addresss = addresss.replaceAll(", ,", ",");
          var code = value.postalCode.toString();
          setAddress(addresss, code);
          break;
        }
      }
    }
  }

  addressSlected(value1, value2, value3) async {
    print("$value3");
    double lat = double.parse((value2.split(",")[0] ?? 0).toString());
    double lng = double.parse((value2.split(",")[1] ?? 0).toString());
    // Position position = Position(
    //   latitude: lat,
    //   longitude: lng,
    // );
    LatLng latLng = LatLng(lat, lng);
    setAddress(value1, zipCode.value);

    getAddressFromLatLong(latLng, "zip");

    print("");
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    LatLng latLng = LatLng(position.latitude, position.longitude);
    await getAddressFromLatLong(latLng, "zip&add");
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return true;
  }

  void getCreditCard({flag = false, onResponseGet}) async {
    if (!flag) {
      AppDialogUtils.dialogLoading();
    }
    ServiceReposiotry reposiotry = ServiceReposiotry();
    try {
      await reposiotry.getCards().then((CreditCardModel? data) {
        if (data != null) {
          if (!data.error) {
            crditCards(data.cardData.creditCardData);
            crditCards.refresh();
            if (!flag) {
              // Get.to(() => SelectPaymentMethod());
            }
          } else if (data.message == "Not Found") {
            if (!flag) {
              // Get.to(() => SelectPaymentMethod());
            }
          }
          if (onResponseGet != null) {
            onResponseGet();
          }
        }
      });
    } catch (ex) {
      if (!flag) {
        AppDialogUtils.dismiss();
      }
    }
  }

  void saveAddress(Map<String, dynamic> body) async {
    AppDialogUtils.dialogLoading();
    try {
      reposiotry.saveAddress(body).then((value) {
        print("$value");
        addressList.value.add(value);
        addressList.refresh();
        Get.back();
        AppDialogUtils.dismiss();
      }).onError((error, stackTrace) {
        AppDialogUtils.dismiss();
        print("$error");
      });
    } catch (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    }
  }

  Future<void> getAddress({flag = false, onResponseGet}) async {
    if (!flag) {
      if (addressList.isEmpty) {
        AppDialogUtils.dialogLoading();
      }
    }
    try {
      reposiotry.getAddress().then((value) {
        print("$value");
        addressList(value.data);
        addressList.refresh();
        AppDialogUtils.dismiss();
        if (onResponseGet != null) {
          onResponseGet();
        }
      }).onError((error, stackTrace) {
        print("$error");
      });
    } catch (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    }
  }

  void createOrder(body) async {
    AppDialogUtils.dialogLoading();
    try {
      reposiotry.createOrder(body).then((value) {
        AppDialogUtils.dismiss();
        if (!value['error'] &&
            value['message'] == "Order created successfully") {
          Future.delayed(Duration(seconds: 3)).then((value) {
            Get.to(() => OrderDone(data: value));
            AppDialogUtils.dismiss();
          });
        }
      }, onError: (error, stackTrace) {
        AppDialogUtils.dismiss();
        print("$error");
      });
    } on Exception catch (e) {
      AppDialogUtils.dismiss();
      print("$e");
    }
  }

  void deleteCard(String id) {
    AppDialogUtils.dialogLoading();
    try {
      reposiotry.deleteCard(id: id).then((value) {
        if (value) {
          for (int index = 0; index < crditCards.length; index++) {
            if (crditCards.value[index].id == id) {
              crditCards.value.removeAt(index);
              crditCards.refresh();
              break;
            }
          }
        }
        AppDialogUtils.dismiss();
      }, onError: (error, stackTrace) {
        AppDialogUtils.dismiss();
        print("onError $error");
      });
    } on Exception catch (ex) {
      AppDialogUtils.dismiss();
      print("exception $ex");
    }
  }

  void deleteAddress(String id) {
    AppDialogUtils.dialogLoading();
    try {
      reposiotry.deleteAddress(id: id).then((value) {
        if (value) {
          for (int index = 0; index < addressList.length; index++) {
            if (addressList.value[index].id.toString() == id) {
              addressList.value.removeAt(index);
              addressList.refresh();
              break;
            }
          }
        }
        AppDialogUtils.dismiss();
      }, onError: (error, stackTrace) {
        AppDialogUtils.dismiss();
        print("onError $error");
      });
    } on Exception catch (ex) {
      AppDialogUtils.dismiss();
      print("exception $ex");
    }
  }

  createCheckOutList() {
    cardIndex(0);
    addressIndex(0);
    MenuTypes typeOne =
        MenuTypes(name: "Payment Method".toUpperCase(), selected: true);
    MenuTypes typeTwo =
        MenuTypes(name: "Delivery Address".toUpperCase(), selected: true);
    // MenuTypes typeThree =
    //     MenuTypes(name: "Delivery Method".toUpperCase(), selected: false);
    List<MenuTypes> list = [typeOne, typeTwo];
    checkOutList(list);
  }

  createCheckOutData() {
    cardIndex(0);
    addressIndex(0);
    MenuTypes typeOne =
        MenuTypes(name: "Payment Method".toUpperCase(), selected: true);
    // MenuTypes typeTwo =
    //     MenuTypes(name: "Delivery Address".toUpperCase(), selected: false);
    // MenuTypes typeThree =
    //     MenuTypes(name: "Delivery Method".toUpperCase(), selected: false);
    List<MenuTypes> list = [typeOne];
    checkOutList(list);
  }

  Future getCardToken({body}) async {
    try {
      var respone =
          await http.post(Uri.parse("https://api.stripe.com/v1/tokens"),
              body: body,
              headers: {
                "Authorization": "Bearer $publicTestKey",
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded"
              },
              encoding: Encoding.getByName("utf-8"));

      var jsonData = jsonDecode(respone.body);

      if (jsonData["id"] != null) {
        if (respone.reasonPhrase!.toLowerCase() == "Ok".toLowerCase()) {
          AppDialogUtils.dismiss();
          return jsonData["id"];
        }
      } else if (jsonData["error"] != null) {
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(jsonData["error"]["message"]);
        return null;
      } else {
        AppDialogUtils.dismiss();
        return null;
      }
    } catch (e) {
      print(e.toString());
      AppDialogUtils.dismiss();
      return;
    }
  }
}




// "{
//   "error": {
//     "code": "incorrect_number",
//     "doc_url": "https://stripe.com/docs/error-codes/incorrect-number",
//     "message": "Your card number is incorrect.",
//     "param": "number",
//     "request_log_url": "https://dashboard.stripe.com/logs/req_fuOb8m5oaB9D7K?t=1674470160",
//     "type": "card_error"
//   }
// }
// "




// "{
//   "id": "tok_1MTNOgBL8wRN0OD60K5wDoHb",
//   "object": "token",
//   "card": {
//     "id": "card_1MTNOfBL8wRN0OD6vb3f17Er",
//     "object": "card",
//     "address_city": null,
//     "address_country": null,
//     "address_line1": null,
//     "address_line1_check": null,
//     "address_line2": null,
//     "address_state": null,
//     "address_zip": null,
//     "address_zip_check": null,
//     "brand": "Visa",
//     "country": "US",
//     "cvc_check": "unchecked",
//     "dynamic_last4": null,
//     "exp_month": 6,
//     "exp_year": 2027,
//     "funding": "debit",
//     "last4": "8267",
//     "name": null,
//     "tokenization_method": null
//   },
//   "client_ip": "110.39.0.142",
//   "created": 1674470226,
//   "livemode": true,
//   "type": "card",
//   "used": false
// }"