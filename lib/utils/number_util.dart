import 'dart:math';

class NumberUtil {
  static bool isIntegral(num x) => x is int || x.truncateToDouble() == x;

  static double floor(double value, int digits) {
    double base = pow(10, digits).toDouble();
    return (value * base).toInt().toDouble() / base;
  }

  static double round(double value, int digits) {
    double base = pow(10, digits).toDouble();
    return (value * base).round().toDouble() / base;
  }
}
