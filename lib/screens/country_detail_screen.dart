

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/country.dart';

class CountryDetailScreen extends StatelessWidget {

  final Country country;
  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {

    TextStyle txtStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Column(
        spacing: 16,
        children: [
          SizedBox(
              width: double.infinity,
              height: 250,
              child: SvgPicture.network(country.flag!, fit: BoxFit.cover,),
          ),

          Text(country.name!, style: txtStyle,),
          Text(country.iso2!, style:  txtStyle,),
          Text(country.iso3!, style:  txtStyle,),

        ],
      ),
    );
  }
}
