import '../../domain/entities/credit_card_entity.dart';

abstract class WalletProviding {
  /// Initializes the provider and fetches the cards.
  Future<void> initializeProvider();

  /// Adds a credit card to the wallet.
  void add(CreditCardEntity card);

  /// Removes a credit card from the wallet by its card number.
  void removeByCardNumber(String number);

  /// Checks if the wallet is empty.
  bool isEmpty();

  /// Retrieves all credit cards in the wallet.
  List<CreditCardEntity> getAll();

  /// Gets the midpoint index of the cards list.
  int getMidPoint();

  /// Retrieves a credit card at a specific index.
  CreditCardEntity? getCardAt(int index);

  /// Checks if a specific card already exists in the wallet.
  bool doesCardExist(CreditCardEntity card);

  /// Retrieves the title for the wallet.
  String getTitle();
}
