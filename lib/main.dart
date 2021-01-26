import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'replace.dart';
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
        primarySwatch: Colors.orange,
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
  void saveTodo(){
    setState(() {
      datas.insert(0,myCotroller.text);
      setListData('MYDATA', datas);
      myCotroller.text ="";
    });
  }
  void remplaceTodo(int i, String data){
    setState(() {
      datas[i] = data;
      setListData('MYDATA', datas);
      myCotroller.text ="";
    });

  }
  void removeTodo(String s){
    setState(() {
      datas.remove(s);
      setListData('MYDATA', datas);
      //super.initState();
      myCotroller.text ="";
    });
  }
 final myCotroller = TextEditingController();
 List<String> datas = <String>['ajouter une têche a faire'];
 void initState() {
    getListData('MYDATA').then((value){
      if(value.isNotEmpty){
        setState(() {
          datas = value;
        });
      }
      else{
        datas.add("ajouter une têche a faire");
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title:Text("Saturne Todo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle:true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              Colors.white,
              Colors.white,
            ])),
            child:  Center(
              child: GestureDetector(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        for(String s in datas)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                              width: 100,
                              height: 30, margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding:EdgeInsets.zero,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon:Icon(Icons.create_outlined ,color:Colors.greenAccent,size: 20,),
                                    focusColor: Colors.pink,
                                    onPressed: (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.grey[300],
                                            title: Text("remplacer par ?",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orangeAccent
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.zero,
                                            content: Container(
                                              width: 400,
                                              padding: EdgeInsets.all(10),
                                              color: Colors.grey[300],
                                              child: TextField(
                                                controller: myCotroller,
                                                keyboardType: TextInputType.multiline,
                                                maxLines: 4,
                                                textInputAction: TextInputAction.done,
                                                decoration: InputDecoration(
                                                  hintText: "changer par",
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),

                                            ),
                                            actions: [
                                              RaisedButton(
                                                child: Text("annuler",style: TextStyle(color: Colors.white),),
                                                color: Colors.redAccent,
                                                onPressed:  () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              RaisedButton(
                                                child: Text("remplacer",style: TextStyle(color: Colors.white),),
                                                color: Colors.greenAccent,
                                                onPressed:  () {
                                                  remplaceTodo(datas.indexOf(s),myCotroller.text);
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                ),
                                  IconButton(
                                    icon:Icon(Icons.delete,color:Colors.redAccent,size: 20,),
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
                                  ),
                                ],
                              ),
                            ),
                              Container(
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:Colors.cyan,
                                ),
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child:  Text("$s",style: TextStyle(
                                        fontFamily: "Chilanka",
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),

                      ],
                    ),
                  ),

                ),
              ),

            ),

          /**/

      ),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("cocou");
          showAlertDialog(context, myCotroller, datas, saveTodo);
        },
        tooltip: 'Increment',
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.add),
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

