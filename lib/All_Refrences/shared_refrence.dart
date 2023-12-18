import 'package:application_1/utils/AppColors.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedRefrence {
  void setSignIn(bool val) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("login", val);
  }

  Future<bool> getSignIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool login = preferences.getBool("login") ?? false;
    return login;
  }

  void saveString({String? key, String? data}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key!, data!.toString());
  }

  Future<String> getString({String? key}) async {
    print(key);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String login = preferences.getString(key!) ?? "";
    return login;
  }

  Future<void> remove({String? key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key!);
  }


  Future<String> getBool({String? key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var login = preferences.getBool(key!) ?? false;
    return login.toString();
  }


  void setIntro(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("intro", val);
    Get.rawSnackbar(
      message: "Welcome",
      duration: Duration(seconds: 1),
      backgroundColor: AppColors.blue,
      isDismissible: true,
    );
  }

  Future<bool> getIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intro = prefs.getBool("intro") ?? false;
    return intro;
  }
}
