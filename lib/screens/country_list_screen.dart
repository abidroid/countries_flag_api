

import 'dart:convert';

import 'package:countries_flag_api/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

    if( response.statusCode == 200){

      var jsonResponse = jsonDecode(response.body);
      var countriesJsonArray = jsonResponse['data'];

      for( var jsonCountry in countriesJsonArray){

        Country country = Country.fromJson(jsonCountry);
        countries.add(country);
      }

      await Future.delayed(Duration(seconds: 3));
      return countries;

    }else{

    }

    return countries;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries List'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder<List<Country>>(
          future: getAllCountries(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            if( snapshot.hasData){
              List<Country> countries = snapshot.data;

              return Center(child: Text(countries.length.toString()));


            }else{

              return Center(child: SpinKitDualRing(color: Colors.red),);
            }

          }),
    );
  }
}

