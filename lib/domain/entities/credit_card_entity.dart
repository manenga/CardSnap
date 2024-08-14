import 'package:flutter/material.dart';

import '../../utils/card_types.dart';
import '../../utils/helpers.dart';

class CreditCardEntity {
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

  Widget getCardIcon() {
    // Ensure that the icon is not null; provide a default icon if necessary
    return Helpers.getCardIcon(getCardType()) ?? const Icon(Icons.credit_card);
  }

  String getCountryCode() {
    return countryCode;
  }
}
