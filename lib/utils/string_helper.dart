class StringHelper {
  static String getDateString(DateTime date) {
    DateTime localDate = date.toLocal();
    return localDate.month.toString() +
        '/' +
        localDate.day.toString() +
        '/' +
        (localDate.year % 100).toString();
  }

  static String getDateStringNoYear(DateTime date) {
    DateTime localDate = date.toLocal();
    return localDate.month.toString() + '/' + localDate.day.toString();
  }

  static String getTimeString(DateTime date) {
    DateTime localDate = date.toLocal();
    String minute = localDate.minute.toString();
    if (localDate.minute < 10) {
      minute = '0' + minute;
    }
    String ending = 'am';
    String hour = localDate.hour.toString();
    if (localDate.hour >= 12) {
      ending = 'pm';
      hour = (localDate.hour - 12).toString();
    } else if (localDate.hour == 0) {
      hour = '12';
    }
    return hour + ':' + minute + ' ' + ending;
  }

}
