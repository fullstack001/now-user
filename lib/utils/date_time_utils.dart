import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeUtils {
  DateTime fromTimeStamp(int stamp) {
    return DateTime.fromMicrosecondsSinceEpoch(stamp);
  }

  DateTime convertString(String dateTime) {
    if (dateTime.contains("T")) {
      dateTime = dateTime.replaceAll("T", " ");
    }
    return DateFormat("yyyy-MM-dd HH:mm").parse(dateTime);
  }

  DateTime convertStringWoT(String dateTime) {
    if (dateTime.contains("T")) {
      dateTime = dateTime.replaceAll("T", " ");
    }
    return DateFormat("yyyy-MM-dd hh:mm").parse(dateTime);
  }

  String checkSince(DateTime time) {
    // var dateTimeUTC = DateFormat("EE, dd MMM yyyy, HH:mm:ss aa").format(time);
    var dateTimeUTC = DateFormat("MM/dd/yyyy").format(time);

    return dateTimeUTC.toString();

    // return timeago.format(time.isUtc ? time.toLocal() : time);
  }

  DateTime getUtcTime(String dateTime) {
    if (dateTime.contains("T")) {
      dateTime = dateTime.replaceAll("T", " ");
    }
    var dateTimeUTC = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime, true);
    return dateTimeUTC;
  }

  String parseDateTime(DateTime time, String formatExp) {
    final format = DateFormat(formatExp);
    String timeStr = format.format(time);
    return timeStr;
  }

  String getTime(int time) {
    int timeStamp = DateTime.now().microsecondsSinceEpoch;
    String convert = parseDateTime(fromTimeStamp(time), "dd/MM/yyyy hh:mm aa");

    return convert;
  }

  DateTime convertStringSeconds(String dateTime,
      {format = "yyyy-MM-dd hh:mm:ss", isHour12 = false}) {
    dateTime = dateTime;
    if (dateTime.contains("T")) {
      dateTime = dateTime.replaceAll("T", " ");
    }

    var timess = parseDateTime(DateFormat(format).parse(dateTime), format);

    if (isHour12) {
      return DateFormat("yyyy-MM-dd HH:mm:ss").parse(timess);
    }
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(timess);
  }
}
