import 'package:credit_card_capture/domain/entities/credit_card_entity.dart';
import 'package:credit_card_capture/presentation/providers/wallet_provider.dart';

class CardDetailsViewModel {
  final String title;
  final CreditCardEntity cardDetails;
  final WalletProvider walletProvider;

  CardDetailsViewModel({
    required this.title,
    required this.cardDetails,
    required this.walletProvider,
  });
}
