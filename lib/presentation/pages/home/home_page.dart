import 'package:credit_card_capture/domain/viewModels/add_card_vm.dart';
import 'package:credit_card_capture/domain/viewModels/card_details_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../../domain/viewModels/home_page_vm.dart';
import '../../components/empty_wallet.dart';
import '../../components/front_card.dart';
import '../../providers/wallet_provider.dart';
import '../add_card/add_new_card.dart';
import '../card_detail/card_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.viewModel});

  final HomePageViewModel viewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  final ScrollController _listWheelController = ScrollController();
  static const double _cardHeight = 260;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<WalletProvider>(context);
    provider.initializeProvider();
  }

  void _goToAddNewCardPage() {
    final viewModel = AddNewCardViewModel(
      title: "Add A New Card",
    );
    viewModel.fetchRestrictedCountries();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNewCardPage(viewModel: viewModel)),
    );
  }

  void _goToCardDetailPage(CreditCardEntity? cardDetails) {
    if (cardDetails != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CardDetailPage(
            viewModel: CardDetailsViewModel(
              title: "Card details",
              cardDetails: cardDetails,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.viewModel.title),
      ),
      body: Consumer<WalletProvider>(
        builder: (context, dataProvider, child) {
          if (dataProvider.isEmpty()) {
            return const EmptyWalletWidget();
          }
          final cards = dataProvider.getAll();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListWheelScrollView(
                  itemExtent: _cardHeight,
                  diameterRatio: 3.5,
                  controller: _listWheelController,
                  children: cards.map((card) => _buildCard(card)).toList(),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('add_new_card_fab'),
        onPressed: () => _goToAddNewCardPage(),
        tooltip: 'Add a new card',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCard(CreditCardEntity card) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FrontCard(
        cardNumber: card.getPrettyCardNumber(),
        cardHolder: card.getCardHolder(),
        expiryDate: card.getCardExpiryDate(),
        cardIcon: card.getCardIcon(),
        countryCode: card.getCountryCode(),
        cardColor: card.getCardColor(),
        onPressed: () => _goToCardDetailPage(card),
      ),
    );
  }
}
