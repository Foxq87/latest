import 'package:flutter/material.dart';
import 'tests_add.dart';

class Categories extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  int index;
  String collectionName;
  Categories(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isSelected,
      required this.index,
      required this.collectionName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentCollection = '';

    return GestureDetector(
      onTap: () {
        onTap();
        currentCollection = categorie[index][0].toString();
        print(currentCollection);
        Navigator.of(context).pop(currentCollection);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 5),
        child: Text(title,
            style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey[700])),
      ),
    );
  }
}
