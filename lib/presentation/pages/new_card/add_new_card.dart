import 'package:country_picker/country_picker.dart';
import 'package:credit_card_capture/domain/viewModels/add_card_vm.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/input_formatters.dart';
import '../../../utils/shared_styles.dart';
import '../../components/color_picker.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key, required this.viewModel});

  final AddNewCardViewModel viewModel;

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  late AddNewCardViewModel _viewModel;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _viewModel = widget.viewModel;
    super.initState();
  }

  Future<void> scanCardWithCamera() async {
    var cardDetails = await CardScanner.scanCard(
      scanOptions: const CardScanOptions(
        scanCardHolderName: true,
        scanExpiryDate: true,
      ),
    );
    var cardNumber = cardDetails?.cardNumber;
    var cardHolderName = cardDetails?.cardHolderName;
    var cardExpiryDate = cardDetails?.expiryDate;

    print('Scanned card: cardNumber: $cardNumber, cardHolderName: $cardHolderName, cardExpiryDate: $cardExpiryDate');
    if (cardNumber != null) {
      _viewModel.setCardNumber(cardNumber);
      _viewModel.setCardNumberErrorMessage("");
    }

    if (cardHolderName != null) {
      _viewModel.setCardHolderName(cardHolderName);
      _viewModel.setCardHolderErrorMessage("");
    }

    if (cardExpiryDate != null) {
      _viewModel.setCardExpiryDate(cardExpiryDate);
      _viewModel.setCardExpiryDateErrorMessage("");
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _viewModel,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(_viewModel.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(child: Consumer<AddNewCardViewModel>(
                      builder: (context, dataProvider, child) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (text) {
                                  _viewModel.refreshCardType();
                                  _viewModel.setCardNumber(text);
                                  _viewModel.setCardNumberErrorMessage("");
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(16),
                                  CardNumberInputFormatter()
                                ],
                                controller: TextEditingController(
                                    text: dataProvider.cardNumber
                                ),
                                decoration: SharedStyles.formFieldStyle(
                                    labelText: "Card Number",
                                    hintText: "Card Number",
                                    errorText: dataProvider.cardNumberErrorMessage,
                                    icon: Icons.credit_card,
                                    suffixIcon: _viewModel.getCardIcon()),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.characters,
                                onChanged: (text) {
                                  _viewModel.setCardHolderName(text);
                                  _viewModel.setCardHolderErrorMessage("");
                                },
                                controller: TextEditingController(
                                    text: dataProvider.cardHolderName
                                ),
                                decoration: SharedStyles.formFieldStyle(
                                    labelText: "Card Holder",
                                    hintText: "Card Holder",
                                    icon: Icons.person_outline,
                                    errorText: _viewModel.cardHolderErrorMessage),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        onChanged: (text) {
                                          _viewModel.setCardCvvNumber(text);
                                          _viewModel
                                              .setCardCvvNumberErrorMessage("");
                                        },
                                        controller: TextEditingController(
                                            text: dataProvider.cardExpiryDate
                                        ),
                                        decoration: SharedStyles.formFieldStyle(
                                            labelText: "CVV",
                                            hintText: "CVV",
                                            icon: Icons.lock_outline,
                                            errorText: _viewModel
                                                .cardCvvNumberErrorMessage),
                                      ),
                                    ),
                                    const Spacer(flex: 2),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          minWidth: 160, maxWidth: 200),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                          ExpiryDateInputFormatter()
                                        ],
                                        onChanged: (text) {
                                          _viewModel.setCardExpiryDate(text);
                                          _viewModel
                                              .setCardExpiryDateErrorMessage("");
                                        },
                                        controller: TextEditingController(
                                            text: dataProvider.cardCvvNumber
                                        ),
                                        decoration: SharedStyles.formFieldStyle(
                                            labelText: "Expiry Date",
                                            hintText: "Expiry Date",
                                            helperText: "MM/YY",
                                            icon: Icons.calendar_month_outlined,
                                            errorText: _viewModel
                                                .cardExpiryDateErrorMessage),
                                      ),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
                                  showCursor: false,
                                  readOnly: true,
                                  keyboardType: TextInputType.none,
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      countryListTheme: CountryListThemeData(
                                        flagSize: 25,
                                        backgroundColor: Colors.white,
                                        textStyle:
                                        Theme.of(context).textTheme.bodyMedium,
                                        bottomSheetHeight: 500,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        inputDecoration: InputDecoration(
                                          labelText: 'Search',
                                          hintText: 'Start typing to search',
                                          prefixIcon: const Icon(Icons.search),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: const Color(0xFF8C98A8)
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onSelect: (Country country) {
                                        _viewModel.setCountry(country.countryCode);
                                      },
                                    );
                                  },
                                  controller: TextEditingController(
                                      text:
                                      Country.tryParse(dataProvider.countryCode)
                                          ?.name),
                                  decoration: SharedStyles.formFieldStyle(
                                    labelText: "Country",
                                    hintText: "Country",
                                    icon: Icons.outlined_flag,
                                    suffixIcon:
                                    const Icon(Icons.arrow_drop_down_sharp),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                              child: SizedBox(
                                height: 30,
                                width: double.infinity,
                                child: ColorPicker(
                                  selectedColor: dataProvider.cardColor,
                                  onSelectedColorChanged: (color) {
                                    _viewModel.setColor(color);
                                  },
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      key: const Key('capture_card_button'),
                                      icon: const Icon(
                                          Icons.document_scanner_outlined),
                                      label: const Text("Scan"),
                                      onPressed: () {
                                        scanCardWithCamera();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  key: const Key('save_card_button'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                    Colors.deepPurpleAccent.shade100,
                                    shadowColor: Colors.deepPurpleAccent.shade200,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32.0)),
                                    minimumSize: const Size(100, 40),
                                  ),
                                  child: const Text("Save card"),
                                  onPressed: () {
                                    if (_viewModel.doesCardAlreadyExist()) {
                                      const snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            'Error! This card already exists..'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else if (_viewModel.isRestrictedCountry()) {
                                      const snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            'Error! Cannot add card, country is on the restricted list'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else if (dataProvider.isCardValid()) {
                                      _viewModel.addCardToWallet();
                                      Navigator.pop(context);
                                    } else {
                                      const snackBar = SnackBar(
                                        content: Text(
                                            'Hold on! Fix the errors to save your card'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      })),
                ],
              ),
            ),
          ),
        ));
  }
}
