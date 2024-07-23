import 'package:credit_card_capture/utils/constants.dart';

import '../../domain/repositories/restricted_countries_repository.dart';

class RestrictedCountriesRepositoryImpl
    implements RestrictedCountriesRepository {
  @override
  Future<List<String>> getRestrictedCountries() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating network delay
    return restrictedCountries;
  }
}
