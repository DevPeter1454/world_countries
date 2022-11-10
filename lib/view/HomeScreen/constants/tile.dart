import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:translator/translator.dart';

class Tile extends StatelessWidget {
  final String flagUrl;
  final String countryName;
  final String countryCapital;
  const Tile(
      {super.key,
      required this.flagUrl,
      required this.countryName,
      required this.countryCapital});

  @override

  

  Widget build(BuildContext context) {

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
                image: NetworkImage(flagUrl), fit: BoxFit.cover)),
      ),
      title: Text(countryName),
      subtitle: Text(
          countryCapital.substring(1, countryCapital.toString().length - 1)),
    );
  }
}
