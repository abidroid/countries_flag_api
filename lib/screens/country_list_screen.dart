

import 'package:countries_flag_api/models/country.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {


  Future<List<Country>> getAllCountries() async {

    List<Country> countries = [];

    String url = 'https://countriesnow.space/api/v0.1/countries/flag/images';


    // Request karengay server wth of http package

    http.Response response = await http.get(Uri.parse(url));

    print(response.body);

    return countries;

  }

  @override
  void initState() {
    getAllCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries List'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}

