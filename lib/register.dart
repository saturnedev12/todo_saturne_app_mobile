import 'package:flutter/material.dart';
import 'main.dart';

showAlertDialog(BuildContext context,TextEditingController controller,List<String> datas,Function save) {

  // set up the buttons
  Widget cancelButton = RaisedButton(
    child: Text("annuler",style: TextStyle(color: Colors.white),),
    color: Colors.redAccent,
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = RaisedButton(
    child: Text("enregistrer",style: TextStyle(color: Colors.white),),
    color: Colors.greenAccent,
    onPressed:  () {
      save();
      Navigator.pop(context);
    },
  );
  //Content

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.grey[300],
    title: Text("votre tâche a faire",
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
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: "entrer une note",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      /*child: Row(
        children: [

        ],
      ),*/

    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}