import 'package:flutter/material.dart';

class ContainerExample extends StatelessWidget {
  final Color color;

  const ContainerExample({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: const Text('I am inside a container.',
          style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
