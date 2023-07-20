extension DateTimeExtensions on DateTime{

  static List<String> monthsEn = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  static List<String> monthsLt = ['Sausio', 'Vasario', 'Kovo', 'Balandžio', 'Gegužės', 'Birželio', 'Liepos', 'Rugpjūčio', 'Rugsėjo', 'Spalio', 'Lapkričio', 'Gruodžio'];

  String toStringShort({String locale = 'en'})
  {
    switch(locale)
    {
      case 'en':
        return '${monthsEn[this.month-1]} ${this.day}';
      case 'lt':
        return '${monthsLt[this.month-1]} ${this.day}d.';
      default:
        return '${monthsEn[this.month-1]} ${this.day}';
    }
  }
}