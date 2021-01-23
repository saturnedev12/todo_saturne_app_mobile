import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
 final myCotroller = TextEditingController();
 List<String> datas = <String>['not thing'];
 void initState() {
    getListData('MYDATA').then((value){
      if(value.isNotEmpty){
        datas = value;
      }
      else{
        datas.add("nothing");
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title:Container(
          width: double.infinity,
          child: TextField(
            controller: myCotroller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: "entrer une note",
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for(String s in datas)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:Colors.cyan[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$s"),
                      IconButton(
                        icon:Icon(Icons.delete,color:Colors.redAccent),
                        focusColor: Colors.pink,
                        onPressed: (){
                          print("$s");
                          setState(() {
                            datas.remove(s);
                            setListData('MYDATA', datas);
                            //super.initState();
                            myCotroller.text ="";
                          });
                        },
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("${myCotroller.text}");
          setState(() {
            datas.add(myCotroller.text);
            setListData('MYDATA', datas);
            //super.initState();
            myCotroller.text ="";
          });
        },
        tooltip: 'Increment',
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.save_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
Future< List<String> > getListData(String key) async {
  SharedPreferences myPrefs = await SharedPreferences.getInstance();
  return myPrefs.getStringList(key);
}
Future<void> setListData(String key,List<String> value)async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setStringList(key, value);
}

