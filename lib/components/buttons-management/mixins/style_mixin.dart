import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';

import '../../../utils/AppColors.dart';
import '../part_of_file/part.dart';

abstract class FarenowButtonStyle {
  Color? bgcolor({Color? color}) {
    return color ?? AppColors.solidBlue;
  }

  double? elevation() {
    return 5;
  }

  ShapeBorder? outlinedBorder() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(width: 1, color: AppColors.solidBlue));
  }

  TextStyle? textStyle({Color? color}) {
    return TextStyle(
        color: color ?? AppColors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500);
  }

  Widget child(String name) {
    return FittedBox(
      child: Text(
        name,
        style: textStyle(),
      ),
    );
  }
}
