import 'package:credit_card_capture/domain/entities/credit_card_entity.dart';
import 'package:credit_card_capture/domain/viewModels/add_card_vm.dart';
import 'package:credit_card_capture/presentation/pages/add_card/add_new_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../mocks/mock_wallet_provider.dart';

void main() {
  group('AddNewCardPage', () {
    late AddNewCardViewModel viewModel;
    late MockWalletProvider provider;

    setUp(() {
      provider = MockWalletProvider([
        CreditCardEntity(
            cardNumber: '1234567812345678',
            holderName: 'John Doe',
            expiryDate: '12/25',
            cvvNumber: '123',
            cardColor: Colors.black,
            countryCode: 'ZA')
      ]);
      viewModel = AddNewCardViewModel(
        title: 'Add New Card',
        walletProvider: provider,
      );
    });

    testWidgets('renders all input fields and buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<AddNewCardViewModel>.value(
          value: viewModel,
          child: MaterialApp(
            home: AddNewCardPage(viewModel: viewModel),
          ),
        ),
      );

      expect(
          find.byType(TextFormField),
          findsNWidgets(
              5)); // Card Number, Card Holder, CVV, Expiry Date, Country
      expect(find.text('Scan'), findsOneWidget);
      expect(find.text('Save card'), findsOneWidget);
    });
  });
}
