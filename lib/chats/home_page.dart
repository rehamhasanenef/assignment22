import 'package:flutter/material.dart';
import 'package:gsg2_app/Auth/helpers/firstore_helper.dart';
import 'package:gsg2_app/chats/profille_page.dart';
import 'package:gsg2_app/chats/ueser_page.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child:
            Scaffold(body: TabBarView(children: [UerePage(), ProfilePage()])));
  }
}
