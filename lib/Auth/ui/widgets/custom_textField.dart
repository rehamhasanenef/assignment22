import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  String label;
  TextEditingController controller;
  CustomTextfield(this.label,this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top: 20),
      width: 350.0,
      height: 55.0,
      decoration: BoxDecoration(
        color: Color(0xffF2F2F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
           controller: this.controller,
        decoration: InputDecoration(
        
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle( fontSize: 16, color:Color(0xffB6B7B7),fontFamily: 'Metropolis',),
        ),
     
      ),
    );
  }
}
