import 'package:flutter/material.dart';

class FutureBuilderExample extends StatelessWidget{
  const FutureBuilderExample({Key?key}):super(key:key);

  Future<String> getTextFromFuture(){
    return Future.delayed(const Duration(seconds: 5),()=>'I am from Future');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Builder example'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: getTextFromFuture(),
          //builder is a functional parameter taking two params which are BuildContext context and AsyncSnapshot snapshot
          //snapshot will capture the result coming from the future param
          builder: (context,snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            } else if(snapshot.hasData){
              return Text(snapshot.data!);
            } else{
              return const Text('Something wrong happened');
            }
          },
        ),
      ),
    );
  }
}