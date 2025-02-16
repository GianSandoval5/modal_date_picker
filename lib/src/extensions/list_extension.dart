extension ListExtension on List {
  String get longestString {
    String longestText = '';
    for (var element in this) {
      if ('$element'.length > longestText.length) {
        longestText = '$element'.padLeft(2, '0');
      }
    }
    return longestText;
  }
}
