import 'package:codsoft_currency/apis/api_services.dart';
import 'package:codsoft_currency/components/conversion_card.dart';
import 'package:flutter/material.dart';
import '../models/rates.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<Rates> rates;
  late Future<Map> currencies;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    rates = fetchRates();
    currencies = fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Currency Convertor'),
      ),
      body: FutureBuilder<Rates>(
          future: rates,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return FutureBuilder<Map>(
                  future: currencies,
                  builder: (context, index) {
                    if (index.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (index.hasError) {
                      return Center(child: Text('Error: ${index.error}'));
                    } else {
                      return ConversionCard(
                        rates: snapshot.data!.rates,
                        currencies: index.data!,
                      );
                    }
                  });
            }
          }),
    );
  }
}
