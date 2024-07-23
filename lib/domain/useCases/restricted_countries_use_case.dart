import 'package:credit_card_capture/domain/repositories/restricted_countries_repository.dart';

class GetRestrictedCountriesUseCase {
  final RestrictedCountriesRepository repository;

  GetRestrictedCountriesUseCase({required this.repository});

  Future<List<String>> execute() async {
    return repository.getRestrictedCountries();
  }
}
