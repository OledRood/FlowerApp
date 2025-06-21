class DeclensionDateWord{


  DeclensionDateWord();

  static String daysName(days) {
    switch (_variant(days)) {
      case 0:
        return '$days день';
      case 1:
        return '$days дня';
      default:
        return "$days дней";
    }
  }

  static String monthName(months) {
    switch (_variant(months)) {
      case 0:
        return '$months месяц';
      case 1:
        return '$months месяца';
      default:
        return "$months месяцев";
    }
  }

  static String yearName(years) {
    switch (_variant(years)) {
      case 0:
        return '$years год';
      case 1:
        return '$years года';
      default:
        return "$years лет";
    }
  }

  static int _variant(int date) {
    String dateString = date.toString();
    int lastNum = int.parse(dateString[dateString.length - 1]);
    if (lastNum == 1) {
      return 0;
    }
    if (lastNum >= 2 && lastNum <= 5) {
      return 1;
    }
    return 3;
  }
}