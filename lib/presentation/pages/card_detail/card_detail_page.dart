import 'package:credit_card_capture/domain/viewModels/card_details_vm.dart';
import 'package:credit_card_capture/utils/helpers.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/credit_card_entity.dart';
import '../../../utils/card_types.dart';
import '../../../utils/constants.dart';
import '../../components/flippable_card.dart';
import '../../providers/wallet_provider.dart';

class CardDetailPage extends StatefulWidget {
  const CardDetailPage({super.key,
      required this.viewModel
  });

  final CardDetailsViewModel viewModel;

  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  TextEditingController cardNumberController = TextEditingController();
  CardType cardType = CardType.invalid;
  late CreditCardEntity _cardDetails;
  late WalletProvider _wallet;

  @override
  void initState() {
    _wallet = widget.viewModel.walletProvider;
    _cardDetails = widget.viewModel.cardDetails;

    cardNumberController.addListener(
      () {
        getCardType();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    super.dispose();
  }

  void getCardType() {
    if (cardNumberController.text.length >= 6) {
      CardType type = Helpers.getCardTypeFromNumber(cardNumberController.text);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  void _deleteCard(CreditCardEntity card) {
    _wallet.removeByCardNumber(card.cardNumber);
    const snackBar = SnackBar(
      content: Text('You have deleted your card'),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar);
    Navigator.pop(context);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.viewModel.title),
          actions: const []),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(
          heightFactor: 1.5,
          child: Column(
            children: [
              SizedBox.fromSize(
                size: const Size(double.infinity, 260),
                child: FlippableCard(
                  cardDetails: _cardDetails,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black),
                              height: 5,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                            ),
                          ),
                          Text("ACTIONS",
                              style: Theme.of(context).textTheme.displayMedium),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black
                              ),
                              height: 5,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red.shade500,
                            shadowColor: Colors.red.shade500,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0
                                )
                            ),
                            minimumSize: const Size(100, 40),
                          ),
                          child: const Text("Delete card"),
                          onPressed: () {
                            _deleteCard(_cardDetails);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
