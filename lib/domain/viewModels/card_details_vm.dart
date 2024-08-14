import 'package:credit_card_capture/domain/entities/credit_card_entity.dart';

class CardDetailsViewModel {
  final String title;
  final CreditCardEntity cardDetails;

  CardDetailsViewModel({
    required this.title,
    required this.cardDetails,
  });
}
