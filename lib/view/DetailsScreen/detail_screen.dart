import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:world_countries/models/country/country_model.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = '/details';
  final Country country;
  const DetailsScreen({super.key, required this.country});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int currentIndex = 0;

  final test = NumberFormat("#,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    var newPopulation =
        test.format(int.parse(widget.country.population.toString()));
    List<Widget> items = [
      Image.network(
        widget.country.flags,
        height: 200,
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
      Image.network(
        widget.country.coatOfArms,
        height: 200,
        width: double.infinity,
      )
    ];
    var currency = widget.country.currencies as Map;
    var languages = widget.country.officialLanguage as Map;
    var timezones = widget.country.timezones as List;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                        Text(
                          widget.country.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          // textAlign: TextAlign.center,
                        ),
                        SizedBox.shrink()
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CarouselSlider(
                        items: widget.country.coatOfArms.toString().isNotEmpty
                            ? items
                            : [
                                Image.network(
                                  widget.country.flags,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                ),
                              ],
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          height: 200,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          autoPlay:
                              widget.country.coatOfArms.toString().isNotEmpty,
                        )),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedSmoothIndicator(
                          activeIndex: currentIndex,
                          effect: const WormEffect(
                              dotWidth: 10,
                              dotHeight: 10,
                              dotColor: Colors.grey,
                              activeDotColor: Colors.white),
                          count: widget.country.coatOfArms.toString().isNotEmpty
                              ? 2
                              : 1,
                          onDotClicked: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        const Text(
                          'Population: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            newPopulation.substring(
                                0, newPopulation.length - 3),
                            style: const TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        const Text(
                          'Region: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.country.region,
                            style: const TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        const Text(
                          'Capital: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            widget.country.capital.toString().substring(1,
                                widget.country.capital.toString().length - 1),
                            style: const TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        const Text(
                          'Area: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${widget.country.area} km²',
                            style: const TextStyle(fontSize: 16)),
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        const Text(
                          'Language: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(languages.values.first,
                            style: const TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        const Text(
                          'Currency: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(currency.values.first['name'],
                            style: const TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        const Text(
                          'Time zone: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(timezones.first.toString(),
                            maxLines: 3, style: const TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        const Text(
                          'Driving Side: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.country.drivingSide,
                            maxLines: 3, style: const TextStyle(fontSize: 16)),
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        const Text(
                          'Subregion: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.country.subregion,
                            style: const TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        const Text(
                          'Continent: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.country.continent,
                            style: const TextStyle(fontSize: 16)),
                      ]),
                    ),
                  ],
                ),
              ))),
    );
  }
}
