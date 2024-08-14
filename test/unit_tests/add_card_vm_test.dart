import 'package:credit_card_capture/domain/entities/credit_card_entity.dart';
import 'package:credit_card_capture/domain/viewModels/add_card_vm.dart';
import 'package:credit_card_capture/utils/card_error_types.dart';
import 'package:credit_card_capture/utils/card_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mock_restricted_countries_repository.dart';
import '../mocks/mock_wallet_provider.dart';

void main() {
  group('AddNewCardViewModel', () {
    late AddNewCardViewModel viewModel;
    late MockWalletProvider mockWalletProvider;

    setUp(() {
      mockWalletProvider = MockWalletProvider([
        CreditCardEntity(
            cardNumber: '1234567812345678',
            holderName: 'John Doe',
            expiryDate: '12/25',
            cvvNumber: '123',
            cardColor: Colors.black,
            countryCode: 'ZA')
      ]);
      viewModel = AddNewCardViewModel(
          title: 'Add New Card',
          walletProvider: mockWalletProvider,
          repository: MockRestrictedCountriesRepository(
              restrictedCountries: ['US', 'CA']));
    });

    test('initial values are set correctly', () {
      expect(viewModel.cardNumber, "");
      expect(viewModel.cardHolderName, "");
      expect(viewModel.cardCvvNumber, "");
      expect(viewModel.cardExpiryDate, "");
      expect(viewModel.cardColor, Colors.amber);
      expect(viewModel.countryCode, "ZA");
      expect(viewModel.cardType, CardType.invalid);
    });

    test('fetchRestrictedCountries updates restrictedCountries', () async {
      await viewModel.fetchRestrictedCountries();
      expect(viewModel.restrictedCountries, ['US', 'CA']);
    });

    test('isRestrictedCountry returns true for restricted country', () async {
      viewModel.countryCode = 'US';
      await viewModel.fetchRestrictedCountries();
      expect(viewModel.isRestrictedCountry(), isTrue);
    });

    test('isRestrictedCountry returns false for country which is not',
        () async {
      viewModel.countryCode = 'ZM';
      await viewModel.fetchRestrictedCountries();
      expect(viewModel.isRestrictedCountry(), isFalse);
    });

    test('does card exist should return true when card number already exists',
        () {
      viewModel.setCardNumber('1234567812345678');
      expect(viewModel.doesCardAlreadyExist(), isTrue);
    });

    test('does card exist should return false when card number does not exist',
        () {
      viewModel.setCardNumber('4242424242424242');
      expect(viewModel.doesCardAlreadyExist(), isFalse);
    });

    test('isCardValid validates card fields and sets error messages', () {
      viewModel.setCardNumber("1234");
      viewModel.setCardHolderName("John Doe");
      viewModel.setCardCvvNumber("123");
      viewModel.setCardExpiryDate("12/25");
      bool isValid = viewModel.isCardValid();
      expect(isValid, isFalse);
      expect(viewModel.cardNumberErrorMessage, "Card number is not valid");
    });

    test('isCardValid validates card fields and sets error messages', () {
      viewModel.setCardNumber("4242424242424242");
      viewModel.setCardHolderName("John Doe");
      viewModel.setCardCvvNumber("123");
      viewModel.setCardExpiryDate("12/28");
      bool isValid = viewModel.isCardValid();
      expect(isValid, isTrue);
    });

    test('setCardErrorMessage updates the correct error message', () {
      viewModel.setCardErrorMessage(
          CardErrorType.number, "Invalid card number");
      expect(viewModel.cardNumberErrorMessage, "Invalid card number");
    });
  });
}
