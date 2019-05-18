class DateUtils {
  static DateTime formatExpiresTime(String str) {
    var expiresTime =
    RegExp("Expires[^;]*;").stringMatch(str).split(" ")[1].split("-");
    print("expiresTime$expiresTime");
    var year = expiresTime[2].replaceAll("\n", "");
    var day = expiresTime[0];
    var month = _getMonthByStr(expiresTime[1]);
    String time ="$year$month$day";
    print("time:$time");
    return DateTime.parse(time);
  }

  static DateTime getDaysAgo(int days) {
    return DateTime.now().subtract(Duration(days: days));
  }

  static String _getMonthByStr(String str) {
    String output = "01";
    switch (str) {
      case "Jan":
        output = "01";
        break;
      case "Feb":
        output = "02";
        break;
      case "Mar":
        output = "03";
        break;
      case "Apr":
        output = "04";
        break;
      case "May":
        output = "05";
        break;
      case "Jun":
        output = "06";
        break;
      case "Jul":
        output = "07";
        break;
      case "Aug":
        output = "08";
        break;
      case "Sep":
        output = "09";
        break;
      case "Oct":
        output = "10";
        break;
      case "Nov":
        output = "11";
        break;
      case "Dec":
        output = "12";
        break;
    }
    return output;
  }
}