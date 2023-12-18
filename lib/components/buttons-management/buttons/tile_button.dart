import '../../../utils/AppColors.dart';
import '../part_of_file/part.dart';

class FarenowTileButton extends FarenowAbstractButton with ButtonMixin {
  @override
  Widget buildFarenowButton(FarenowButton? farenowButton) => ListTile(
        leading: Container(
          width: 50,
          height: 50,
          color: bgcolor(),
          decoration: const BoxDecoration(color: Colors.cyan),
          child: const Icon(Icons.settings),
        ),
        title: Row(children: [Text(farenowButton!.title!)]),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 22,
        ),
      );

  @override
  ShapeBorder? outlinedBorder() {
    return null;
  }

  @override
  TextStyle? textStyle({Color? color}) {
    return TextStyle(
      color: color ?? AppColors.solidBlue,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  Color? bgcolor({Color? color}) {
    // TODO: implement bgcolor
    return color ?? Colors.transparent;
  }

  @override
  double? elevation() {
    return 0;
  }
}
