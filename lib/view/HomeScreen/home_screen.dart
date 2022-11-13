import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:world_countries/provider/theme_provider.dart';
import 'package:world_countries/repository/Api%20Country/apiservice.dart';
import 'package:world_countries/view/DetailsScreen/detail_screen.dart';
import 'package:world_countries/view/HomeScreen/constants/changetheme.dart';
import 'package:world_countries/view/HomeScreen/constants/tile.dart';
import 'constants/global_variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  ApiServices apiServices = ApiServices();
  bool isDone = false;
  List countries = [];
  bool value = false;
  List<String> selected = [];
  bool isContinent = false;
  int countriesLength = 0;

  var continentFilter = GlobalVariables().regionFilter;

  getAllCountries() async {
    apiServices.getAllCountries().then((value) {
      countries = value['data'];
      countriesLength = value['length'];
      countries.sort((a, b) => a.name.compareTo(b.name));
      setState(() {});
    });
  }

  getCountriesByRegion(List region) async {
    apiServices.getCountryByRegion(region).then((value) {
      countries = value['data'];
      countriesLength = value['length'];
      countries.sort((a, b) => a.name.compareTo(b.name));
      setState(() {});
    });
  }

  port() {
    // print('port');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  defaultScreen() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  land() {
    // print('land');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCountries();
    textEditingController.addListener(() {
      if (textEditingController.text.isEmpty) {
        countries.clear();
        getAllCountries();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    print(countriesLength);
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              themeProvider.themeMode == ThemeMode.dark
                  ? Image.asset(
                      'assets/images/dark_logo-.png',
                      height: 25.5,
                    )
                  : Image.asset(
                      'assets/images/ex_logo.png',
                      height: 25.5,
                    ),
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 40,
                    child: ChangeThemeButtonWidget(),
                  ),
                  IconButton(
                      onPressed: () {
                        MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? land()
                            : port();
                      },
                      icon: const Icon(Icons.refresh))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: TextField(
              textAlign: TextAlign.center,
              controller: textEditingController,
              cursorColor: const Color(0XFF667085),
              onEditingComplete: () {
                setState(() {
                  countries.clear();
                });
                apiServices
                    .getCountryByName(textEditingController.text)
                    .then((value) {
                  countries.clear();

                  if (value == null) {
                    EasyLoading.showError('No Country Found');
                  }
                  if (value['data'] != null && value['data'].length > 0) {
                    countries = value['data'];

                    countriesLength = value['length'];
                    countries.sort((a, b) => a.name.compareTo(b.name));
                    setState(() {});
                  }
                  // if(value['data'] )
                });
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: themeProvider.themeMode == ThemeMode.dark
                      ? const Color(0XFF1E2C41)
                      : const Color(0XFFF2F4F7),
                  hintText: 'Search Country',
                  hintStyle: const TextStyle(color: Color(0XFF667085)),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: Color(0XFF667085)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(4)))),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 65,
                  decoration: BoxDecoration(
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? const Color(0XFF000F24)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border:
                        Border.all(color: const Color(0XFFA9B8D4), width: 0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.language_outlined,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'EN',
                        // style: TextStyle(),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showMaterialModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return StatefulBuilder(builder: ((context, setState) {
                          return Container(
                            decoration: BoxDecoration(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? const Color(0XFF000F24)
                                    : Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            height: isContinent
                                ? MediaQuery.of(context).size.height * 0.9
                                : MediaQuery.of(context).size.height * 0.3,
                            child: ListView(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      'Filter',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isContinent = false;
                                          selected.clear();
                                        });
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      'Region',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isContinent = !isContinent;
                                        });
                                      },
                                      icon: isContinent
                                          ? const Icon(Icons.arrow_drop_up)
                                          : const Icon(Icons.arrow_drop_down))
                                ],
                              ),
                              if (isContinent)
                                Column(
                                  children: [
                                    ...continentFilter
                                        .map((e) => CheckboxListTile(
                                              title: Text(e.title),
                                              value: e.value,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  e.value = value!;
                                                  if (e.value == true) {
                                                    selected.add(e.title);
                                                  } else {
                                                    selected.remove(e.title);
                                                  }
                                                });
                                              },
                                            ))
                                        .toList(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  for (var element
                                                      in continentFilter) {
                                                    element.value = false;
                                                  }
                                                  selected.clear();
                                                });
                                                getAllCountries();
                                                Navigator.pop(context);
                                                EasyLoading.showSuccess(
                                                    'Filter Reset');
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0XFFFFFFFF)),
                                              child: const Text(
                                                'Reset',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (selected.isNotEmpty) {
                                                  getCountriesByRegion(
                                                      selected);
                                                  Navigator.pop(context);
                                                  EasyLoading.showSuccess(
                                                      'Filter Applied... Please Wait..');
                                                } else {
                                                  EasyLoading.showError(
                                                      'Please Select Atleast One Region');
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0XFFFF6C00)),
                                              child: const Text('Show Result')),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              else
                                const SizedBox.shrink(),
                            ]),
                          );
                        }));
                      });
                },
                child: Container(
                  height: 30,
                  width: 65,
                  decoration: BoxDecoration(
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? const Color(0XFF000F24)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border:
                        Border.all(color: const Color(0XFFA9B8D4), width: 0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? const Color(0XFF000F24)
                            : Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Filter',
                        style: TextStyle(),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: countries.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: countriesLength,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, DetailsScreen.routeName,
                                arguments: countries[index]);
                          },
                          child: Tile(
                            flagUrl: countries[index].flags ?? '',
                            countryName: countries[index].name,
                            countryCapital: countries[index].capital == null
                                ? 'N/A'
                                : countries[index].capital.toString(),
                          ));
                    })),
          ),
        ],
      ),
    )));
  }
}
