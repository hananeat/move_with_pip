import 'package:flutter/material.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  
  @override  // @override è la descrizione di come la pagina deve apparire visivamente.
  Widget build(BuildContext context) {
   
    return Scaffold(      
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
          child: Text('Welcome to the HomePage!'), 
        ), 

      drawer: Drawer(
        child: ListView( 
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menù'),
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => _toLoginPage(context), //cliccando, chiama la funzione
            ),
          ],
        ),
      ),
    );
  } //build

  void _toLoginPage(BuildContext context){
  
    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (_) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }//_toLoginPage

} //HomePage