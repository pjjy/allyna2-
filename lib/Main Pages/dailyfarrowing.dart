import 'package:flutter/material.dart';
import 'package:flutter_application_1/Main%20Pages/addFarrowing.dart';
import 'package:flutter_application_1/sql/sql.dart';

class MyDailyFarrowing extends StatefulWidget {
  const MyDailyFarrowing({Key? key}) : super(key: key);

  @override
  _MyDailyFarrowingState createState() => _MyDailyFarrowingState();
}

class _MyDailyFarrowingState extends State<MyDailyFarrowing> {
  List data = [];
  List data1 = [];
  final sqlLite = CheckData();
  Future fetchFarrowingData() async {
    var response = await sqlLite.fetcFarrowingData();
    setState(() {
      data = response;
      // print(data);
    });
  }

  Future fetchDashFarrowing(id) async {
    var response = await sqlLite.fetchDashFarrowing(id);
    setState(() {
      data1 = response;
    });
    print("haha");
    print(data1);
  }

  void _show(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: Container(
          width: 1000,
          height: 600,
          color: Colors.white54,
          alignment: Alignment.center,
          child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              children: [
                Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Liiter Order"),
                        SizedBox(height: 8), // Add some space between the texts
                        Text(data1[0]
                            ["litterOrder"]), // Your additional text here
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Age"),
                        SizedBox(height: 8), // Add some space between the texts
                        Text(data1[0]["age"]), // Your additional text here
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Birth Weight"),
                        SizedBox(height: 8), // Add some space between the texts
                        Text(data1[0]["birthWt"]), // Your additional text here
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pigs Wearned"),
                        SizedBox(height: 8), // Add some space between the texts
                        Text(data1[0]
                            ["pigsWearned"]), // Your additional text here
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Interval"),
                        SizedBox(height: 8), // Add some space between the texts
                        Text(data1[0]["interval"]), // Your additional text here
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Future<void> confirmDialog(BuildContext context, id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete data'),
          content: const Text("Are you sure you want to delete this data?"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                sqlLite.deleteFarrowing(id);
                fetchFarrowingData();
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    fetchFarrowingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFarrowing()));
        },
        child: Icon(Icons.add),
      ),
      appBar: GradientAppBarFb1(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () =>
                {fetchDashFarrowing(data[index]["id"]), _show(context)},
            child: ListTile(
              title: Text(data[index]["date"].toString()),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  // icon-1
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        {confirmDialog(context, data[index]["id"])},
                  ), // icon-2
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GradientAppBarFb1 extends StatefulWidget implements PreferredSizeWidget {
  GradientAppBarFb1({
    Key? key,
  }) : super(key: key);

  @override
  _GradientAppBarFb1State createState() => _GradientAppBarFb1State();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _GradientAppBarFb1State extends State<GradientAppBarFb1> {
  void initState() {
    print("ajaja");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.green;
    const secondaryColor = Colors.green;

    return AppBar(
      title:
          const Text("Daily Farrowing", style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            stops: [0.5, 1.0],
          ),
        ),
      ),
    );
  }
}
