/// Extension on [List] to find the longest string representation.
extension ListExtension on List {
  /// Returns the longest string representation among the elements, left-padded to 2 chars.
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
