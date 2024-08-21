import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../pages/homedash.dart';

class RoundedExpansionTile extends StatefulWidget {
  final Widget title;

  RoundedExpansionTile(this.title);

  @override
  _RoundedExpansionTileState createState() => _RoundedExpansionTileState();
}

class _RoundedExpansionTileState extends State<RoundedExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("titles count"),
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          child: Text('${widget.title}'),
        ),
      ],
    );
  }
}

class CardStack extends StatefulWidget {
  final List<dynamic> dataItems;

  CardStack({required this.dataItems});

  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  int numberOfCards = 0;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _buildCards(widget.dataItems),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: snapshot.data as List<Widget>,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<List<Widget>> _buildCards(List<dynamic> items) async {
    List<Widget> cards = [];
    for (var x = 0; x < items.length; x++) {
      Color color = _generateRandomColor(x);
      cards.add(
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: RoundedExpansionTile(
            Text("${items[x]}"),
          ),
        ),
      );

      if(x == items.length - 1){
        cards.add(
          ElevatedButton(onPressed: () {
            TriggerSetGuide(1, widget.dataItems[0][0]["p_stage_id"]);
          },
              child: Text("start program stage: ${widget.dataItems[0][0]["p_stage_id"]}")
          ),
        );
      }
    }
    return cards;
  }

  Future<void> TriggerSetGuide(int user_id, int p_stage_id) async {
    // Create a map containing the data to be sent in the request body
    final Map<String, dynamic> requestData = {
      'id': user_id,
      'p_stage_id': p_stage_id
      // Add other parameters if needed
    };

    // Convert the map to a JSON string
    final String requestBody = jsonEncode(requestData);
    final String apiUrl = 'https://www.site.com/set_up_user_guide';

    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody,
    );

    // Handle the response
    if (response.statusCode == 200) {
      print('Request successful! Response: ${response.body}');

      // go to the home page
      Navigator.popAndPushNamed(
        context,
        "/home",

      );
      Navigator.pushNamed(
        context,
        '/home',);

    } else {
      print('Request failed with status: ${response.statusCode}');
    }



  }

  Color _generateRandomColor(int index) {
    List<Color> colors = [Colors.red, Colors.blue, Colors.orange];
    return colors[index % colors.length];
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: CardStack(),
//   ));
// }
