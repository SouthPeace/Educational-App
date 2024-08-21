import 'package:flutter/material.dart';
import 'package:youfarming/data/homedata.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PortfolioDescription extends StatefulWidget {
  @override
  _PortfolioDescriptionState createState() => _PortfolioDescriptionState();
}

class _PortfolioDescriptionState extends State<PortfolioDescription> {
  double gPercent = 0;
  var gInformationList = [];
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    getBusinessInformationLength();
  }

  @override
  Widget build(BuildContext context) {
    gInformationList = ModalRoute.of(context)?.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio Description'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  // Get business information list of answers
  Future<void> getBusinessInformationLength() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // Check if information has been set to shared preferences
    String? businessQInput2 = await readFromSharedPreferences();

    var businessPortfolioServer = await gInformationList;
    print("LENGTH ${businessPortfolioServer.length}");
    for (var r = 0; r < businessPortfolioServer.length; r++) {
      var info = businessPortfolioServer[r].split(",");
      print("type ${info[2]}");

      List<Widget> contentWidgets = [];
      var x = info.length - 2;
      for (var i = 0; i < info.length-2; i++) {
        if (i == x && info[i] == 'Text') {
          contentWidgets.add(
            Text(
              'Input: ${info[i]}',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          contentWidgets.add(
            Text(
              '${info[i]}',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
      }

      widgets.add(
        ExpandableCard(
          title: '${info[0]}Item $r',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: contentWidgets,
          ),
        ),
      );
    }
    setState(() {});
  }

  // Check if shared preferences exists
  Future<String> readFromSharedPreferences() async {
    final pref = await SharedPreferences.getInstance();
    String? businessQInput2 = await pref.getString('business_information_qs_answers2');

    if (businessQInput2 != null) {
      // The value exists in shared preferences
      print('Value from shared preferences: $businessQInput2');
      return businessQInput2;
    } else {
      // The value does not exist in shared preferences
      print('Value not found in shared preferences');
      await get_portfolio_https();
      setState(() {});
      var data = await get_portfolio_https();
      String? businessQInput2 = await pref.getString('business_information_qs_answers2');
      return businessQInput2!;
    }
  }
}

class ExpandableCard extends StatefulWidget {
  final String title;
  final Widget content;

  ExpandableCard({required this.title, required this.content});

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget.content,
            ),
          ],
        ],
      ),
    );
  }
}
