import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  VoidCallback function;
  String label;
  CustomButton(this.function, this.label);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: RaisedButton(
        color: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onPressed: function,
        child: Text(label , style:TextStyle(  color: Colors.white,fontSize: 16) ,
          ),
      ),
    );
  }
}
