

import 'dart:convert';

import 'package:countries_flag_api/models/country.dart';
import 'package:countries_flag_api/screens/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

             return ListView.builder(
                 itemCount: countries.length,
                 itemBuilder: (BuildContext context, int index){

                   return InkWell(
                     onTap: (){

                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
                         return CountryDetailScreen(country: countries[index]);
                       }));
                     },
                     child: Card(
                       color: Colors.yellow,
                       child: Padding(
                         padding: const EdgeInsets.all(16.0),
                         child: Row(
                           spacing: 16,
                           children: [
                             // flag display
                             SizedBox(
                               width: 100,
                               height: 80,
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(8),
                                 child: SvgPicture.network(countries[index].flag!,
                                  fit: BoxFit.cover,
                                 ),
                               ),
                             ),
                             Expanded(
                               child: Text(countries[index].name!,
                                 style: TextStyle(fontSize: 18),),
                             ),
                           ],
                         ),
                       ),
                     ),
                   );
             });


            }else{

              return Center(child: SpinKitDualRing(color: Colors.red),);
            }

          }),
    );
  }
}

