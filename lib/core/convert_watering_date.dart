class ConvertWateringDate{
  static List<DateTime> wateringDatesToList(String str) {
    if(str == "" || str == ' '){
      return [];
    }
    return str.split(",").map((dateString){return DateTime.parse(dateString);}).toList();
  }

  static String wateringDatesToString(List<DateTime> list){
    return list.map((date){return date.toString();}).join(',');
  }
}