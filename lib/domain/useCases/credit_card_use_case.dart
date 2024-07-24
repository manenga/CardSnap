import 'package:credit_card_capture/domain/entities/credit_card_entity.dart';
import 'package:credit_card_capture/domain/repositories/credit_card_repository.dart';

class GetCardsUseCase {
  final CreditCardRepository repository;
  GetCardsUseCase({required this.repository});

  Future<List<CreditCardEntity>> execute() async {
    return repository.getCards();
  }
}
