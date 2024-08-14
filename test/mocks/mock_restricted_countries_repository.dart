import 'package:credit_card_capture/domain/repositories/restricted_countries_repository.dart';

class MockRestrictedCountriesRepository
    implements RestrictedCountriesRepository {
  final List<String> restrictedCountries;

  MockRestrictedCountriesRepository({required this.restrictedCountries});

  @override
  Future<List<String>> getRestrictedCountries() async {
    await Future.delayed(const Duration(seconds: 2));
    return restrictedCountries;
  }
}
