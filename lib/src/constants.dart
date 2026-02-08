import 'package:flutter/cupertino.dart';

/// Language code for Korean.
const String ko = 'ko';

/// Language code for French.
const String fr = 'fr';

/// Language code for German.
const String de = 'de';

/// Language code for Vietnamese.
const String vi = 'vi';

/// Language code for English.
const String en = 'en';

/// Language code for Indonesian.
const String id = 'id';

/// Language code for Italian.
const String it = 'it';

/// Language code for Thai.
const String th = 'th';

/// Language code for Spanish.
const String es = 'es';

/// Language code for Dutch.
const String nl = 'nl';

/// Language code for Chinese.
const String zh = 'zh';

/// Language code for Arabic.
const String ar = 'ar';

/// Language code for Portuguese.
const String pt = 'pt';

/// Language code for Turkish.
const String tr = 'tr';

/// Extension on [Locale] that provides localized month names.
extension LocaleExtension on Locale {
  /// Returns a list of localized month names for the current [languageCode].
  List<String> get months {
    switch (languageCode) {
      case en:
        return enMonths;
      case fr:
        return frMonths;
      case de:
        return deMonths;
      case vi:
        return viMonths;
      case id:
        return idMonths;
      case it:
        return itMonths;
      case th:
        return thMonths;
      case es:
        return esMonth;
      case nl:
        return nlMonth;
      case ar:
        return arMonths;
      case pt:
        return ptMonths;
      case tr:
        return trMonths;
      default:
        return intMonths;
    }
  }
}

const List<String> intMonths = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
];
const List<String> enMonths = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
const List<String> frMonths = [
  'Janvier',
  'Février',
  'Mars',
  'Avril',
  'Mai',
  'Juin',
  'Juillet',
  'Août',
  'Septembre',
  'Octobre',
  'Novembre',
  'Décembre',
];
const List<String> deMonths = [
  'Januar',
  'Februar',
  'März',
  'April',
  'Mai',
  'Juni',
  'Juli',
  'August',
  'September',
  'Oktober',
  'November',
  'Dezember',
];
const List<String> viMonths = [
  'Tháng 1',
  'Tháng 2',
  'Tháng 3',
  'Tháng 4',
  'Tháng 5',
  'Tháng 6',
  'Tháng 7',
  'Tháng 8',
  'Tháng 9',
  'Tháng 10',
  'Tháng 11',
  'Tháng 12',
];
const List<String> idMonths = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];
const List<String> itMonths = [
  'Gennaio',
  'Febbraio',
  'Marzo',
  'Aprile',
  'Maggio',
  'Giugno',
  'Luglio',
  'Agosto',
  'Settembre',
  'Ottobre',
  'Novembre',
  'Dicembre',
];
const List<String> thMonths = [
  'มกราคม',
  'กุมภาพันธ์',
  'มีนาคม',
  'เมษายน',
  'พฤษภาคม',
  'มิถุนายน',
  'กรกฎาคม',
  'สิงหาคม',
  'กันยายน',
  'ตุลาคม',
  'พฤศจิกายน',
  'ธันวาคม',
];
const List<String> esMonth = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre',
];
const List<String> nlMonth = [
  'Januari',
  'Februari',
  'Maart',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Augustus',
  'September',
  'Oktober',
  'November',
  'December',
];
const List<String> arMonths = [
  'يناير',
  'فبراير',
  'مارس',
  'أبريل',
  'مايو',
  'يونيو',
  'يوليو',
  'أغسطس',
  'سبتمبر',
  'أكتوبر',
  'نوفمبر',
  'ديسمبر',
];

const List<String> ptMonths = [
  'janeiro',
  'fevereiro',
  'março',
  'abril',
  'maio',
  'junho',
  'julho',
  'agosto',
  'setembro',
  'outubro',
  'novembro',
  'dezembro',
];

const List<String> trMonths = [
  'Ocak',
  'Şubat',
  'Mart',
  'Nisan',
  'Mayıs',
  'Haziran',
  'Temmuz',
  'Ağustos',
  'Eylül',
  'Ekim',
  'Kasım',
  'Aralık',
];
