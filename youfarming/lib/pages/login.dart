
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class Login2 extends StatefulWidget {
  @override
  _LoginState2 createState() => _LoginState2();
}

class _LoginState2 extends State<Login2> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var passwordCheck = "";
  var message = "";
  var linkReg = "";

  void login(String email, String password) async {
    linkReg = "";
    try {
      var url = "https://www.site.com/login";
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');
        print(data);
        Navigator.pushNamed(context, '/dash', arguments: {
          'email': data['user']['email'],
          'lang': data['user']['lang'],
          'farm_type': data['user']['farming_type']
        });
        if (data['application_progress'] == 'not_complete' ||
            data['application_progress'] == 'being_processed' ||
            data['application_progress'] == 'rejected') {
          setState(() {
            message = 'Driver registration status: ${data['application_progress']}';
            linkReg = 'Go to registration';
          });
        } else if (data['application_progress'] == 'approved') {
          setState(() {
            passwordCheck = "";
            message = '';
            linkReg = '';
          });

        }
      } else if (response.statusCode == 201) {
        print('Password is incorrect');
        passwordController.clear();
        setState(() {
          passwordCheck = "Password is incorrect";
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        message = 'Failed to login';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                'assets/movisaTransparent.png',
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
            ),
            Container(
              width: 150,
              child: Text('Movisa Driver'),
            ),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(passwordCheck),
            Text(message),
            (linkReg == "Go to registration")
                ? GestureDetector(
              child: Text(
                linkReg,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
              onTap: () async {
                final url = 'https://www.google.com';
                await launchUrl(Uri.parse(url),
                    mode: LaunchMode.externalApplication);
              },
            )
                : Text(""),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('Login'),
                ),
              ),
            ),
            Text(""),
            Row(
              children: <Widget>[
                Spacer(),
                Container(
                  width: 160.0,
                  child: GestureDetector(
                    onTap: () {
                      passwordCheck = "";
                      message = '';
                      linkReg = '';
                      Navigator.pushNamed(context, '/reg');
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text('Register'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
