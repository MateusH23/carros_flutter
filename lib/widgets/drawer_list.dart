import 'package:carros/pages/login_page.dart';
import 'package:carros/util/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqP85ZnOcRSCX3nlYdkCvSxhSuZs0bLt1He8EvGr5ne8c7mTqW"),
              ),
              accountName: Text("Mateus Hernani"),
              accountEmail: Text("mateushernani@gmail.com"),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("Mais Informações"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("Mais Informações"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () {
                //Navigator.pop(context);
                push(context, LoginPage(), replace: true);
              },
            )
          ],
        ),
      ),
    );
  }
}
