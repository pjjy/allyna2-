import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Main%20Pages/dailyfarrowing.dart';
import 'package:flutter_application_1/Main%20Pages/dailysales.dart';
import 'package:flutter_application_1/Main%20Pages/dailystockinventory.dart';
import 'package:flutter_application_1/Main%20Pages/productionofperformance.dart';
import 'package:flutter_application_1/Main%20Pages/summaryofmortalityreport.dart';
import 'package:flutter_application_1/taskbutton.dart';
import 'sql/sql.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  double? screenWidth;
  final sqlLite = CheckData();

  Future createDatabase() async {
    await sqlLite.init();
  }

  @override
  void initState() {
    createDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          MyTheme.largeVerticalPadding,
          const Text(
            "Welcome Arlene Cuyno!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenWidth! / 2,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 3,
                      child: Card(
                        color: MyTheme.catalogueCardColor,
                        child: Container(
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 0, 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Expanded(
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "  Check Summary Below",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyTaskButton(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Check Stats",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 3,
                      child: Image(
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/image/splash/nahes.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          MyTheme.largeVerticalPadding,
          const Row(
            children: [
              Text("Tasks",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Spacer(),
              Icon(Icons.tune),
            ],
          ),
          GridView.count(
            childAspectRatio: 0.75,
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              courseCard(
                courseImage:
                    const AssetImage('assets/image/splash/Sales.png'),
                courseName: "Daily Sales",
                courseInfo: "In The Last Month",
                coursePrice: "",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyDailyStockInventory(),
                    ),
                  );
                },
              ),
              courseCard(
                courseImage: const AssetImage(
                    'assets/image/splash/mortality_report.png'),
                courseName: "Summary Of Mortality Report",
                courseInfo: "Estimated 6 weeks",
                coursePrice: "",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MySummaryofMortality(),
                    ),
                  );
                },
              ),
              courseCard(
                courseImage:
                    const AssetImage('assets/image/splash/Farrowing.png'),
                courseName: "Daily Farrowing",
                courseInfo: "Estimated 11 weeks",
                coursePrice: "",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyDailyFarrowing(),
                    ),
                  );
                },
              ),
              courseCard(
                courseImage:
                    const AssetImage('assets/image/splash/production.jpg'),
                courseName: "Expenses",
                courseInfo: "",
                coursePrice: "",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProductionofPerformance(),
                    ),
                  );
                },
              ),
              // New courseCard for Daily Sales
              courseCard(
                courseImage: const AssetImage('assets/image/splash/inventory.png'),
                courseName: "Daily Stock Inventory",
                courseInfo: "Track daily Inventory",
                coursePrice: "",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyDailySales(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget courseCard({
    required AssetImage courseImage,
    required String courseName,
    required String courseInfo,
    required String coursePrice,
    required Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: MyTheme.courseCardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: screenWidth! < 400 ? 3 : 5,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: courseImage,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          courseName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      courseInfo,
                      style: TextStyle(fontSize: 12, color: MyTheme.grey),
                    ),
                    MyTheme.smallVerticalPadding,
                    Text(
                      coursePrice,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTheme {
  static Color get backgroundColor => Color.fromARGB(255, 222, 15, 15);
  static Color get grey => Color.fromARGB(255, 0, 0, 0);
  static Color get catalogueCardColor =>
      Color.fromARGB(255, 253, 253, 253).withOpacity(0.5);
  static Color get catalogueButtonColor => const Color(0xFF29335C);
  static Color get courseCardColor => Color.fromARGB(255, 255, 255, 255);
  static Color get progressColor => Color.fromARGB(255, 255, 149, 0);

  static Padding get largeVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 32.0));

  static Padding get mediumVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 16.0));

  static Padding get smallVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 8.0));

  static ThemeData get theme => ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blueGrey,
      ).copyWith(
        cardTheme: const CardTheme(
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              catalogueButtonColor,
            ), // Button color
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ), // Text and icon color
          ),
        ),
      );
}
