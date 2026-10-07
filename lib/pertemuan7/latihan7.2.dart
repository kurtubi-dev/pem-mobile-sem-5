import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Checkbox State
  final Map<String, bool> _toppings = {
    "Onions": false,
    "Mushrooms": false,
    "Black olives": false,
    "Green peppers": false,
    "Extra cheese": false,
  };

  // Radio State
  String? _selectedSize = "Small";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Checkbox & Radio Buttons')),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              Text(
                'Select Your Pizza Toppings :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              ..._toppings.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key, style: TextStyle(fontSize: 20.0)),
                  value: _toppings[key],
                  onChanged: (bool? value) {
                    setState(() {
                      _toppings[key] = value ?? false;
                    });
                    List<String> checked = _toppings.entries
                        .where((e) => e.value)
                        .map((e) => e.key)
                        .toList();
                    print(checked.toString());
                  },
                );
              }).toList(),
              SizedBox(height: 10.0),
              Text(
                'Select Your Pizza Size:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              ...["Small", "Medium", "Large"].map((String size) {
                return RadioListTile<String>(
                  title: Text(size, style: TextStyle(fontSize: 20.0)),
                  value: size,
                  groupValue: _selectedSize,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedSize = value;
                    });
                    print(_selectedSize);
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
