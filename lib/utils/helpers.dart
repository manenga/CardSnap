import 'package:flutter/material.dart';

import 'card_types.dart';

class Helpers {
  static Widget? getCardIcon(CardType? cardType) {
    String img = "";
    switch (cardType) {
      case CardType.mastercard:
        img = 'mastercard.png';
        break;
      case CardType.visa:
        img = 'visa.png';
        break;
      case CardType.americanExpress:
        img = 'american-express.png';
        break;
      default:
        break;
    }
    Widget? widget;
    if (img.isNotEmpty) {
      widget = Image.asset(
        'assets/images/$img',
        width: 40.0,
      );
    }
    return widget;
  }

  static CardType getCardTypeFromNumber(String input) {
    CardType cardType;
    var cleanedNumber = getCleanedNumber(input);
    if (cleanedNumber.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.mastercard;
    } else if (cleanedNumber.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.visa;
    } else if (cleanedNumber.startsWith(RegExp(r'((34)|(37))'))) {
      cardType = CardType.americanExpress;
    } else {
      cardType = CardType.invalid;
    }
    return cardType;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static StringBuffer getBufferFromCardNumber(String cardNumber) {
    String chars = cardNumber.replaceAll(" ", "").trim();
    StringBuffer buffer = StringBuffer();
    for (var i = 0; i < chars.length; i++) {
      buffer.write(chars[i]);
      int index = i + 1;

      if (index % 4 == 0 && chars.length != index) {
        buffer.write(" ");
      }
    }
    return buffer;
  }

  static String getPrettyCardNumber(String cardNumber) {
    return getBufferFromCardNumber(cardNumber).toString();
  }

  static StringBuffer getBufferFromExpiryDate(String input) {
    String inputChars = input;
    StringBuffer buffer = StringBuffer();
    for (var i = 0; i < inputChars.length; i++) {
      buffer.write(inputChars[i]);
      int index = i + 1;

      if (index % 2 == 0 && inputChars.length != index) {
        buffer.write("/");
      }
    }
    return buffer;
  }

  static String getFormattedExpiryDate(String input) {
    return getBufferFromExpiryDate(input).toString();
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100) {
      int currentYear = DateTime.now().year;
      int currentCentury = (currentYear / 100).floor() * 100;
      return currentCentury + year;
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    DateTime now = DateTime.now();
    DateTime expiryDate = DateTime(fourDigitsYear, month + 1, 0);

    return expiryDate.isBefore(now);
  }
}
