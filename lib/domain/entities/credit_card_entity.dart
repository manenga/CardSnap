import 'package:flutter/material.dart';

import '../../utils/card_types.dart';
import '../../utils/helpers.dart';

final class CreditCardEntity extends ChangeNotifier {
  final String cardNumber;
  final String holderName;
  final String expiryDate;
  final String cvvNumber;
  final Color cardColor;
  final String countryCode;

  CreditCardEntity({
    required this.cardNumber,
    required this.holderName,
    required this.expiryDate,
    required this.cvvNumber,
    required this.cardColor,
    required this.countryCode,
  });

  String getCardHolder() {
    return holderName.toUpperCase();
  }

  String getCardExpiryDate() {
    return expiryDate.toUpperCase();
  }

  Color getCardColor() {
    return cardColor;
  }

  CardType getCardType() {
    String cleanedNumber = Helpers.getCleanedNumber(cardNumber);
    return Helpers.getCardTypeFromNumber(cleanedNumber);
  }

  String getCleanedNumber() {
    return Helpers.getCleanedNumber(cardNumber);
  }

  String getPrettyCardNumber() {
    return Helpers.getPrettyCardNumber(cardNumber);
  }

  Widget? getCardIcon() {
    return Helpers.getCardIcon(getCardType());
  }

  String getCountryCode() {
    return countryCode;
  }
}
