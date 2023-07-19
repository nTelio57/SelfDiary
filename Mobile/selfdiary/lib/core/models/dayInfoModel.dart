class DayInfo{
  String id;
  String text;

  DayInfo(this.id, this.text);
  DayInfo.fromMap(Map snapshot, String id) :
      id = id ?? '',
      text = snapshot['text'] ?? '';

  toJson() {
    return {
      "text": text
    };
  }
}