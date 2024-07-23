import 'package:credit_card_capture/domain/entities/credit_card_entity.dart';
import 'package:credit_card_capture/domain/repositories/credit_card_repository.dart';
import 'package:credit_card_capture/utils/constants.dart';

class CreditCardRepositoryImpl implements CreditCardRepository {
  @override
  Future<List<CreditCardEntity>> getCards() async {
    await Future.delayed(
        const Duration(milliseconds: 400)); // Simulating network delay
    return initialCards;
  }
}
