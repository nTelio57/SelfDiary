import 'package:cloud_firestore/cloud_firestore.dart';

class DayInfo{
  String id;
  String text;
  DateTime date;
  int dayRating;

  DayInfo(this.id, this.text, this.date, this.dayRating);
  DayInfo.fromMap(Map snapshot, String id) :
      id = id ?? '',
      text = snapshot['text'] ?? '',
      date = snapshot['date'].toDate() ?? DateTime.now(),
      dayRating = snapshot['dayRating'] ?? 0;

  toJson() {
    return {
      "text": text,
      "date": Timestamp.fromDate(date),
      "dayRating": dayRating,
    };
  }

  bool isDateEqual(DateTime dateTime)
  {
    return date.year == dateTime.year && date.month == dateTime.month && date.day == dateTime.day;
  }
}