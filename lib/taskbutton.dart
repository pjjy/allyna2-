import 'package:flutter/material.dart';
import 'package:flutter_application_1/sql/sql.dart';

class MyTaskButton extends StatefulWidget {
  const MyTaskButton({super.key});

  @override
  _MyTaskButtonState createState() => _MyTaskButtonState();
}

class _MyTaskButtonState extends State<MyTaskButton> {
  List data = [];
  List data1 = [];
  final sqlLite = CheckData();
  Future totalInventory() async {
    var response = await sqlLite.totalInventory();
    setState(() {
      data = response;
    });
  }

  Future totalExpenses() async {
    var response = await sqlLite.totalExpenses();
    setState(() {
      data1 = response;
      print(data1);
    });
  }

  @override
  void initState() {
    totalInventory();
    totalExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.green;
    const secondaryColor = Colors.green;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tasks", style: TextStyle(color: Colors.white)),
          backgroundColor: primaryColor,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                stops: [0.5, 1.0],
              ),
            ),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.currency_bitcoin_rounded),
              ),
              Tab(
                icon: Icon(Icons.calendar_month),
              ),
              // Tab(
              //   icon: Icon(Icons.brightness_5_sharp),
              // ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Month: ${data[index]['month']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total sBoar: ${data[index]['Total_sBoar']}'),
                        Text('Total jBoar: ${data[index]['Total_jBoar']}'),
                        Text('Total drySow: ${data[index]['Total_drySow']}'),
                        Text(
                            'Total lactatingSow: ${data[index]['Total_lactatingSow']}'),
                        Text(
                            'Total rplcmentGlit: ${data[index]['Total_rplcmentGlit']}'),
                        Text(
                            'Total glitBreed: ${data[index]['Total_glitBreed']}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ListView.builder(
                itemCount: data1.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Month: ${data[index]['month']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total: ${data1[index]['Total_amount']}'),
                        Text('Type: ${data1[index]['tottype']}'),
                        // Text('Total drySow: ${data[index]['Total_drySow']}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Center(
            //   child: Text("It's sunny here"),
            // ),
          ],
        ),
      ),
    );
  }
}

class GradientAppBarFb1 extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  GradientAppBarFb1({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.green;
    const secondaryColor = Colors.green;

    return AppBar(
      title: const Text("Taskss", style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            stops: [0.5, 1.0],
          ),
        ),
      ),
      bottom: const TabBar(
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.cloud_outlined),
          ),
          Tab(
            icon: Icon(Icons.beach_access_sharp),
          ),
          Tab(
            icon: Icon(Icons.brightness_5_sharp),
          ),
        ],
      ),
    );
  }
}
