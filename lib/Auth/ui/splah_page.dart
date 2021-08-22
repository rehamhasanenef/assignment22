import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gsg2_app/Auth/ui/login_page .dart';
import 'package:gsg2_app/Auth/ui/register_page.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String _platformVersion;
  AnimationController animationController;
  String token;
  @override
  void initState() {
    super.initState();
   // initPlatformState();
    getPrefValues();
    checkLogin();
   
   
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        
        body: ListView(
          children: [
            SizedBox(height: screenSize.height * .4),
            Hero(
                tag: 'logo',
                child: Image.asset('assets/image/',
                    width: 200, height: 100)),
          ],
        ),
      ),
    );
  }

  checkLogin() async {
    String _token = await getPrefString(accessToken);
    if (IdTok != '') {
      Timer(Duration(seconds: 2),
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),),));
    } else {
      Timer(Duration(seconds: 2),
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),),));
    }
  }
  getPrefValues() async {
    String tokenPref = await getPrefString(accessToken);
    setState(() {
      token = tokenPref;
    });
  }
 
 
 
 

}
