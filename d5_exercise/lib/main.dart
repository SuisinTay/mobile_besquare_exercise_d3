import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';

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
  int _counter = 0;
  List<String>_symbolsArray = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _generateButton(){
    final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');

    channel.stream.listen((message){
      final decodedMessage = jsonDecode(message);
      final activeSymbolArray = decodedMessage ['active_symbols'];
      for(int i = 0; i < activeSymbolArray.length; i++){
        print(activeSymbolArray[i]['symbol']);
        // _symbolsArray.add(activeSymbolArray[i]['symbol']);
      }

      channel.sink.close();
    });

    print(_symbolsArray);
    channel.sink.add('{"active_symbols": "brief","product_type": "basic"}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child:
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _generateButton, 
                    child: Text('Connect to API')
                  ),
                  ElevatedButton(
                    onPressed: ()=>print("Bye"), 
                    child: Text('Stop Connecting to API')
                  )
                ],
              ),
            ),
            Container(
              child:
              Text(
                'You have pushed the button this many times:',
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
