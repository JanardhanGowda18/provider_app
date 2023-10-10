import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/Itemlist.dart';
import 'package:provider_app/model/Item_data.dart';
import 'package:provider_app/model/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightBlue),
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String newItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Provider App'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      newItem = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (newItem.isNotEmpty) {
                Provider.of<ItemData>(context, listen: false)
                    .addItem(Item(item: newItem));
                setState(() {
                  newItem = '';
                });
              }
            },
            child: Text('Submit'),
          ),
          Expanded(
            child: ItemList(),
          ),
        ],
      ),
    );
  }
}
