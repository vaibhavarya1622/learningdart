import 'package:flutter/material.dart';

class StreamBuilderExample extends StatelessWidget{
    const StreamBuilderExample({Key?key}): super(key: key);

    Stream<int> streamList(int n) async* {
      //yield is keyword to 'return' the current element of the stream
      for(int i=0;i<n;++i){
        await Future.delayed(const Duration(seconds: 1));
        yield i;
      }
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Stream Builder example'),
          ),
          body: Center(
            child: StreamBuilder<int>(
              stream: streamList(10),
              //builder is a functional parameter taking two params which are BuildContext context and AsyncSnapshot snapshot
              //snapshot will capture the result coming from the future param

              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                } else if(snapshot.hasData){
                  return Text('The item number is ${snapshot.data!}');
                } else{
                  return const Text('Something wrong happened');
                }
              },
            ),
          ),
        );
    }
}