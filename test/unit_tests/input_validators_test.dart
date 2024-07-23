import 'package:credit_card_capture/utils/input_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test start, isValidCardNumber function', () {
    test('Valid card number should be formatted correctly', () {
      final isValid = Validators.isValidCardNumber("4242 4242 4242 4242");
      expect(isValid, true);
    });

    test('Invalid card number should return false', () {
      final isValid = Validators.isValidCardNumber("4232734642928430321");
      expect(isValid, false);
    });

    test('Invalid card number should return false', () {
      final isValid = Validators.isValidCardNumber("4232 7346 8430");
      expect(isValid, false);
    });

    test('Empty card number should return false', () {
      final isValid = Validators.isValidCardNumber("");
      expect(isValid, false);
    });
  });

  group('Test start, isValidCardHolderName function', () {
    test('Valid card holder name should return true', () {
      final isValid = Validators.isValidCardHolderName("Manga Mutandis");
      expect(isValid, true);
    });

    test('Invalid card holder name should return false', () {
      final isValid = Validators.isValidCardHolderName("Pi");
      expect(isValid, false);
    });

    test('Invalid card holder name should return false', () {
      final isValid =
          Validators.isValidCardHolderName("          123x523900    ");
      expect(isValid, false);
    });

    test('Empty card holder name should return false', () {
      final isValid = Validators.isValidCardHolderName("");
      expect(isValid, false);
    });
  });

  group('Test start, isValidCardExpiryDate function', () {
    test('Valid expiry date should return true', () {
      final isValid = Validators.isValidCardExpiryDate("10/27");
      expect(isValid, true);
    });

    test('Invalid expiry date should return false', () {
      final isValid = Validators.isValidCardExpiryDate("25/54");
      expect(isValid, false);
    });

    test('Invalid expiry date should return false', () {
      final isValid = Validators.isValidCardExpiryDate("10/22");
      expect(isValid, false);
    });

    test('Empty expiry date should return false', () {
      final isValid = Validators.isValidCardExpiryDate("");
      expect(isValid, false);
    });
  });
}
