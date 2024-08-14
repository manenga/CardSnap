import 'package:credit_card_capture/domain/entities/credit_card_entity.dart';
import 'package:credit_card_capture/presentation/providers/wallet_providing.dart';
import 'package:mockito/mockito.dart';

class MockWalletProvider extends Mock implements WalletProviding {
  List<CreditCardEntity> _cards = [];

  MockWalletProvider(List<CreditCardEntity> cards) {
    _cards = cards;
  }

  @override
  Future<void> initializeProvider() async {}

  @override
  void add(CreditCardEntity card) {
    _cards.add(card);
  }

  @override
  void removeByCardNumber(String number) {
    int index = _cards.indexWhere((element) => element.cardNumber == number);
    if (index != -1) {
      _cards.removeAt(index);
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
    return _cards.any((element) => element.cardNumber == card.cardNumber);
  }

  @override
  String getTitle() {
    return "My Cards";
  }
}
