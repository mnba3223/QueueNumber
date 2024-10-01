import 'number_util.dart';

class StringUtil {
  static bool isEmpty(String? text) {
    return text == null || text.isEmpty;
  }

  static bool isNotEmpty(String? text) {
    return text != null && text.isNotEmpty;
  }

  static bool isString<T>(T text) {
    return text != null && text is String;
  }

  static bool isInt(String? text) {
    if (text == null) return false;
    return int.tryParse(text) != null;
  }

  static bool isNumeric(String? text) {
    if (text == null) return false;
    return double.tryParse(text) != null;
  }

  static bool gte(String? text, int length) {
    return text != null && text.length >= length;
  }

  static String convert(value, {String suffix = '', defaultText = '--'}) {
    if (value == null) return defaultText;

    if (value is double) {
      return '${NumberUtil.isIntegral(value) ? value.toInt() : NumberUtil.round(value, 2)}${suffix.isNotEmpty ? ' $suffix' : ''}';
    } else {
      return '$value${suffix.isNotEmpty ? ' $suffix' : ''}';
    }
  }

  static String? trim(String? text) {
    if (text == null) return null;

    return text.trim();
  }

  static String? removeSpace(String? text) {
    if (text == null) return null;

    return text.trim().replaceAll(' ', '');
  }

  static List<String>? splitByLength(String? text, int? length) {
    if (text == null || length == null) return null;

    List<String> l = [];
    for (int i = 0; i < text.length; i += length) {
      int j = i + length;
      if (j >= text.length) j = text.length;
      l.add(text.substring(i, i + length));
    }
    return l;
  }
}
