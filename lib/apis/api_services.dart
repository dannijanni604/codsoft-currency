import 'package:codsoft_currency/apis/apis.dart';
import 'package:codsoft_currency/models/currencies.dart';
import 'package:codsoft_currency/models/rates.dart';
import 'package:http/http.dart' as http;

Future<Rates> fetchRates() async {
  var response = await http.get(Uri.parse(AppUrl.ratesUrl));
  final ratesModel = ratesModelFromJson(response.body);
  return ratesModel;
}

Future<Map> fetchCurrencies() async {
  var response = await http.get(Uri.parse(AppUrl.currenciesUrl));
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}
