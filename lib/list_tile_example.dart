import 'package:flutter/material.dart';

class ListTileExample extends StatelessWidget{
    ListTileExample({Key?key}):super(key: key);

    Stream<int> streamListOfSquares(int n) async*{
        for(int i=1;i<n;++i){
          await Future.delayed(const Duration(seconds: 1));
          yield i*i;
        }
    }
    final List<int> integerList = [];

    @override
    Widget build(BuildContext context){
      return Scaffold(
          appBar: AppBar(
            title: const Text('Stream Builder Example'),
          ),
        body: Center(
          child: StreamBuilder<int>(
            stream: streamListOfSquares(10),
            builder: (context,snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              } else if(snapshot.hasData){
                  integerList.add(snapshot.data!);
                  return ListView.builder(
                      itemCount: integerList.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text('The item number is ${integerList[index]}'),
                          subtitle: Text('The index is $index'),
                        );
                      }
                  );
              } else {
            return const Text('Something Unexpected Happened');
          }
        },
          )
        ),
      );
    }
}