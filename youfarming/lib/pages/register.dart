import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class register extends StatefulWidget {
  @override
  _register createState() => _register();
}

class _register extends State<register> {
  String _selectedLanguage = 'English';
  String _selectedFarmingType = 'Chicken farming for meat';

  final List<String> _languages = ['English', 'Xhosa', 'Afrikaans'];
  final List<String> _farmingTypes = [
    'Chicken farming for meat',
    'Chicken farming for eggs',
    'Pig farming'
  ];

  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();

  Future<String>? _futureAlbum;

  Future<String> _createAlbum(String username, String email, String firstName, String lastName, String language, String farmingType, String password) async {
    try {
      var url = "https://www.site.com/flutter_driver_reg";
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'lang': language,
          'farming_type': farmingType,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return 'registered';
      } else if (response.statusCode == 202) {
        return 'username_exists';
      } else {
        throw Exception('Failed to register user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to register user. Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _controllerUsername,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _controllerEmail,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _controllerFirstName,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _controllerLastName,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              items: _languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'Select Language'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedFarmingType,
              items: _farmingTypes.map((farmingType) {
                return DropdownMenuItem<String>(
                  value: farmingType,
                  child: Text(farmingType),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedFarmingType = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'Select Farming Type'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                if (_controllerUsername.text.isEmpty ||
                    _controllerEmail.text.isEmpty ||
                    _controllerFirstName.text.isEmpty ||
                    _controllerLastName.text.isEmpty ||
                    _controllerPassword.text.isEmpty) {
                  // Handle empty fields
                  return;
                }else{

                  _futureAlbum =  _createAlbum(
                    _controllerUsername.text,
                    _controllerEmail.text,
                    _controllerFirstName.text,
                    _controllerLastName.text,
                    _selectedLanguage,
                    _selectedFarmingType,
                    _controllerPassword.text,
                  );

                  String result = await _futureAlbum!;

                  if (result == 'registered') {
                    print('User registered successfully');
                    Navigator.pushNamed(context, '/login');
                  } else if (result == 'username_exists') {
                    print('Username already exists');
                  }
                }

              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
