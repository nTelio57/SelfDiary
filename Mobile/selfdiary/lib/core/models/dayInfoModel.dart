class DayInfo{
  String id;
  String text;
  DateTime date;
  int dayRating;

  DayInfo(this.id, this.text, this.date, this.dayRating);
  DayInfo.fromMap(Map snapshot, String id) :
      id = id ?? '',
      text = snapshot['text'] ?? '',
      date = snapshot['date'] ?? DateTime.now(),
      dayRating = snapshot['dayRating'] ?? 0;

  toJson() {
    return {
      "text": text,
      "date": date,
      "dayRating": dayRating,
    };
  }
}