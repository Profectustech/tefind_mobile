import 'package:intl/intl.dart';

class Sort {
  /// handle grouping of data --- used particularly to group dates in the history screen
  static Map<K, List<T>> groupBy<T, K>(
      Iterable<T> items, K Function(T) keyFunc) {
    return items.fold(<K, List<T>>{}, (Map<K, List<T>> map, T item) {
      final key = keyFunc(item);
      final list = map.putIfAbsent(key, () => <T>[]);
      list.add(item);
      return map;
    });
  }

  static String getFormattedDate(isToday, isYesterday, date) {
    String formattedDate;
    if (isToday) {
      formattedDate = 'Today';
    } else if (isYesterday) {
      formattedDate = 'Yesterday';
    } else {
      final formatter = DateFormat('MMMM dd, yyyy');
      formattedDate = formatter.format(date);
    }
    return formattedDate;
  }
}

String shortDate(String date) {
  return DateFormat("MMM dd, yyyy")
      .format(DateTime.tryParse(date) ?? DateTime.now());
}
String shortDateIncomeExpense(String date) {
  return DateFormat("yyyy-MM-dd")
      .format(DateTime.tryParse(date) ?? DateTime.now());
}


String shortDate2(String date) {
  return DateFormat("dd/MM/yyyy")
      .format(DateTime.tryParse(date) ?? DateTime.now());
}

String shortDate3(String date) {
  return DateFormat("MMM dd").format(DateTime.tryParse(date) ?? DateTime.now());
}
String shortDate4(String date) {
  return DateFormat("dd MMM").format(DateTime.tryParse(date) ?? DateTime.now());
}
String shortDate5(String date) {
  return DateFormat("MMM").format(DateTime.tryParse(date) ?? DateTime.now());
}
String shortDate6(String date) {
  return DateFormat("yyyy").format(DateTime.tryParse(date) ?? DateTime.now());
}

String shortDate7(String date) {
  final dayOfMonth = (DateTime.tryParse(date) ?? DateTime.now()).day;
  String suffix = _getDayOfMonthSuffix(dayOfMonth);
  return DateFormat("d'$suffix' MMM yyyy").format(DateTime.tryParse(date) ?? DateTime.now());
}

String shortDateOfTheMonth(String date) {
  final dayOfMonth = (DateTime.tryParse(date) ?? DateTime.now()).day;
  String suffix = _getDayOfMonthSuffix(dayOfMonth);
  return DateFormat("d'$suffix'").format(DateTime.tryParse(date) ?? DateTime.now());
}

String shortDateAndTime7(String date) {
  return DateFormat("h:mm a / dd-MM-yyy")
      .format(DateTime.tryParse(date) ?? DateTime.now());
}

String shortDateAndTime(String date) {
  return DateFormat("dd MMMM, yyyy, h:mm a")
      .format(DateTime.tryParse(date) ?? DateTime.now());
}

String shortDateAndTime8(String date) {
  return DateFormat("EEEE, dd MMMM yyyy")
      .format(DateTime.tryParse(date) ?? DateTime.now());
}

String shortDate9(String date) {
  return DateFormat("MMMM").format(DateTime.tryParse(date) ?? DateTime.now());
}
String shortDateAndTime3(String date) {
  return DateFormat("dd/MM/yyyy h:mm a")
      .format(DateTime.tryParse(date) ?? DateTime.now());
}

String shortDateAndTimeWithoutyear(String date) {
  return DateFormat("h:mm a dd MMM")
      .format(DateTime.tryParse(date) ?? DateTime.now());
}

String shortTime(String date) {
  return DateFormat("h:mm a").format(DateTime.tryParse(date) ?? DateTime.now());
}

String differenceBetweenDatesInMonth(String date) {
  return DateTime.now().difference(DateTime.parse(date)).inDays.toString();
}

String _getDayOfMonthSuffix(int dayOfMonth) {
  if (dayOfMonth >= 11 && dayOfMonth <= 13) {
    return 'th';
  }
  switch (dayOfMonth % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
