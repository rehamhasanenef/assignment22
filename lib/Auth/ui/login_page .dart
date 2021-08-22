import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gsg2_app/Auth/proveder/auth_provider.dart';
import 'package:gsg2_app/Auth/ui/widgets/custom_textField.dart';
import 'package:gsg2_app/global_widgets/custom_button.dart';
import 'package:gsg2_app/services/routes_helper.dart';
import 'package:gsg2_app/Auth/ui/widgets/reset_password_page.dart';


class  Login extends StatelessWidget {
  
   static final routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return  Consumer<AuthProvider>(builder:(context,provider,x){
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
            CustomTextfield('Email',provider.emailController),
            CustomTextfield('password',provider.passwordController),
            CustomButton(provider.login, 'Login'),
            GestureDetector(
               onTap: () {
                  RouteHelper.routeHelper.goToPage(ResetPasswordPage.routeName);
                },
              child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Forget Password?',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
            )
            
          ],
          ),
        );
      } 
      );
      
    
  }
}