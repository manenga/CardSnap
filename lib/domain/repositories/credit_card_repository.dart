import 'package:credit_card_capture/domain/entities/credit_card_entity.dart';

abstract class CreditCardRepository {
  Future<List<CreditCardEntity>> getCards();
}
