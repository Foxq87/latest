// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Hours extends StatelessWidget {
  int hours;
  Hours({Key? key,required this.hours}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
          child: Text(hours.toString(),
              style: const TextStyle(inherit: false,fontSize: 35.0, fontWeight: FontWeight.w500,color: Colors.white))),
    );
  }
}
