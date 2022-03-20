
import 'package:app_minhascompras/screens/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
 
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      drawer: menuDrawer(context),
    );
  }
}