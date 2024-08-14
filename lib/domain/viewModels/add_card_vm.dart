import 'package:credit_card_capture/presentation/providers/wallet_provider.dart';
import 'package:credit_card_capture/presentation/providers/wallet_providing.dart';
import 'package:credit_card_capture/utils/card_types.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/restricted_countries_repository.dart';
import '../../utils/card_error_types.dart';
import '../../utils/helpers.dart';
import '../../utils/input_validators.dart';
import '../entities/credit_card_entity.dart';
import '../repositories/restricted_countries_repository.dart';
import '../useCases/restricted_countries_use_case.dart';

class AddNewCardViewModel extends ChangeNotifier {
  final String title;
  final WalletProviding walletProvider;
  List<String> restrictedCountries = [];
  final RestrictedCountriesRepository repo;

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
    WalletProviding? walletProvider,
    RestrictedCountriesRepository? repository,
  })  : repo = repository ?? RestrictedCountriesRepositoryImpl(),
        walletProvider = walletProvider ?? WalletProvider();

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

  Future<void> fetchRestrictedCountries() async {
    restrictedCountries = await GetRestrictedCountriesUseCase(
      repository: repo,
    ).execute();
  }

  bool isRestrictedCountry() => restrictedCountries.contains(countryCode);

  bool doesCardAlreadyExist() => walletProvider.doesCardExist(getCard());

  bool isCardValid() {
    bool isValid = true;

    // Validate card fields and set error messages
    isValid &= _validateField(Validators.isValidCardNumber(cardNumber),
        (msg) => cardNumberErrorMessage = msg, "Card number is not valid");
    isValid &= _validateField(Validators.isValidCardHolderName(cardHolderName),
        (msg) => cardHolderErrorMessage = msg, "Card holder name is not valid");
    isValid &= _validateField(Validators.isValidCardCvvNumber(cardCvvNumber),
        (msg) => cardCvvNumberErrorMessage = msg, "CVV is not valid");
    isValid &= _validateField(Validators.isValidCardExpiryDate(cardExpiryDate),
        (msg) => cardExpiryDateErrorMessage = msg, "Expiry date is not valid");

    notifyListeners();
    return isValid;
  }

  bool _validateField(
      bool isValid, Function(String) setErrorMessage, String errorMessage) {
    if (!isValid) {
      setErrorMessage(errorMessage);
    }
    return isValid;
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

  void setCountry(String code) {
    countryCode = code;
    notifyListeners();
  }

  void setCardNumber(String text) {
    cardNumber = Helpers.getPrettyCardNumber(text);
    setCardErrorMessage(CardErrorType.number, "");
    notifyListeners();
  }

  void setCardHolderName(String text) {
    cardHolderName = text;
    setCardErrorMessage(CardErrorType.holder, "");
    notifyListeners();
  }

  void setCardExpiryDate(String date) {
    cardExpiryDate = date;
    setCardErrorMessage(CardErrorType.expiry, "");
    notifyListeners();
  }

  void setCardCvvNumber(String text) {
    cardCvvNumber = text;
    setCardErrorMessage(CardErrorType.cvv, "");
    notifyListeners();
  }

  void setCardErrorMessage(CardErrorType type, String message) {
    switch (type) {
      case CardErrorType.number:
        cardNumberErrorMessage = message;
        break;
      case CardErrorType.holder:
        cardHolderErrorMessage = message;
        break;
      case CardErrorType.expiry:
        cardExpiryDateErrorMessage = message;
        break;
      case CardErrorType.cvv:
        cardCvvNumberErrorMessage = message;
        break;
    }
    notifyListeners();
  }

  void addCardToWallet() {
    walletProvider.add(getCard());
  }
}
