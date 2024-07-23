import 'package:credit_card_capture/utils/card_types.dart';
import 'package:credit_card_capture/utils/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test start, prettyCardNumber function', () {
    test('Valid card number should be formatted correctly', () {
      final cardNumber = Helpers.getPrettyCardNumber("4232734642928430");
      expect(cardNumber, "4232 7346 4292 8430");
    });

    test('Invalid card number should be formatted correctly', () {
      final cardNumber = Helpers.getPrettyCardNumber("4232734642928430321");
      expect(cardNumber, "4232 7346 4292 8430 321");
    });

    test(
        'Pretty formatted card number should be trimmed and reformatted correctly',
        () {
      final cardNumber = Helpers.getPrettyCardNumber("4232 7346 4292 8430");
      expect(cardNumber, "4232 7346 4292 8430");
    });

    test('Empty card number should be returned as an empty string', () {
      final cardNumber = Helpers.getPrettyCardNumber("");
      expect(cardNumber, "");
    });
  });

  group('Test start, getCleanedNumber function', () {
    test('Pretty card number should be cleaned correctly', () {
      final cardNumber = Helpers.getCleanedNumber("4232 7346 4292 8430");
      expect(cardNumber, "4232734642928430");
    });

    test('Invalid card number should be formatted correctly', () {
      final cardNumber = Helpers.getCleanedNumber("4232 7346 4292 8430 321");
      expect(cardNumber, "4232734642928430321");
    });

    test('Cleaned card number should be returned as-is', () {
      final cardNumber = Helpers.getCleanedNumber("4232734642928430");
      expect(cardNumber, "4232734642928430");
    });

    test('Empty card number should be returned as an empty string', () {
      final cardNumber = Helpers.getCleanedNumber("");
      expect(cardNumber, "");
    });
  });

  group('Test start, getCardIcon function', () {
    test('Pretty card number should return the correct card type', () {
      final type = Helpers.getCardTypeFromNumber("4232 7346 4292 8430");
      expect(type, CardType.visa);
    });

    test('Cleaned card number should be formatted correctly', () {
      final type = Helpers.getCardTypeFromNumber("5232734642928430");
      expect(type, CardType.mastercard);
    });

    test('Invalid card number should return invalid', () {
      final type = Helpers.getCardTypeFromNumber("00000000000000000");
      expect(type, CardType.invalid);
    });

    test('Empty card number should be returned as an empty string', () {
      final type = Helpers.getCardTypeFromNumber("");
      expect(type, CardType.invalid);
    });
  });
}
