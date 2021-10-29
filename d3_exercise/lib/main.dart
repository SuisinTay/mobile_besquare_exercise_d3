import 'package:d3_exercise/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  String dropdownvalue = 'Male';

  var items = ['Male','Female','Others','Prefer Not To Say'];

  final textController_1 = TextEditingController();
  final textController_2 = TextEditingController();
  final textController_3 = TextEditingController();

  final String _imageUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg';

  textFieldChecking(){
    String text1, text2, text3;

    text1 = textController_1.text;
    text2 = textController_2.text;
    text3 = textController_3.text;

    if(text1 == '' || text2 == '' || text3 == ''){
      final snackBar = SnackBar(
        content: const Text('Please fill up all the field'),
        action: SnackBarAction(
          label: 'close',
          onPressed: () {
          // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
    }
    else{
      Navigator.push(
        this.context,
        MaterialPageRoute(builder: (context)=> Home())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            Text(
              'Welcome to Flutter',
              style: 
                TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
            ),

            Container(
              padding: EdgeInsets.only(top: 20),
              width: 400,
              child: Image(
                height: 200,
                image: NetworkImage(_imageUrl),
              ),
            ),
            SizedBox(height: 30),

            //trying other style
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right:10),
                    // padding: EdgeInsets.only(top: 20),
                    width: 190,
                    height: 30,
                    child: 
                    TextField(
                      controller: textController_1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.people),
                        border: OutlineInputBorder(),
                        labelText: 'Username'),
                    ),
                  ),

                  Container(
                    width: 100,
                    height: 30,
                    child: 
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownvalue,
                      underline: Container(
                        height: 1,
                        color: Colors.deepPurpleAccent,
                      ),
                      icon: Icon(Icons.keyboard_arrow_down),
                      items:items.map((String items){
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items)
                        );
                      }
                      ).toList(),
                      
                      onChanged: (String? newValue){
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
                ),
            ),

            Container(
              margin: EdgeInsets.only(top:10),
              // padding: EdgeInsets.only(top: 20),
              width: 300,
              height: 30,
              child: 
              TextField(
                controller: textController_2,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Email'),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              width: 300,
              height: 30,
              child: 
              TextField(
                controller: textController_3,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  labelText: 'Password'),
              ),
            ),

            SizedBox(height: 20,),

            Container(
              width: 300,
              height: 50,
              child:
              ElevatedButton(
                child: Text('Sign Up'),
                onPressed: textFieldChecking,
              ),
            )
            
          ],
        ),
      ),
      )
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
