import 'package:application_1/components/buttons-management/mixins/style_mixin.dart';
import 'package:nb_utils/nb_utils.dart';

import '../part_of_file/part.dart';

abstract class FarenowAbstractButton with FarenowButtonStyle {
  getButton(FarenowButton? farenowButton) {
    return Padding(
      padding: getPadding(farenowButton!),
      child: AppButton(
        width: Get.width,
        height: farenowButton.style != null ? farenowButton.style!.height : 55,
        color: bgcolor(
            color: farenowButton.style != null
                ? farenowButton.style!.buttonColor
                : null),
        elevation: 0,
        textStyle: textStyle(
            color: farenowButton.style != null
                ? farenowButton.style!.textColor
                : null),
        shapeBorder: outlinedBorder(),
        // text: farenowButton.title,
        onTap: farenowButton.onPressed,
        child: farenowButton.title!.isNotEmpty
            ? child(farenowButton.title!)
            : null,
      ),
    );
  }

  getPadding(FarenowButton? farenowButton) {
    if (farenowButton!.style != null) {
      if (farenowButton.style!.padding != null) {
        return farenowButton.style!.padding;
      } else {
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      }
    } else {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    }
  }
}
