import 'package:credit_card_capture/domain/viewModels/add_card_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../components/empty_wallet.dart';
import '../../components/front_card.dart';
import '../../providers/wallet_provider.dart';
import '../card_detail/card_detail_page.dart';
import '../new_card/add_new_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  WalletProvider _walletProvider = WalletProvider();
  final ScrollController _listWheelController = ScrollController();
  final double _cardHeight = 260;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 1), () {
      try {
        _animateToCenter();
      } on Exception catch (_, e) {
        debugPrint('Caught exception $e');
      }
    });
  }

  void _goToAddNewCardPage() {
    var viewModel = AddNewCardViewModel(
      title: "Add A New Card",
      walletProvider: _walletProvider,
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
                  title: "Card details",
                  cardDetails: cardDetails,
                  wallet: _walletProvider,
                )),
      );
    }
  }

  void _animateToCenter() {
    int index = _walletProvider.getMidPoint();
    if (index != -1 && _walletProvider.getCardAt(index) != null) {
      _listWheelController.animateTo(
        index * _cardHeight,
        duration: const Duration(seconds: 3),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _walletProvider = Provider.of<WalletProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<WalletProvider>(
            builder: (context, dataProvider, child) {
              if (dataProvider.isEmpty()) {
                return const EmptyWalletWidget();
              }
              return Expanded(
                child: ListWheelScrollView(
                    itemExtent: _cardHeight,
                    diameterRatio: 3.5,
                    controller: _listWheelController,
                    children: [
                      for (int itemIndex = 0;
                          itemIndex < _walletProvider.getAll().length;
                          itemIndex++) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FrontCard(
                              cardNumber: _walletProvider
                                      .getCardAt(itemIndex)
                                      ?.getPrettyCardNumber() ??
                                  "",
                              cardHolder: _walletProvider
                                      .getCardAt(itemIndex)
                                      ?.getCardHolder() ??
                                  "",
                              expiryDate: _walletProvider
                                      .getCardAt(itemIndex)
                                      ?.getCardExpiryDate() ??
                                  "",
                              cardIcon: _walletProvider
                                  .getCardAt(itemIndex)
                                  ?.getCardIcon(),
                              countryCode: _walletProvider
                                      .getCardAt(itemIndex)
                                      ?.getCountryCode() ??
                                  "ZA",
                              cardColor: _walletProvider
                                      .getCardAt(itemIndex)
                                      ?.getCardColor() ??
                                  Colors.amber,
                              onPressed: () {
                                _goToCardDetailPage(
                                    _walletProvider.getCardAt(itemIndex));
                              }),
                        ),
                      ]
                    ]),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('add_new_card_fab'),
        onPressed: _goToAddNewCardPage,
        tooltip: 'Add a new card',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
