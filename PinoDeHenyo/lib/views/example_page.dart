import 'package:flutter/material.dart';

class Item {
  final String title;
  final String description;
  final String image;

  Item({required this.title, required this.description, required this.image});
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  Item? selectedItem;

  final List<Item> items = [
    Item(
      title: 'Item 1',
      description: 'Description for Item 1',
      image: 'assets/lesson/mangga.png',
    ),
    Item(
      title: 'Item 2',
      description: 'Description for Item 2',
      image: 'assets/lesson/mansanas.png',
    ),
    Item(
      title: 'Item 3',
      description: 'Description for Item 3',
      image: 'assets/lesson/saging.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedItem = items[index];
                  });
                },
                child: Hero(
                  tag: 'item_${items[index].title}',
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset(items[index].image),
                        Text(items[index].title),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (selectedItem != null)
          Expanded(
            child: Column(
              children: [
                Hero(
                  tag: 'item_${selectedItem!.title}',
                  child: Image.asset(selectedItem!.image),
                ),
                Text(selectedItem!.title),
                Text(selectedItem!.description),
              ],
            ),
          ),
      ],
    );
  }
}
