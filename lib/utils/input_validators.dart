import 'package:credit_card_capture/utils/helpers.dart';

import 'card_types.dart';

class Validators {
  static bool isValidCardNumber(String input) {
    var cleanedNumber = Helpers.getCleanedNumber(input);

    if (Helpers.getCardTypeFromNumber(input) == CardType.invalid) {
      return false;
    }

    if (cleanedNumber.length != 16) {
      return false;
    }

    int sum = 0;
    int length = cleanedNumber.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(cleanedNumber[length - i - 1]);
      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }
    if (sum % 10 != 0) {
      return false;
    }
    return true;
  }

  static bool isValidCardHolderName(String name) {
    String onlyLetters = name.replaceAll(RegExp(r'(\d+)'), "").trim();
    return onlyLetters.length > 3;
  }

  static bool isValidCardCvvNumber(String number) {
    String trimmed = number.trim();
    return trimmed.length == 3 || trimmed.length == 4;
  }

  static bool isValidCardExpiryDate(String date) {
    if (date.isEmpty) {
      return false;
    }

    if (date.contains(RegExp(r'(/)'))) {
      var split = date.split(RegExp(r'(/)'));
      int month = int.parse(split[0]);
      int year = int.parse(split[1]);

      if ((month < 1) || (month > 12)) {
        return false;
      }
      var fourDigitsYear = Helpers.convertYearTo4Digits(year);
      if ((fourDigitsYear < DateTime.now().year) || (fourDigitsYear > 2099)) {
        return false;
      }
      if (!Helpers.hasDateExpired(month, year)) {
        return true;
      }
    }
    return false;
  }
}
