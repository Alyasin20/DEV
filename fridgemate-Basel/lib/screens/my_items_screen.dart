import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../globals.dart';

class MyItemsScreen extends StatefulWidget {
  const MyItemsScreen({Key? key}) : super(key: key);

  @override
  _MyItemsScreenState createState() => _MyItemsScreenState();
}

class _MyItemsScreenState extends State<MyItemsScreen> {
  // Function to handle item deletion and refresh the screen
  void _deleteItem(Map<String, dynamic> item) {
    setState(() {
      itemList.remove(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Items', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepOrange,
          bottom: TabBar(
            isScrollable: true,
            tabs: categories.map((category) => Tab(text: category)).toList(),
          ),
        ),
        body: TabBarView(
          children: categories.map((category) {
            final itemsInCategory = itemList.where((item) => item['category'] == category).toList();
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: itemsInCategory.length,
              itemBuilder: (context, index) {
                final item = itemsInCategory[index];
                final expiryDate = item['expiryDate'];
                final expired = expiryDate.isBefore(DateTime.now());
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteItem(item); // Use the delete function here
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text("Purchase Date: ${DateFormat('MM/dd/yyyy').format(item['purchaseDate'])}"),
                        Text("Expiry Date: ${DateFormat('MM/dd/yyyy').format(expiryDate)}"),
                        if (expired)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "Expired ${DateTime.now().difference(expiryDate).inDays} days ago",
                              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
