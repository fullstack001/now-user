import 'package:intl/intl.dart';

import 'export_file.dart';

// ignore: must_be_immutable
class TotalCardSection extends StatelessWidget {
  ProviderCompleteDetail provider;

  TotalCardSection({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMainCardColum(widget: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          totalSection(
              NumberFormat.compactCurrency(decimalDigits: 1, symbol: "\$")
                  .format(double.parse(provider.providerProfile.totalEarn)),
              "Total Earning"),
          totalSection(
              "${provider.providerServiceRequestsCount}", "Total Jobs"),
          totalSection(
              "${provider.workedHours == null ? 0 : provider.workedHours}",
              "Total Hours"),
        ],
      ),
    ]);
  }

  totalSection(String amount, String title) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "$amount",
          style: const TextStyle(
              color: Color(0xff151415),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "$title",
          style: const TextStyle(
              color: Color(0xff555555),
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ]),
    );
  }
}
