import 'package:credit_card_capture/presentation/pages/home/home_page.dart';
import 'package:credit_card_capture/utils/shared_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/viewModels/home_page_vm.dart';
import 'presentation/providers/wallet_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = WalletProvider();
    provider.initializeProvider();
    return ChangeNotifierProvider(
        create: (context) => provider,
        child: MaterialApp(
          title: 'Credit Card Capture App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: SharedStyles.textTheme,
          ),
          home: HomePage(
              viewModel: HomePageViewModel(
                  title: 'My Cards'
              )
          ),
        ));
  }
}
