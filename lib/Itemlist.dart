import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/model/Item_data.dart';
import 'package:provider_app/model/item.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Item> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemData>(
      builder: (context, data, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.size,
                itemBuilder: (context, index) {
                  final item = data.items[index];

                  return GestureDetector(
                    onLongPress: () {
                      setState(() {
                        if (selectedItems.contains(item)) {
                          selectedItems.remove(item);
                        } else {
                          selectedItems.add(item);
                        }
                      });
                    },
                    child: Container(
                      color: selectedItems.contains(item)
                          ? Colors.white.withOpacity(0.5)
                          : Colors.transparent,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text(item.item[0]),
                        ),
                        title: Row(
                          children: [
                            Text(item.item),
                            Checkbox(
                              value: selectedItems.contains(item),
                              onChanged: (isChecked) {
                                setState(() {
                                  if (isChecked != null) {
                                    if (isChecked) {
                                      selectedItems.add(item);
                                    } else {
                                      selectedItems.remove(item);
                                    }
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                for (var item in selectedItems.toList()) {
                  data.removeItem(item);
                }
                setState(() {
                  selectedItems.clear();
                });
              },
              child: Text('Delete data'),
            ),
          ],
        );
      },
    );
  }
}
