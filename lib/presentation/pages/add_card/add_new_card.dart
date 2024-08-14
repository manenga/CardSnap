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
  late TextEditingController _cardNumberController;
  late TextEditingController _cardHolderController;
  late TextEditingController _cvvController;
  late TextEditingController _expiryDateController;
  late TextEditingController _countryController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
    _cardNumberController = TextEditingController(text: _viewModel.cardNumber);
    _cardHolderController =
        TextEditingController(text: _viewModel.cardHolderName);
    _cvvController = TextEditingController(text: _viewModel.cardCvvNumber);
    _expiryDateController =
        TextEditingController(text: _viewModel.cardExpiryDate);
    _countryController = TextEditingController(
        text: Country.tryParse(_viewModel.countryCode)?.name ?? '');
  }

  Future<void> scanCardWithCamera() async {
    var cardDetails = await CardScanner.scanCard(
      scanOptions: const CardScanOptions(
        scanCardHolderName: true,
        scanExpiryDate: true,
      ),
    );

    if (cardDetails != null) {
      _viewModel.setCardNumber(cardDetails.cardNumber);
      _viewModel.setCardHolderName(cardDetails.cardHolderName);
      _viewModel.setCardExpiryDate(cardDetails.expiryDate);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _cvvController.dispose();
    _expiryDateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    required Function(String) onChanged,
    required String? errorText,
    String? helperText,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        autofocus: !readOnly,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        controller: controller,
        readOnly: readOnly,
        decoration: SharedStyles.formFieldStyle(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText ?? "",
          errorText: errorText ?? "",
          icon: Icons.credit_card,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _buildCountryPicker() {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          countryListTheme: CountryListThemeData(
            flagSize: 25,
            backgroundColor: Colors.white,
            textStyle: Theme.of(context).textTheme.bodyMedium,
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
                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                ),
              ),
            ),
          ),
          onSelect: (Country country) {
            _viewModel.setCountry(country.countryCode);
          },
        );
      },
      child: _buildTextField(
        labelText: "Country",
        hintText: "Country",
        controller: _countryController,
        onChanged: (text) {},
        errorText: null,
        readOnly: true,
        suffixIcon: const Icon(Icons.arrow_drop_down_sharp),
      ),
    );
  }

  void _handleSaveCard(BuildContext context, AddNewCardViewModel dataProvider) {
    if (_viewModel.doesCardAlreadyExist()) {
      _showSnackBar(context, 'Error! This card already exists..', Colors.red);
    } else if (_viewModel.isRestrictedCountry()) {
      _showSnackBar(
          context,
          'Error! Cannot add card, country is on the restricted list',
          Colors.red);
    } else if (dataProvider.isCardValid()) {
      _viewModel.addCardToWallet();
      Navigator.pop(context);
    } else {
      _showSnackBar(context, 'Hold on! Fix the errors to save your card');
    }
  }

  void _showSnackBar(BuildContext context, String message,
      [Color backgroundColor = Colors.black]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(message),
      ),
    );
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
                Form(
                  child: Consumer<AddNewCardViewModel>(
                    builder: (context, dataProvider, child) {
                      return Column(
                        children: [
                          _buildTextField(
                            labelText: "Card Number",
                            hintText: "Card Number",
                            controller: _cardNumberController,
                            onChanged: (text) {
                              _viewModel.refreshCardType();
                              _viewModel.setCardNumber(text);
                            },
                            errorText: dataProvider.cardNumberErrorMessage,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                              CardNumberInputFormatter(),
                            ],
                            suffixIcon: _viewModel.getCardIcon(),
                          ),
                          _buildTextField(
                            labelText: "Card Holder",
                            hintText: "Card Holder",
                            controller: _cardHolderController,
                            onChanged: (text) {
                              _viewModel.setCardHolderName(text);
                            },
                            errorText: _viewModel.cardHolderErrorMessage,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.characters,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 140,
                                child: _buildTextField(
                                  labelText: "CVV",
                                  hintText: "CVV",
                                  controller: _cvvController,
                                  onChanged: (text) {
                                    _viewModel.setCardCvvNumber(text);
                                  },
                                  errorText:
                                      _viewModel.cardCvvNumberErrorMessage,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                ),
                              ),
                              const Spacer(flex: 2),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: 160, maxWidth: 200),
                                child: _buildTextField(
                                  labelText: "Expiry Date",
                                  hintText: "Expiry Date",
                                  controller: _expiryDateController,
                                  onChanged: (text) {
                                    _viewModel.setCardExpiryDate(text);
                                  },
                                  errorText:
                                      _viewModel.cardExpiryDateErrorMessage,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                    ExpiryDateInputFormatter(),
                                  ],
                                  helperText: "MM/YY",
                                ),
                              ),
                            ],
                          ),
                          _buildCountryPicker(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 16),
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
                          _buildActionButton(
                            label: "Scan",
                            icon: Icons.document_scanner_outlined,
                            onPressed: scanCardWithCamera,
                          ),
                          _buildActionButton(
                            label: "Save card",
                            onPressed: () =>
                                _handleSaveCard(context, dataProvider),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      {required String label,
      IconData? icon,
      required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          key: Key('${label.toLowerCase().replaceAll(' ', '_')}_button'),
          icon: icon != null ? Icon(icon) : null,
          label: Text(label),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
