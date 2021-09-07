import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gsg2_app/Auth/proveder/auth_provider.dart';
import 'package:gsg2_app/Auth/ui/widgets/custom_textField.dart';
import 'package:gsg2_app/global_widgets/custom_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gsg2_app/Auth/ui/login_page .dart';
import 'package:gsg2_app/Auth/models/contre.dart';




class Register extends StatelessWidget {
   static final routeName = 'register';
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return  Consumer<AuthProvider>(builder:(context,provider,x){
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               SizedBox(height: size.height * 0.1),
               GestureDetector(
                onTap: () {
                  provider.selectFile();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey,
                  child: provider.file == null
                      ? Container()
                      : Image.file(provider.file, fit: BoxFit.cover),
                ),
              ),
              Text(
                "Welcome !", textAlign: TextAlign.center, 
                 style: TextStyle(
                   fontSize: 18,
                   color: Colors.green,
                   fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.0),
              Text(
                "Please sing in to your account.", textAlign: TextAlign.center, 
                 style: TextStyle(
                   fontSize: 15,
                   color: Colors.black38),
              ),
               SizedBox(height: size.height * 0.01),
             CustomTextfield('FirstName', provider.firstNameController),
              CustomTextfield('LastName', provider.lastNameController),
              CustomTextfield('Country', provider.countryController),
              CustomTextfield('City', provider.cituController),
              CustomTextfield('Email', provider.emailController),
              CustomTextfield('Password', provider.passwordController),
              provider.countries == null
                  ? Container()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton<CountryModel>(
                        isExpanded: true,
                        underline: Container(),
                        value: provider.selectedCountry,
                        onChanged: (x) {
                          provider.selectCountry(x);
                        },
                        items: provider.countries.map((e) {
                          return DropdownMenuItem<CountryModel>(
                            child: Text(e.name.toString()),
                            value: e,
                          );
                        }).toList(),
                      ),
                    ),
              provider.countries == null
                  ? Container()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton<dynamic>(
                        isExpanded: true,
                        underline: Container(),
                        value: provider.selectedCity,
                        onChanged: (x) {
                          provider.selectCity(x);
                        },
                        items: provider.cites.map((e) {
                          return DropdownMenuItem<dynamic>(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                      ),
                    ),
              SizedBox(height: size.height * 0.03),
              CustomButton(provider.register, 'Register'),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an Accout ?",
                  style: TextStyle(color: Colors.black45),
                  
                  ),
                  FlatButton(
                    onPressed: (){
                     Navigator.push(context,MaterialPageRoute(builder: (context) => Login(),));
                    },
                    child: Text('Sign Up',style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold ) ))

                ],)
            ],
            ),
          ),
        );
      } 
      );
      
    
  }
}