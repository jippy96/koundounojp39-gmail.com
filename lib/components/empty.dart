import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String message;

  const Empty({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info,
          size: 30,
          color: Colors.red,
        ),
        Text(
          this.message,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
