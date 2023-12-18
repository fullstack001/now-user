import 'package:application_1/AllPages/ExplorePages/login_page.dart';
import 'package:application_1/AllPages/RegisteraionPages/signin.dart';
import 'package:application_1/AllPages/RegisteraionPages/signup.dart';
import 'package:application_1/AllPages/introPages/questionPages/QuestionPages.dart';
import 'package:application_1/AllPages/splah_screen.dart';
import 'package:application_1/screens/Bindings/mainPageBinding.dart';
import 'package:application_1/screens/startScreen.dart';
import 'package:application_1/screens/tabScreen.dart';
import 'package:application_1/test_page.dart';
import 'package:application_1/wrapper.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INTRO;
  static const StARTSCREEN = AppRoutes.START;
  static const WRAPPER = AppRoutes.WRAPPER;
  static const SIGNIN = AppRoutes.SINGIN;
  static const SIGNUP = AppRoutes.SIGNUP;
  static const TABSCREEN = AppRoutes.TABSCREEN;
  static const LOGIN = AppRoutes.LOGIN;
  static const TEST = AppRoutes.TEST;
  static const SPLASH = AppRoutes.SPLASH;

  static final routes = [
    GetPage(name: WRAPPER, page: () => Wrapper(), binding: MainPageBinding()),
    GetPage(name: INITIAL, page: () => Question1()),
    GetPage(name: StARTSCREEN, page: () => StartScreen()),
    GetPage(name: SIGNIN, page: () => SignIn()),
    GetPage(name: SIGNUP, page: () => Signup()),
    GetPage(name: TABSCREEN, page: () => TabsScreen()),
    GetPage(name: LOGIN, page: () => LoginPage()),
    GetPage(name: TEST, page: () => TestPage()),
    GetPage(name: SPLASH, page: () => SplashScreen())
  ];
}
