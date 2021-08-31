
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gsg2_app/services/routes_helper.dart';
import 'package:provider/provider.dart';
import 'package:gsg2_app/Auth/proveder/auth_provider.dart';
import 'package:gsg2_app/Auth/ui/register_page.dart';
import 'package:gsg2_app/Auth/ui/login_page .dart';
import 'package:gsg2_app/services/routes_helper.dart';
import 'package:gsg2_app/Auth/ui/widgets/reset_password_page.dart';
import 'package:gsg2_app/chats/home_page.dart';
import 'package:gsg2_app/chats/profille_page.dart';
import 'package:gsg2_app/chats/Ueser_page.dart';


void main() {
  runApp(ChangeNotifierProvider<AuthProvider>(
    create:(context) => AuthProvider(),
    
    child: MaterialApp(
       routes: {
            Login.routeName: (context) => Login(),
            Register.routeName: (context) => Register(),
            ResetPasswordPage.routeName: (context) => ResetPasswordPage(),
             HomePage.routeName: (context) => HomePage(),
              ProfilaPage.routeName: (context) => ProfilaPage(),
               UerePage.routeName: (context) => UerePage(),

            
          },
      navigatorKey: RouteHelper.routeHelper.navKey,
      home: FirbaseConfiguration())));
}
 
 class FirbaseConfiguration extends StatelessWidget {
  
   @override
   Widget build(BuildContext context) {
     return FutureBuilder<FirebaseApp>(
       future: Firebase.initializeApp(),
       builder: (context,AsyncSnapshot<FirebaseApp>dataSnapshot){  
         if(dataSnapshot.hasError){
           return Scaffold(
             backgroundColor: Colors.red,
           body: Center(child: Text(dataSnapshot.error.toString()),),
           );
         }
         if(dataSnapshot.connectionState==ConnectionState.done){
           return Register();
         }
         return Scaffold(
           body:Center(child: CircularProgressIndicator(),)
         );
       });

   }
 }
