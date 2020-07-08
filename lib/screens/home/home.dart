import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = 'NULL', url, name = 'Name';
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingsForm();
          });
    }

    _authService.getCurrentUser().then((data) {
      setState(() {
        url = data['3'];
        name = data['2'];
      });
    });
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: bgbarcolor,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: FlatButton(
                color: Colors.white,
                onPressed: () async {
                  await _authService.signOut();
                },
                shape: CircleBorder(side: BorderSide(style: BorderStyle.solid)),
                child: url == null ? Icon(Icons.person) : Image.network(url),
                clipBehavior: Clip.antiAlias,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.brown,
                  size: 40,
                ),
                onPressed: () => _showSettingPanel()),
          ],
        ),
        body: Container(
          child: BrewList(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
