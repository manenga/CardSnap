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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletProvider()),
      ],
      child: MaterialApp(
        title: 'Credit Card Capture App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: SharedStyles.textTheme,
        ),
        home: const HomePageWrapper(),
      ),
    );
  }
}

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (context, provider, child) {
        return HomePage(
            viewModel: HomePageViewModel(title: provider.getTitle()));
      },
    );
  }
}