import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/model/cart_model/food_cart_model.dart';
import 'package:application_1/model/rest_food/restaurant_food_model.dart';
import 'package:application_1/model/restaurant_pfroile/restaurant_pfrofile_model.dart';
import 'package:application_1/model/restaurants/restaurant_model.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:get/get.dart';

class GroceryRepository {
  String? authToken;
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  static var client = GetHttpClient(baseUrl: baseUrl);

  Future<RestaurantModel> getAllRestaurants() async {
    String filter = "grocery/list";
    // String filter = "restaurant/list";
    print("$baseUrl$filter");
    var response = await _get(filter);
    RestaurantModel parseData = RestaurantModel.fromJson(response.body);

    return parseData;
  }

  Future<RestaurantFoodModel> getGroceryItem({id}) async {
    String filter = "grocery/product/list/$id";
    // String filter = "restaurant/food/list/$id";
    print("$baseUrl$filter");
    var response = await _get(filter);
    RestaurantFoodModel parseData = RestaurantFoodModel.fromJson(response.body);

    return parseData;
  }

  Future<RestaurantProfileModel> getRestaurantProfile({id}) async {
    // String filter = "restaurant/show/$id";
    String filter = "grocery/show/$id";
    print("$baseUrl$filter");
    var response = await _get(filter);
    if (response.body == null) {
      return await getRestaurantProfile(id: id);
    }
    RestaurantProfileModel parseData =
        RestaurantProfileModel.fromJson(response.body);

    return parseData;
  }

  Future<FoodCartModel> getFoodCart() async {
    String filter = "user/cart";
    print("$baseUrl$filter");
    var response = await _get(filter);

    if (response.body == null) {
      return await getFoodCart();
    }
    FoodCartModel parseData = FoodCartModel.fromJson(response.body);
    return parseData;
  }

  Future<dynamic> initCart({id}) async {
    String filter = "user/cart";
    print("$baseUrl$filter");
    Map body = <String, dynamic>{"product_id": id, "quantity": "1"};
    var response = await _post(filter, body);

    if (response.body == null) {
      return await initCart(id: id);
    }

    return response.body['error'];
  }

  Future<dynamic> removeFromCart({id}) async {
    String filter = "user/cart/$id";
    print("$baseUrl$filter");
    var response = await _delete(filter);

    if (response.body == null) {
      return await removeFromCart(id: id);
    }

    return response.body['error'];
  }

  Future<dynamic> updateCart({qty, id}) async {
    String filter = "user/cart/$id";
    print("$baseUrl$filter");
    Map body = <String, dynamic>{"quantity": qty};
    var response = await _update(filter, body);

    if (response.body == null) {
      return await removeFromCart(id: id);
    }

    return response.body['error'];
  }

  _get(String filter, {count = 0}) async {
    await _getPrefToken();
    print(count.toString());
    var response = await client.get(filter, headers: requestHeaders);

    if (count == 2) {
      return;
    }
    if (response.body == null) {
      count = count + 1;
      return _get(filter, count: count);
    }
    print("GET: ${response.bodyString}");
    return response;
  }

  _update(String filter, body) async {
    await _getPrefToken();
    var response =
        await client.put(filter, headers: requestHeaders, body: body);

    print("UPDATE: ${response.bodyString}");
    return response;
  }

  _delete(String filter) async {
    await _getPrefToken();
    var response = await client.delete(filter, headers: requestHeaders);

    print("DELETE: ${response.bodyString}");
    return response;
  }

  _post(String filter, Map body) async {
    await _getPrefToken();
    var response =
        await client.post(filter, headers: requestHeaders, body: body);

    print("POST: ${response.bodyString}");
    return response;
  }

  _getPrefToken() async {
    authToken = await SharedRefrence().getString(key: ApiUtills.authToken);

    requestHeaders['Authorization'] = authToken!;
    print("$authToken");
  }
}
/*
{
    "error": true,
    "message": "No cart item found"
}
 */
