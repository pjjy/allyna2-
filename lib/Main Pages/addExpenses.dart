import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Main%20Pages/productionofperformance.dart';
import 'package:flutter_application_1/sql/sql.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  State<AddExpenses> createState() => _AddInventory();
}

class _AddInventory extends State<AddExpenses> {
  final TextEditingController amount = TextEditingController();
  final TextEditingController date = TextEditingController();
  final CheckData sqlLite = CheckData();

  DateTime selectedDate = DateTime.now();

  @override
void initState() {
  super.initState();
  amount.addListener(() {
    if (amount.text.isNotEmpty && amount.text.startsWith('0')) {
      // Remove leading zeros
      amount.text = amount.text.replaceFirst(RegExp('^0+'), '');
      amount.selection = TextSelection.fromPosition(
        TextPosition(offset: amount.text.length),
      );
    }
  });
}


  @override
  void dispose() {
    amount.dispose();
    date.dispose();
    super.dispose();
  }

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
        date.text = picked.toString().substring(0, 10);
      });
    }
  }

  Future<void> confirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add data'),
          content: const Text("Are you sure you want to add this data?"),
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
                // Validate dropdown and amount before proceeding
                if (_dropDownValue.isEmpty || amount.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                  return;
                }
                sqlLite.addExpenses(_dropDownValue, amount.text, date.text);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProductionofPerformance(),
                  ),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  String _dropDownValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBarFb1(),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
        child: ListView(
          children: <Widget>[
            const Text(
              "Type Of Expenses",
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
              child: DropdownButton(
                hint: _dropDownValue.isEmpty
                    ? const Text('')
                    : Text(
                        _dropDownValue,
                        style: const TextStyle(color: Colors.blue),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: const TextStyle(color: Colors.blue),
                items: ['Feeds', 'Electricity'].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(() {
                    _dropDownValue = val.toString();
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Amount",
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
                controller: amount,
                decoration: const InputDecoration(labelText: ""),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
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
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
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
            ),
          ],
        ),
      ),
    );
  }
}

class GradientAppBarFb1 extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const GradientAppBarFb1({Key? key})
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyProductionofPerformance(),
            ),
          );
        },
      ),
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

