import 'package:flutter/material.dart';
import 'package:flutter_application_1/Main%20Pages/addExpenses.dart';
import 'package:flutter_application_1/sql/sql.dart';

class MyProductionofPerformance extends StatefulWidget {
  const MyProductionofPerformance({Key? key}) : super(key: key);

  @override
  _MyDailyStockInventoryState createState() => _MyDailyStockInventoryState();
}

class _MyDailyStockInventoryState extends State<MyProductionofPerformance> {
  List data = [];
  List data1 = [];
  final sqlLite = CheckData();
  Future fetcDailyExpenseData() async {
    var response = await sqlLite.fetcDailyExpenseData();
    setState(() {
      data = response;
      // print(data);
    });
  }

  Future fetchDashExpenses(id) async {
    print(id);
    var response = await sqlLite.fetchDashExpenses(id);
    setState(() {
      data1 = response;
      print(data1);
    });
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
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Type"),
                        const SizedBox(
                            height: 8), // Add some space between the texts
                        Text(data1[0]["type"]), // Your additional text here
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Amount"),
                        const SizedBox(
                            height: 8), // Add some space between the texts
                        Text(data1[0]["amount"]), // Your additional text here
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
                sqlLite.deleteExpense(id);
                fetcDailyExpenseData();
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
    fetcDailyExpenseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddExpenses()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: GradientAppBarFb1(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => {fetchDashExpenses(data[index]["id"]), _show(context)},
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
  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.green;
    const secondaryColor = Colors.green;

    return AppBar(
      title: const Text("Expenses", style: TextStyle(color: Colors.white)),
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
