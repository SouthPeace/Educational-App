import 'package:flutter/material.dart';
import 'package:youfarming/data/homedata.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Portfolio_Gen extends StatefulWidget {
  @override
  _Portfolio_Gen createState() => _Portfolio_Gen();
}

class _Portfolio_Gen extends State<Portfolio_Gen> {
  double gPercent = 0;
  List<Widget> widgets = [];
  Future<List<Widget>>? businessInformationFuture;

  @override
  void initState() {
    super.initState();
    businessInformationFuture = getBusinessInformationLength();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate '),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/_portfolio_description',
                );
              },
              child: Text(
                'generate',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<Widget>>(
              future: businessInformationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final items = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: items,
                  );
                } else {
                  return Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Widget>> getBusinessInformationLength() async {
    widgets = [];
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? businessQInput2 = await readFromSharedPreferences();

    var businessPortfolioServer = await jsonDecode(businessQInput2!);

    for (var r = 0; r < businessPortfolioServer.length; r++) {
      widgets.add(
        Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${businessPortfolioServer[r][0].split(",")[0]}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: gPercent,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/_form_gen',
                      arguments: businessPortfolioServer[r],
                    );
                  },
                  child: Text(
                    '${businessPortfolioServer[r][0].split(",")[0]} Guide',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    setState(() {});
    return widgets;
  }

  Future<String> readFromSharedPreferences() async {
    final pref = await SharedPreferences.getInstance();
    // String? business_q_input2 = await pref.getString('business_information_qs_answers2');
    //
    // if (business_q_input2 != null) {
    //   print('Value from shared preferences: $business_q_input2');
    //   return business_q_input2;
    // } else {
    //   print('Value not found in shared preferences');
    //   await get_portfolio_https();
    //   setState(() {});
    //   var data = await get_portfolio_https();
    //   String? business_q_input2 = await pref.getString('business_information_qs_answers2');
    //   return business_q_input2!;
    // }
/////////////////////////////
    print('Value not found in shared preferences');
    await get_portfolio_https();
    setState(() {});
    var data = await get_portfolio_https();
    String? business_q_input2 = await pref.getString('business_information_qs_answers2');
    return business_q_input2!;
  }
}
