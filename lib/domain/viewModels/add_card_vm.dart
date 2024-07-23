import 'package:credit_card_capture/utils/card_types.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/restricted_countries_repository.dart';
import '../../presentation/providers/wallet_provider.dart';
import '../../utils/helpers.dart';
import '../../utils/input_validators.dart';
import '../entities/credit_card_entity.dart';
import '../useCases/restricted_countries_use_case.dart';

class AddNewCardViewModel extends ChangeNotifier {
  final String title;
  final WalletProvider walletProvider;
  late List<String> restrictedCountries = [];

  String cardNumber = "";
  String cardHolderName = "";
  String cardCvvNumber = "";
  String cardExpiryDate = "";
  Color cardColor = Colors.amber;
  String countryCode = "ZA";
  CardType? cardType = CardType.invalid;

  String cardNumberErrorMessage = "";
  String cardHolderErrorMessage = "";
  String cardCvvNumberErrorMessage = "";
  String cardExpiryDateErrorMessage = "";

  AddNewCardViewModel({
    required this.title,
    required this.walletProvider,
  });

  CreditCardEntity getCard() {
    return CreditCardEntity(
      cardNumber: cardNumber,
      holderName: cardHolderName,
      cvvNumber: cardCvvNumber,
      expiryDate: cardExpiryDate,
      cardColor: cardColor,
      countryCode: countryCode,
    );
  }

  void fetchRestrictedCountries() async {
    restrictedCountries = await GetRestrictedCountriesUseCase(
            repository: RestrictedCountriesRepositoryImpl())
        .execute();
  }

  bool isRestrictedCountry() {
    print('comparing $countryCode to $restrictedCountries');
    return restrictedCountries
        .where((element) => element == countryCode)
        .isNotEmpty;
  }

  bool doesCardAlreadyExist() {
    return walletProvider.doesCardExist(getCard());
  }

  bool isCardValid() {
    if (!Validators.isValidCardNumber(cardNumber)) {
      cardNumberErrorMessage = "Card number is not valid";
      notifyListeners();
    }
    if (!Validators.isValidCardHolderName(cardHolderName)) {
      cardHolderErrorMessage = "Card holder name is not valid";
      notifyListeners();
    }
    if (!Validators.isValidCardCvvNumber(cardCvvNumber)) {
      cardCvvNumberErrorMessage = "Cvv is not valid";
      notifyListeners();
    }
    if (!Validators.isValidCardExpiryDate(cardExpiryDate)) {
      cardExpiryDateErrorMessage = "Expiry date is not valid";
      notifyListeners();
    }

    if (Validators.isValidCardNumber(cardNumber) &&
        Validators.isValidCardHolderName(cardHolderName) &&
        Validators.isValidCardCvvNumber(cardCvvNumber) &&
        Validators.isValidCardExpiryDate(cardExpiryDate)) {
      return true;
    }
    return false;
  }

  void refreshCardType() {
    if (cardNumber.length >= 4) {
      cardType = Helpers.getCardTypeFromNumber(cardNumber);
    }
  }

  Widget? getCardIcon() {
    return Helpers.getCardIcon(cardType);
  }

  void setColor(Color color) {
    cardColor = color;
    notifyListeners();
  }

  void setCountry(code) {
    countryCode = code;
    notifyListeners();
  }

  void setCardNumber(String text) {
    cardNumber = Helpers.getPrettyCardNumber(text);
    notifyListeners();
  }

  void setCardHolderName(String text) {
    cardHolderName = text;
    notifyListeners();
  }

  void setCardExpiryDate(String date) {
    cardExpiryDate = date;
    notifyListeners();
  }

  void setCardCvvNumber(String text) {
    cardCvvNumber = text;
    notifyListeners();
  }

  void setCardNumberErrorMessage(String message) {
    cardNumberErrorMessage = message;
    notifyListeners();
  }

  void setCardHolderErrorMessage(String message) {
    cardHolderErrorMessage = message;
    notifyListeners();
  }

  void setCardExpiryDateErrorMessage(String message) {
    cardExpiryDateErrorMessage = message;
    notifyListeners();
  }

  void setCardCvvNumberErrorMessage(String message) {
    cardCvvNumberErrorMessage = message;
    notifyListeners();
  }

  void addCardToWallet() {
    walletProvider.add(getCard());
  }
}
