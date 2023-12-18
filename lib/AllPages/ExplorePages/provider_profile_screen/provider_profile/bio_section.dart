import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:readmore/readmore.dart';

import 'export_file.dart';

class BioSection extends StatelessWidget {
  final String bio;
  BioSection({Key? key, required this.bio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMainCardColum(widget: [
      Text(
        "Bio",
        style: TextStyle(
            color: Color(0xff151415),
            fontSize: 20,
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 8,
      ),
      ReadMoreText(
        '$bio',
        trimLines: 4,
        style: TextStyle(fontSize: 16),
        colorClickableText: Colors.blue,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Read more',
        trimExpandedText: ' ',
        moreStyle:
            TextStyle(fontSize: 16, color: blue, fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
