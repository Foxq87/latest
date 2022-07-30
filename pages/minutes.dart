// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Minutes extends StatelessWidget {
  int mins;
  Minutes({Key? key,required this.mins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
          child: Text(mins< 10 ? '0' + mins.toString():mins.toString(),
              style: TextStyle(inherit:false,fontSize: 35.0, fontWeight: FontWeight.w500),),)
    );
  }
}
