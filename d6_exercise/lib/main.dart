import 'package:d6_exercise/cubit_count.dart';
import 'package:d6_exercise/cubit_receive_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CubitCounter(),
          ),
          BlocProvider(
            create: (context) => CubitConvert(),
          )
        ],
          child: MyHomePage(
            title: 'Flutter Demo Home Page'
          ),
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textValue = TextEditingController();

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
            Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CubitCounter,int>(
              builder: (context, state){
                return Text('$state');
              }
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: 
              TextField(
                controller: _textValue,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Input Words to convert into ALPH'),
              ),
            ),
            ElevatedButton(
              onPressed: () => {
                // print(_textValue.text.toUpperCase()), 
                context.read<CubitConvert>().sizeIncrement(_textValue.text)
              },
              child: Text('Convert Message')
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: 
                BlocBuilder<CubitConvert,String>(
                  builder: (context, state){
                    return Text('Converted Message: $state',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold));
                  }
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => BlocProvider.of<CubitCounter>(context).increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
