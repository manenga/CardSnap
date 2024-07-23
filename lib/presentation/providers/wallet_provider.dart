import 'package:credit_card_capture/data/repositories/credit_card_repository.dart';
import 'package:credit_card_capture/domain/useCases/credit_card_use_case.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/credit_card_entity.dart';

final class WalletProvider extends ChangeNotifier {
  late List<CreditCardEntity> _cards = [];
  final GetCardsUseCase useCase =
      GetCardsUseCase(repository: CreditCardRepositoryImpl());

  void initializeProvider() async {
    _cards = await useCase.execute();
  }

  void add(CreditCardEntity card) {
    _cards.add(card);
    notifyListeners();
  }

  void removeByCardNumber(String number) {
    int index = _cards.indexWhere((element) => element.cardNumber == number);
    if (index != -1) {
      _cards.removeAt(index);
      notifyListeners();
    }
  }

  bool isEmpty() {
    return _cards.isEmpty;
  }

  List<CreditCardEntity> getAll() {
    return _cards;
  }

  int getMidPoint() {
    if (isEmpty()) {
      return -1;
    }
    return _cards.length ~/ 2;
  }

  CreditCardEntity? getCardAt(int index) {
    if (index < _cards.length) {
      return _cards[index];
    }
    return null;
  }

  bool doesCardExist(CreditCardEntity card) {
    return _cards
        .where((element) => element.cardNumber == card.cardNumber)
        .isNotEmpty;
  }
}
