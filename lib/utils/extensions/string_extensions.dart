import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../exports.dart';
import '../../packages/animated_counter/animated_counter.dart';

extension StrExtension on String {
  /// Returns the first name if [isFirstName] is true (default),
  /// otherwise returns the remaining name (excluding the first name).
  /// Handles null or empty input gracefully.
  static String getNamePart(String? fullName, {bool? isFirstName = true}) {
    if (fullName == null || fullName.trim().isEmpty) return '';
    final parts = fullName.trim().split(' ');

    if (isFirstName == true) {
      return parts.first;
    } else {
      return parts.length > 1 ? parts.sublist(1).join(' ') : '';
    }
  }

  /* static String getFirstName({required String fullName}) {
    // Split the name based on spaces
    List<String> nameParts = fullName.split(' ');

    // Check if there are multiple parts
    if (nameParts.length > 1) {
      // Extract the first name
      String firstName = nameParts[0];
      return firstName;
    } else {
      // Handle case where full name doesn't have spaces
      return fullName;
    }
  } */

  /* static String getLastName({required String fullName}) {
    // Split the name based on spaces
    List<String> nameParts = fullName.split(' ');

    // Check if there are multiple parts
    if (nameParts.length > 1) {
      // Extract the last name
      return nameParts.last;
    } else {
      return ""; // Return empty string if last name doesn't exist
    }
  } */

  static String getFullName(String firstName, String lastName) {
    return "$firstName $lastName";
  }

  static String formatTime(int totalMinutes, {bool sortForm = false}) {
    final int hours = totalMinutes ~/ 60; // Getting total hours
    final int minutes = totalMinutes % 60; // Getting remaining minutes

    // Formatting the time into a string representation
    if (sortForm) {
      return '${hours >= 1 ? '${hours}h' : ''} $minutes min${minutes != 1 ? 's' : ''}';
    } else {
      return '$hours hour${hours != 1 ? 's' : ''} $minutes minute${minutes != 1 ? 's' : ''}';
    }
  }

  static String camelCaseToSnakeCase(String input) {
    final StringBuffer result = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      final String char = input[i];
      if (char.toUpperCase() == char) {
        if (i > 0) {
          result.write('_');
        }
        result.write(char.toLowerCase());
      } else {
        result.write(char);
      }
    }
    return result.toString();
  }

  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return substring(0, 1).toUpperCase() + substring(1);
  }

  static String dateChecker(DateTime dateTime, {String? pattern, bool onlyToday = false}) {
    final DateTime date = dateTime.toLocal();
    final DateTime now = DateTime.now().toLocal();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      return 'Today';
    } else if (date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day && onlyToday == false) {
      return 'Tomorrow';
    } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day && onlyToday == false) {
      return 'Yesterday';
    } else {
      return Jiffy.parseFromDateTime(date).format(pattern: !isValEmpty(pattern) ? pattern : 'do MMMM yyyy');
    }
  }

  static String getSubTitle(DateTime selectedDate) {
    final DateTime now = DateTime.now();
    final DateTime selected = selectedDate;
    final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (selected.year == now.year && selected.month == now.month && selected.day == now.day) {
      return Jiffy.parseFromDateTime(selected).format(pattern: 'EEEE, do MMM');
    } else if (selected.year == tomorrow.year && selected.month == tomorrow.month && selected.day == tomorrow.day) {
      return Jiffy.parseFromDateTime(selected).format(pattern: 'EEEE, do MMM');
    } else if (selected.year == yesterday.year && selected.month == yesterday.month && selected.day == yesterday.day) {
      return Jiffy.parseFromDateTime(selected).format(pattern: 'EEEE, do MMM');
    } else {
      return "Today";
    }
  }

  static String todayDateCheck(DateTime dateTime, {String? pattern}) {
    final DateTime date = dateTime;
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      return 'Today';
    } else {
      return Jiffy.parseFromDateTime(date).format(pattern: !isValEmpty(pattern) ? pattern : 'do MMMM yyyy');
    }
  }

  /// Time Calculate --------- >>>
  static String calculateTimeAndDate(DateTime dateTime) {
    final DateTime now = DateTime.now();

    if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
      final Duration difference = now.difference(dateTime);
      if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'}';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'}';
      } else {
        return 'Just now';
      }
    } else {
      return Jiffy.parseFromDateTime(dateTime).format(pattern: 'MMM d');
    }
  }

  static String calculateAgeDateTime(DateTime birthDate) {
    final DateTime currentDate = DateTime.now();

    int years = currentDate.year - birthDate.year;
    int months = currentDate.month - birthDate.month;
    int days = currentDate.day - birthDate.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(currentDate.year, currentDate.month, 0).day;
    }

    if (months < 0) {
      years -= 1;
      months += 12;
    }

    if (years > 0) {
      return '$years Year${years > 1 ? 's' : ''} Old';
    } else if (months > 0) {
      return '$months Month${months > 1 ? 's' : ''} Old';
    } else {
      return '$days Day${days > 1 ? 's' : ''} Old';
    }
  }

  /// Birth Date Calculate --------- >>>
  static String calculateAge({int? year = 0, int? month = 0, int? date = 0}) {
    if (year == 0 && month == 0 && date == 0 || year == null && month == null && date == null) {
      return '';
    }

    // Birth date
    final DateTime birthDate = DateTime(year ?? 0, month ?? 0, date ?? 0);

    // Current date
    final DateTime currentDate = DateTime.now();

    // Check if birth date is in the future
    if (birthDate.isAfter(currentDate)) {
      return '';
      // return 'Birth date is in the future';
    }

    // Calculate difference
    int years = currentDate.year - birthDate.year;
    int months = currentDate.month - birthDate.month;
    int days = currentDate.day - birthDate.day;

    // Adjust for negative values
    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += 12;
    }
    if (days < 0) {
      days += DateTime(currentDate.year, currentDate.month - 1, 0).day;
      months--;
    }

    // Construct the age string
    if (years > 0) {
      return '$years ${years == 1 ? 'year' : 'years'} old';
    } else if (months > 0) {
      return '$months ${months == 1 ? 'month' : 'months'} old';
    } else if (days == 0) {
      return 'Today';
    } else {
      return '$days ${days == 1 ? 'day' : 'days'} old';
    }
  }

  static String generatePetParentMessage(String userName, List<String>? dogNames, {String? gender}) {
    String dogsMessage;
    final String pronoun = (gender?.toLowerCase()) == 'female'
        ? 'her'
        : (gender?.toLowerCase()) == 'male'
        ? 'his'
        : 'their'; // default for null or "prefer_not_to_say"

    final String connectMessage = "Connect with $userName to know more about $pronoun pet parent journey!";
    // final String connectMessage = "Connect with $userName to know more about $pronoun journey as a pet parent!";

    if (dogNames == null) {
      return connectMessage;
    }

    if (dogNames.length == 1) {
      dogsMessage = dogNames.first;
    } else if (dogNames.length == 2) {
      dogsMessage = '${dogNames[0]} and ${dogNames[1]}';
    } else {
      dogsMessage = '${dogNames[0]}, ${dogNames[1]} and more';
    }

    return '$userName is the proud pet parent of $dogsMessage. $connectMessage';
  }

  // String get e {
  //   if (isValEmpty(this)) {
  //     return this;
  //   } else {
  //     // return encryptAESCryptoJS(this, AppStrings.cryptoKey);
  //   }
  // }

  // String get d {
  //   if (isValEmpty(this)) {
  //     return this;
  //   } else {
  //     try {
  //       // return decryptAESCryptoJS(this, AppStrings.cryptoKey);
  //     } catch (e) {
  //       return this;
  //     }
  //   }
  // }

  String formatRoute(String route) {
    // Remove leading slash if present
    if (startsWith('/')) {
      route = substring(1);
    }

    // Add trailing slash if not present
    if (!endsWith('/')) {
      route += '/';
    }

    return route;
  }

  /// Format a list of strings with commas and "and (&)"
  static String formatListWithAnd(List<String?>? items) {
    final cleanedItems = items?.whereType<String>().where((e) => e.trim().isNotEmpty).toList() ?? [];

    if (cleanedItems.isEmpty) return '';
    if (cleanedItems.length == 1) return cleanedItems.first;
    if (cleanedItems.length == 2) return '${cleanedItems[0]} & ${cleanedItems[1]}';
    return '${cleanedItems.sublist(0, cleanedItems.length - 1).join(', ')} & ${cleanedItems.last}';
  }

  /// Returns the singular or plural form of a word based on the [count].
  ///
  /// - If [count] is 1, returns [singular].
  /// - If [count] is not 1:
  ///   - Returns [plural] if provided.
  ///   - Otherwise, returns [singular] with 's' appended as a basic fallback.
  ///
  /// This function is null-safe and treats `null` count as 0.
  ///
  /// Example:
  /// ```dart
  /// pluralize(count: 1, singular: 'Review'); // 'Review'
  /// pluralize(count: 3, singular: 'Review'); // 'Reviews'
  /// pluralize(count: 2, singular: 'Category', plural: 'Categories'); // 'Categories'
  /// ```
  ///
  /// Note:
  /// This fallback approach is simple and does **not** handle irregular plurals.
  /// For example:
  /// - 'Category' → 'Categorys' (should be 'Categories')
  /// - 'Bus' → 'Buss' (should be 'Buses')
  /// ```
  static String pluralize({
    required int? count,
    required String singular,
    String? plural,
  }) {
    final int safeCount = count ?? 0;
    final String fallbackPlural = singular.endsWith('s') ? singular : '${singular}s';

    return safeCount <= 1 ? singular : (plural ?? fallbackPlural);
  }

  /// Returns a human-readable "time ago" string from this [DateTime] to now.
  ///
  /// Examples:
  /// - "just now"
  /// - "5 seconds ago"
  /// - "2 minutes ago"
  /// - "1 hour ago"
  /// - "3 days ago"
  /// - "2 weeks ago"
  /// - "1 month ago"
  /// - "1 year ago"
  /// ```
  static String getTimeAgo(DateTime dateTime, {bool isShowOnlyMinutes = false}) {
    final DateTime now = DateTime.now();
    final Duration diff = now.difference(dateTime);

    if (diff.inSeconds < 5) return 'Just now';
    if (diff.inSeconds < 60) return '${diff.inSeconds} sec ago';
    if (!isShowOnlyMinutes) {
      if (diff.inMinutes < 60) return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
      if (diff.inHours < 24) return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
      if (diff.inDays < 7) return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
      if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} week${(diff.inDays / 7).floor() == 1 ? '' : 's'} ago';
      if (diff.inDays < 365) return '${(diff.inDays / 30).floor()} month${(diff.inDays / 30).floor() == 1 ? '' : 's'} ago';
      return '${(diff.inDays / 365).floor()} year${(diff.inDays / 365).floor() == 1 ? '' : 's'} ago';
    } else {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
      // return AppDateFormatter.formatToTimeOnly(dateTime.toString());
    }
  }

  /// Parses this string to an [int] and formats it into a short form string.
  ///
  /// Returns:
  /// - Original number as a string if less than 1,000 ("950")
  /// - Value in "k" for thousands ("1.2k")
  /// - Value in "M" for millions ("3.4M")
  ///
  /// Examples:
  /// - `"1200".formatCount()` → `"1.2k"`
  /// - `"5000000".formatCount()` → `"5M"`
  /// ```
  String formatCount() {
    final int parsed = int.tryParse(this) ?? 0;

    if (parsed < 1000) return parsed.toString();
    if (parsed < 1000000) {
      return '${(parsed / 1000).toStringAsFixed(1).replaceAll('.0', '')}k';
    } else {
      return '${(parsed / 1000000).toStringAsFixed(1).replaceAll('.0', '')}M';
    }
  }

  /// Character Counter
  static RichText characterCounter({required RxInt currentLength, int maxLength = 50}) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          WidgetSpan(
            child: AnimatedFlipCounter(
              value: currentLength.value,
              textStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, color: Colors.grey.shade500),
            ),
          ),
          WidgetSpan(
            child: Text(
              "/$maxLength Characters",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }

  static String sanitizeMobileNumber(String input) {
    input = input.trim();

    // Remove +91 if present
    if (input.startsWith('+91')) {
      input = input.replaceFirst('+91', '').trim();
    }

    // Optional: remove all non-digit characters
    input = input.replaceAll(RegExp(r'\D'), '');

    // Optional: keep only last 10 digits (in case country code was not removed cleanly)
    if (input.length > 10) {
      input = input.substring(input.length - 10);
    }

    return input;
  }

  /// Returns true if the string contains only numeric characters.
  ///
  /// Example:
  /// ```dart
  /// "123".isNumeric; // true
  /// "12a3".isNumeric; // false
  /// ```
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  /// Removes all whitespace characters (space, tab, newline).
  String removeAllWhitespace() => replaceAll(RegExp(r'\s+'), '');

  /// Shortens a string to [maxLength] and adds "..." at the end if needed.
  ///
  /// Example:
  /// ```dart
  /// "Flutter is awesome".truncate(10); // "Flutter is..."
  /// ```
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}

extension DurationParsing on String? {
  /// Convert a string like "HH:mm:ss" or "mm:ss" into a [Duration].
  /// Returns `Duration.zero` if null, empty, or invalid.
  Duration toDuration() {
    if (this == null || this!.trim().isEmpty) {
      return Duration.zero;
    }

    try {
      final List<String> parts = this!.split(":").map((e) => e.padLeft(2, '0')).toList();

      // Ensure format is always hh:mm:ss
      while (parts.length < 3) {
        parts.insert(0, "00");
      }

      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      final seconds = int.tryParse(parts[2]) ?? 0;

      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    } catch (_) {
      return Duration.zero;
    }
  }
}
