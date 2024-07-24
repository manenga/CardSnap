import 'package:flutter/material.dart';

import '../domain/entities/credit_card_entity.dart';

const double colorPickerHeight = 30.0;
const double defaultPadding = 16.0;
const List<Color> cardColors = [
  Colors.deepOrange,
  Colors.pink,
  Colors.deepPurple,
  Colors.brown,
  Colors.blue,
  Colors.indigo,
  Colors.amber,
  Colors.red,
];

final List<CreditCardEntity> initialCards = [
  CreditCardEntity(
    cardNumber: "5432784942128433",
    holderName: "Serena Williams",
    expiryDate: "06/29",
    cvvNumber: "626",
    cardColor: Colors.black87,
    countryCode: 'US',
  ),
  CreditCardEntity(
    cardNumber: "5132784942728431",
    holderName: "KENDRICK LAMAR",
    expiryDate: "10/30",
    cvvNumber: "292",
    cardColor: Colors.indigoAccent,
    countryCode: 'US',
  ),
  CreditCardEntity(
    cardNumber: "4232734642928430",
    holderName: "LEWIS HAMILTON",
    expiryDate: "04/27",
    cvvNumber: "224",
    cardColor: Colors.tealAccent,
    countryCode: 'GB',
  ),
  CreditCardEntity(
    cardNumber: "3732784942128403",
    holderName: "SIYA KOLISI",
    expiryDate: "01/25",
    cvvNumber: "224",
    cardColor: Colors.yellow,
    countryCode: 'ZA',
  ),
  CreditCardEntity(
    cardNumber: "412774893488992",
    holderName: "Priyanka Chopra",
    expiryDate: "02/26",
    cvvNumber: "323",
    cardColor: Colors.redAccent,
    countryCode: 'IN',
  ),
  CreditCardEntity(
    cardNumber: "372774893588192",
    holderName: "Lionel Messi",
    expiryDate: "08/28",
    cvvNumber: "312",
    cardColor: Colors.lightBlueAccent,
    countryCode: 'AR',
  ),
  CreditCardEntity(
    cardNumber: "552774893438612",
    holderName: "Michael Phelps",
    expiryDate: "11/26",
    cvvNumber: "312",
    cardColor: Colors.deepOrangeAccent,
    countryCode: 'US',
  ),
];

final List<String> restrictedCountries = [
  'AZ',
  'CA',
  'CM',
  'FI',
  'MW',
  'MY',
  'NZ',
  'UY',
];

class Strings {
  static String emptyWalletViewTitle = 'You have no cards';
  static String emptyWalletViewBody =
      'Add some to your wallet using the button in the bottom right of the screen.';
  static String cardDisclaimer =
      'You promise to pay us for all Purchases made by you and for all Cash Advances and Balance Transfers received by you except as limited in this Agreement regarding your liability for unauthorized use of a Card or Credit Device.';
}
