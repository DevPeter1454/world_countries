import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Country {
  String name;
  var capital;
  int population;
  var officialLanguage;
  String flags;
  var coatOfArms;
  var timezones;
  var currencies;
  var area;
  String region;
  String subregion;
  String continent;
  String drivingSide;
  Country({
    required this.name,
    required this.capital,
    required this.population,
    required this.officialLanguage,
    required this.flags,
    required this.coatOfArms,
    required this.timezones,
    required this.currencies,
    required this.area,
    required this.region,
    required this.subregion,
    required this.continent,
    required this.drivingSide,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'capital': capital,
      'population': population,
      'officialLanguage': officialLanguage,
      'flags': flags,
      'coatOfArms': coatOfArms,
      // 'timezones': timezones,
      // 'currencies': currencies,
      // 'area': area,
      // 'continent': continent,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name']['common'],
      capital: map['capital'],
      population: map['population'],
      officialLanguage: map['languages'],
      flags: map['flags']['png'] ?? '',
      coatOfArms: map['coatOfArms']['png'] ?? '',
      timezones: map['timezones'],
      currencies: map['currencies'] ,
      area: map['area'],
      continent: map['continents'][0],
      region: map['region'],
      subregion: map['subregion'] ?? '',
      drivingSide: map['car']['side'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source) as Map<String, dynamic>);
}
