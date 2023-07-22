import 'package:cloud_firestore/cloud_firestore.dart';

class DayInfo{
  String? id;
  String userId;
  String? text;
  DateTime? date;
  int? dayRating;

  DayInfo(this.id, this.userId, this.text, this.date, this.dayRating);
  DayInfo.fromMap(Map snapshot, String id) :
      id = id ?? '',
      userId = snapshot['userId'] ?? '',
      text = snapshot['text'] ?? '',
      date = snapshot['date'].toDate() ?? DateTime.now(),
      dayRating = snapshot['dayRating'] ?? 0;

  toJson() {
    return {
      "userId": userId,
      "text": text,
      "date": Timestamp.fromDate(date!),
      "dayRating": dayRating,
    };
  }

  bool isDateEqual(DateTime dateTime)
  {
    return date!.year == dateTime.year && date!.month == dateTime.month && date!.day == dateTime.day;
  }

  @override
  bool operator ==(Object other) {
    return other is DayInfo
        && other.text == text
        && other.dayRating == dayRating;
  }

}