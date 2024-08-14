import 'package:credit_card_capture/domain/viewModels/card_details_vm.dart';
import 'package:credit_card_capture/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../../utils/card_types.dart';
import '../../../utils/constants.dart';
import '../../components/flippable_card.dart';
import '../../providers/wallet_provider.dart';

class CardDetailPage extends StatefulWidget {
  const CardDetailPage({super.key, required this.viewModel});

  final CardDetailsViewModel viewModel;

  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  final TextEditingController cardNumberController = TextEditingController();
  CardType cardType = CardType.invalid;
  late CreditCardEntity _cardDetails;

  @override
  void initState() {
    super.initState();
    _cardDetails = widget.viewModel.cardDetails;
    cardNumberController.addListener(_updateCardType);
  }

  @override
  void dispose() {
    cardNumberController.removeListener(_updateCardType);
    cardNumberController.dispose();
    super.dispose();
  }

  void _updateCardType() {
    final String cardNumber = cardNumberController.text;
    final CardType type = cardNumber.length >= 6
        ? Helpers.getCardTypeFromNumber(cardNumber)
        : CardType.invalid;

    if (type != cardType) {
      setState(() {
        cardType = type;
      });
    }
  }

  void _deleteCard(WalletProvider walletProvider) {
    walletProvider.removeByCardNumber(_cardDetails.cardNumber);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have deleted your card')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.viewModel.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(
          heightFactor: 1.5,
          child: Column(
            children: [
              SizedBox.fromSize(
                size: const Size(double.infinity, 260),
                child: FlippableCard(cardDetails: _cardDetails),
              ),
              const SizedBox(height: 24.0),
              _buildActionSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionSection(BuildContext context) {
    final provider = Provider.of<WalletProvider>(context);
    return Column(
      children: [
        _buildActionHeader(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red.shade500,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                minimumSize: const Size(100, 40),
              ),
              onPressed: () => _deleteCard(provider),
              child: const Text("Delete card"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDivider(),
          Text("ACTIONS", style: Theme.of(context).textTheme.displayMedium),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
        ),
        height: 5,
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      ),
    );
  }
}
