import 'package:flutter/material.dart';

class ListViewExample extends StatelessWidget{
  const ListViewExample({Key?key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Example'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return Container(
            width: 200,
            height: 200,
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: index%2 == 0?Colors.lightGreen:Colors.lightBlue,
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Center(
              child: Text('My jersey number is $index',
              style: const TextStyle(color: Colors.white,fontSize: 20)),
            ),
          );
        },
      ),
    );
  }
}