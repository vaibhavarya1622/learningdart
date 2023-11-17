import 'package:flutter/material.dart';

import 'container_example.dart';

class StackExample extends StatelessWidget {
  const StackExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Example'),
      ),
      body: Center(
        child: Stack(
          //If we don't override this (clip) behaviour, then all the children will be clipped to the first child, try exploring this Clip enum to see other effects. 
          clipBehavior: Clip.none,
          children: [
            ContainerExample(color: Colors.lightGreen),
            //Second child will be 16 pixels from bottom of the first child i.e., green one
            //8 pixels from left
            Positioned(
              bottom: 16,
              left: 8,
              child: ContainerExample(color: Colors.lightBlue),
            ),
            //Second child will be 32 pixels from bottom of the first child i.e., green one
            // pixels from left
            Positioned(
              bottom: 32,
              left: 16,
              child: ContainerExample(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
