import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Converts a datetime string from either 12-hour format with AM/PM or 24-hour format to 24-hour format.
///
/// [input] is the datetime string which can be in either 12-hour format, e.g., "2024/5/14 上午 09:58",
/// or 24-hour format, e.g., "2024-05-28 15:00:44".
/// Returns the time in 24-hour format without seconds, e.g., "09:58" or "15:00".
///
/// This function ignores the date part and focuses on converting the time part.
String convertTimeTo24HourFormat(String input) {
  DateTime parsedDateTime;
  DateFormat outputFormat = DateFormat("HH:mm");

  try {
    // Try to parse the input as 12-hour format with AM/PM
    DateFormat inputFormat12Hour = DateFormat("yyyy/M/d a hh:mm", "zh_Hant");
    parsedDateTime = inputFormat12Hour.parse(input);
  } catch (e) {
    try {
      // If the first format fails, try to parse the input as 24-hour format
      DateFormat inputFormat24Hour = DateFormat("yyyy-MM-dd HH:mm:ss");
      parsedDateTime = inputFormat24Hour.parse(input);
    } catch (e) {
      // If both formats fail, return an error message or handle it accordingly
      return 'Invalid date format';
    }
  }

  // Convert the parsed date time to UTC+8 time zone
  final utcPlus8DateTime = setUTCPlus8(parsedDateTime.toIso8601String());

  // Convert and return the formatted time in 24-hour format
  return outputFormat.format(utcPlus8DateTime);
}

TimeOfDay parseTime(String time) {
  final parts = time.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

bool isTimeWithinRange(
    TimeOfDay currentTime, TimeOfDay startTime, TimeOfDay endTime) {
  final int currentMinutes = currentTime.hour * 60 + currentTime.minute;
  final int startMinutes = startTime.hour * 60 + startTime.minute;
  final int endMinutes = endTime.hour * 60 + endTime.minute;

  return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
}

DateTime getCurrentTime() {
  return DateTime.now().toUtc().add(Duration(hours: 8));
}

/// Converts a DateTime string to UTC+8
DateTime setUTCPlus8(String time) {
  final parsedDateTime = DateTime.tryParse(time)?.toUtc();
  if (parsedDateTime == null) {
    throw FormatException('Invalid date format');
  }
  return parsedDateTime.add(Duration(hours: 8));
}
