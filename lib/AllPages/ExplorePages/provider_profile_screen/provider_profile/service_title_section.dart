import 'export_file.dart';

// ignore: must_be_immutable
class ServiceTitleSection extends StatelessWidget {
  List<ProviderService>? service;
  ServiceTitleSection({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMainCardColum(widget: [
      Text(
        "Service",
        style: TextStyle(
            color: Color(0xff151415),
            fontSize: 20,
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 5,
      ),
      Divider(
        color: Colors.black54,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            service!.length,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    service![index].subService!.name!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                )),
      )
    ]);
  }
}
