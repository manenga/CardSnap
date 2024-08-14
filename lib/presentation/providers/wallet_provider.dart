import 'package:credit_card_capture/data/repositories/credit_card_repository.dart';
import 'package:credit_card_capture/domain/useCases/credit_card_use_case.dart';
import 'package:credit_card_capture/presentation/providers/wallet_providing.dart';
import 'package:credit_card_capture/utils/helpers.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/credit_card_entity.dart';

final class WalletProvider extends ChangeNotifier implements WalletProviding {
  late List<CreditCardEntity> _cards = [];
  final GetCardsUseCase useCase =
      GetCardsUseCase(repository: CreditCardRepositoryImpl());

  @override
  Future<void> initializeProvider() async {
    _cards = await useCase.execute();
    notifyListeners();
  }

  @override
  void add(CreditCardEntity card) {
    _cards.add(card);
    notifyListeners();
  }

  @override
  void removeByCardNumber(String number) {
    int index = _cards.indexWhere((element) => element.cardNumber == number);
    if (index != -1) {
      _cards.removeAt(index);
      notifyListeners();
    }
  }

  @override
  bool isEmpty() {
    return _cards.isEmpty;
  }

  @override
  List<CreditCardEntity> getAll() {
    return _cards;
  }

  @override
  int getMidPoint() {
    return isEmpty() ? -1 : _cards.length ~/ 2;
  }

  @override
  CreditCardEntity? getCardAt(int index) {
    return index < _cards.length ? _cards[index] : null;
  }

  @override
  bool doesCardExist(CreditCardEntity card) {
    return _cards.any((element) =>
        element.cardNumber == Helpers.getCleanedNumber(card.cardNumber));
  }

  @override
  String getTitle() {
    return "My Cards";
  }
}