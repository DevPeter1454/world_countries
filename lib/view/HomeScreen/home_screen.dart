import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:world_countries/loading.dart';
import 'package:world_countries/models/country/country_model.dart';
import 'package:world_countries/provider/theme_provider.dart';
import 'package:world_countries/repository/Api%20Country/apiservice.dart';
import 'package:world_countries/view/DetailsScreen/detail_screen.dart';
import 'package:world_countries/view/HomeScreen/constants/changetheme.dart';
import 'package:world_countries/view/HomeScreen/constants/tile.dart';

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
  GoogleTranslator translator = GoogleTranslator();
  String text = 'Hello';

  getAllCountries() async {
    await apiServices.getAllCountries().then((value) {
      print(value);

      countries = value;
      countries.sort((a, b) => a.name.compareTo(b.name));
      setState(() {});
    });
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
              Image.asset(
                'assets/images/ex_logo.png',
                height: 25.5,
              ),
              SizedBox(
                height: 50,
                width: 40,
                child: ChangeThemeButtonWidget(),
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
              onChanged: (value) {
                print('done');
                setState(() {
                  countries.clear();
                });
                ;
                apiServices
                    .getCountryByName(textEditingController.text)
                    .then((value) {
                  countries = value;
                  countries.sort((a, b) => a.name.compareTo(b.name));
                  setState(() {});
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
                onTap: () {
                  
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
              Container(
                height: 30,
                width: 65,
                decoration: BoxDecoration(
                  color: const Color(0XFFF2F4F7),
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(color: const Color(0XFFA9B8D4), width: 0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.language_outlined,
                      color: Color(0XFF1C1917),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'EN',
                      style: TextStyle(color: Color(0XFF1C1917)),
                    )
                  ],
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
                    itemCount: countries.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, DetailsScreen.routeName,
                              arguments: countries[index]);
                        },
                        child: Tile(
                            flagUrl: countries[index].flags,
                            countryName: countries[index].name,
                            countryCapital:
                                countries[index].capital.toString()),
                      );
                    })),
          )
        ],
      ),
    )));
  }
}
