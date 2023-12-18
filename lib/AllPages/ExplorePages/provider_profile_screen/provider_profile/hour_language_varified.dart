import 'package:application_1/utils/AppColors.dart';

import 'export_file.dart';

class HourLanguageVerified extends StatelessWidget {
  var verifiedAt;
  HourLanguageVerified({Key? key, this.verifiedAt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMainCardColum(widget: [
      titlewithSubtitle("Hours per week", "More than 30 hrs/week"),
      titlewithSubtitle("Languages", "English: Fluent"),
      // titlewithSubtitle("Verification", "${verifiedAt}"),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Verification",
              style: TextStyle(
                  color: Color(0xff151415),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  verifiedAt == null ? "Unverified " : "Verified ",
                  style: const TextStyle(
                      color: Color(0xff555555),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                Icon(
                  Icons.verified,
                  color: verifiedAt == null ? Colors.grey : AppColors.solidBlue,
                  size: 20,
                )
              ],
            ),
          ],
        ),
      )
    ]);
  }

  titlewithSubtitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Color(0xff151415),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            subtitle,
            style: const TextStyle(
                color: Color(0xff555555),
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
