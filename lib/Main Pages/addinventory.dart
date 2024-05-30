import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Main%20Pages/dailystockinventory.dart';
import 'package:flutter_application_1/sql/sql.dart';

class AddInventory extends StatefulWidget {
  const AddInventory({Key? key}) : super(key: key);

  @override
  State<AddInventory> createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  final sBoar = TextEditingController();
  final jBoar = TextEditingController();
  final drySow = TextEditingController();
  final sowBreed = TextEditingController();
  final lactatingSow = TextEditingController();
  final rplcmentGlit = TextEditingController();
  final glitBreed = TextEditingController();
  final date = TextEditingController();
  final sqlLite = CheckData();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date.text = picked
            .toLocal()
            .toString()
            .split(' ')[0]; // Ensure correct date format
      });
    }
  }

  Future<void> confirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add data'),
          content: const Text("Are you sure you want to add this data"),
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
                sqlLite.addInventory(
                  sBoar.text,
                  jBoar.text,
                  drySow.text,
                  sowBreed.text,
                  lactatingSow.text,
                  rplcmentGlit.text,
                  glitBreed.text,
                  date.text,
                );
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyDailyStockInventory(),
                  ),
                );
              },
              child: const Text('Confirm'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBarFb1(),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
        child: ListView(
          children: <Widget>[
            const Text(
              "S.boars",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: sBoar,
                decoration: const InputDecoration(
                  labelText: "Enter your number",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ], // Only numbers can be entered
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "J.Boars",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: jBoar,
                decoration: const InputDecoration(
                  labelText: "Enter your number",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ], // Only numbers can be entered
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Dry sow",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: drySow,
                decoration: const InputDecoration(
                  labelText: "Enter your number",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ], // Only numbers can be entered
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Sow breed",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: sowBreed,
                decoration: const InputDecoration(
                  labelText: "Enter your number",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ], // Only numbers can be entered
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Lactating sow",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: lactatingSow,
                decoration: const InputDecoration(
                  labelText: "Enter your number",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ], // Only numbers can be entered
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Replacement glit",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: rplcmentGlit,
                decoration: const InputDecoration(
                  labelText: "Enter your number",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ], // Only numbers can be entered
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Glit breed",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: glitBreed,
                decoration: const InputDecoration(
                  labelText: "Enter your number",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ], // Only numbers can be entered
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Date",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  enabled: false,
                  controller: date,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  confirmDialog(context);
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GradientAppBarFb1 extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const GradientAppBarFb1({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.green;
    const secondaryColor = Colors.green;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "Daily Farrowing",
        style: TextStyle(color: Colors.white),
      ),
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
