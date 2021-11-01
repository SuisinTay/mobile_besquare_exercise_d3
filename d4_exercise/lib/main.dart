import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  List _items = [];

  //Fetch content from json file
  Future<void>readJson()async{
    final dynamic response = await rootBundle.loadString('/exercise_data.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: readJson(),
        builder: (context,data){
        return Column(
          children: [
            _items.isNotEmpty ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context,index){
                  return Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.blue,width: 2))),
                    margin: const EdgeInsets.all(10),
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: 
                        Container(
                          child: CircleAvatar(
                            backgroundImage: _items[index].containsKey("avatar") ? NetworkImage(_items[index]["avatar"]) : NetworkImage("https://d32ogoqmya1dw8.cloudfront.net/images/serc/empty_user_icon_256.v2.png"),
                          ),
                        ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Align(alignment: Alignment.centerLeft,child: Text(_items[index]["first_name"] + " " + _items[index]["last_name"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),),
                                Align(alignment: Alignment.centerLeft,child: Text(_items[index]["username"],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),),
                                Align(alignment: Alignment.centerLeft,child: Text(_items[index].containsKey("status") ? _items[index]["status"] : "N/A",style: TextStyle(color: Colors.grey),))
                              ],
                            ),
                        ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Text(_items[index]["last_seen_time"],style: TextStyle(color: Colors.grey),),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),
                                  child: Text(_items[index].containsKey("messages") ? _items[index]["messages"].toString() : "0",),
                                )
                              ],
                            ),
                          )
                        ),
                      ],
                    ),
                  );
                }
              ),
            ) : Container()
          ]
        );
        }
      ),
    );
  }
}