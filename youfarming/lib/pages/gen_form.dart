import 'package:flutter/material.dart';
import 'package:youfarming/data/homedata.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';


class GenerateForm extends StatefulWidget {
  @override
  _GenerateFormState createState() => _GenerateFormState();
}

class _GenerateFormState extends State<GenerateForm> {
  double gPercent = 0;
  var gInformationList = [];
  List<Widget> widgets = [];
  List<TextEditingController> textControllers = [];
  var type = '';

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
        title: Text('GENERATE form'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Progression indicator for business admin
            Center(
              child: Column(
                children: widgets,
              ),
            ),
            ///#################

            // Text input field
            if (gInformationList.isNotEmpty && gInformationList[0] == 'Text')
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widgets.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: textControllers[index],
                        decoration: InputDecoration(
                          labelText: 'Enter Text',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                  },
                ),
              ),

            // Button to display info of each card and text fields content
            ElevatedButton(
              onPressed: () async {
                // Display info of each card and text fields content
                print("for: $type");
                print(gInformationList);
                print(textControllers);

                List<List<String>> q_a = [];
                for(var x = 0; x < widgets.length; x++ ){
                  var info = gInformationList[x].split(",");
                  if( info[2] == "Text"){
                    q_a.add( ["${info[1]}", "${textControllers[x].text}"] );
                  }
                }

                print("for: $type");
                var response = await fetchDocumentFromEndpoint(type, "farming chicken for meat", "KwaZulu-Natal Department of Agriculture and Rural Development (KZN DARD).", q_a);
                // Check response and generate PDF

              },
              child: Text('Show Info of Each Card'),
            ),
          ],
        ),
      ),
    );
  }


  Future fetchDocumentFromEndpoint(String type, String farmType, String region, List<List<String>> questionsAnswers) async {
    // Define the endpoint URL
    String endpointUrl = 'https://farm-starts.onrender.com/openaitest';

    try {
      // Make the POST request to the endpoint
      var response = await http.post(
        Uri.parse(endpointUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'for_doc': type,
          'farm_type': farmType,
          'province': region,
          'q_a': questionsAnswers,
        }),
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response JSON
        print(jsonDecode(response.body));
        var responseData = jsonDecode(response.body);
        // Print or handle the response data as needed
        print("response:::");
        print(responseData['messages']);

        String responseString = jsonDecode(responseData['messages']);
        print(responseString);
        // Pass the response string to the generatePDF function
        if (responseString != null) {
          generatePDF(context, responseString);
        }

      } else {
        // If the request was not successful, print the error status code
        print('Request failed with status: ${response.statusCode}');
        return {}; // Return an empty map
      }
    } catch (error) {
      // Handle any exceptions that occur during the request
      print('Request failed with error: $error');
      return {}; // Return an empty map
    }
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
      if(type == ''){
        type = info[0];
      }
      List<Widget> contentWidgets = [];
      var x = info.length - 2;
      for (var i = 1; i < info.length; i++) {
        if (i == x && info[i] == 'Text') {
          contentWidgets.add(
            Text(
              '${info[1]}',
              style: TextStyle(fontSize: 20),
            ),
          );

          textControllers.add(TextEditingController());
          contentWidgets.add(
            TextField(
              controller: textControllers.last,
              decoration: InputDecoration(
                labelText: 'Enter Text',
                border: OutlineInputBorder(),
              ),
            ),
          );

          widgets.add(
            ExpandableCard(
              title: '${info[0]} Item $r',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: contentWidgets,
              ),
            ),
          );
        } else {
          // contentWidgets.add(
          //   Text(
          //     '${info[i]}',
          //     style: TextStyle(fontSize: 20),
          //   ),
          // );
        }
      }
    }
    setState(() {});
  }

  // void generatePDF(BuildContext context, Map<String, dynamic> chatGptResponse) async {
  //   final PdfDocument document = PdfDocument();
  //   final PdfPage page = document.pages.add();
  //   final PdfGraphics graphics = page.graphics;
  //   final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);
  //
  //   // Assuming chatGptResponse contains necessary data for PDF generation
  //   final String title = chatGptResponse['title'];
  //   final String farmName = chatGptResponse['farmName'];
  //   final Map<String, List<String>> logbookEntries = chatGptResponse['logbookEntries'];
  //
  //   // Building content
  //   graphics.drawString(
  //     '$title\n\n',
  //     font,
  //     bounds: Rect.fromLTWH(0, 0, 400, 100),
  //   );
  //
  //   graphics.drawString(
  //     'Prepared for: $farmName\n\n',
  //     font,
  //     bounds: Rect.fromLTWH(0, 20, 400, 100),
  //   );
  //
  //   // Add sections for each logbook entry
  //   logbookEntries.forEach((sectionTitle, entries) {
  //     graphics.drawString(
  //       '$sectionTitle\n\n',
  //       font,
  //       bounds: Rect.fromLTWH(0, 40, 400, 100),
  //     );
  //
  //     entries.forEach((entry) {
  //       graphics.drawString(
  //         '- $entry\n',
  //         font,
  //         bounds: Rect.fromLTWH(0, 60, 400, 100),
  //       );
  //     });
  //
  //     graphics.drawString(
  //       'Why It Matters:\n',
  //       font,
  //       bounds: Rect.fromLTWH(0, 80, 400, 100),
  //     );
  //
  //     // Add reasons why each section matters (assuming fixed content)
  //     switch (sectionTitle) {
  //       case 'Health and Disease Management':
  //         graphics.drawString(
  //           'Regularly monitoring health-related data allows you to respond promptly to any disease outbreaks and assess the effectiveness of your health plan.\n\n',
  //           font,
  //           bounds: Rect.fromLTWH(0, 100, 400, 100),
  //         );
  //         break;
  //       case 'Feed and Nutrition':
  //         graphics.drawString(
  //           'Efficient feed utilization impacts overall production costs and chicken performance.\n\n',
  //           font,
  //           bounds: Rect.fromLTWH(0, 150, 400, 100),
  //         );
  //         break;
  //     // Add cases for other sections as needed
  //       default:
  //         break;
  //     }
  //   });
  //
  //   // Save document
  //   final directory = await getTemporaryDirectory();
  //   final filePath = '${directory.path}/generated_document.pdf';
  //   final File file = File(filePath); // Initialize the File class
  //   await file.writeAsBytes(await document.save()); // Await the save operation
  //   document.dispose();
  //
  //   // Open PDF viewer
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ViewDocumentPage(filePath: filePath)),
  //   );
  // }

  void generatePDF(BuildContext context, String chatGptResponse) async {
    // Split the response into sections based on '\n\n'
    List<String> sections = chatGptResponse.split('\n');

    // Create a new PDF document
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGraphics graphics = page.graphics;
    final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);

    // Define yOffset to manage the vertical position of text
    double yOffset = 0;

    // Iterate over sections and add them to the PDF
    for (String section in sections) {
      // Check if the section starts with a number (indicating a question)
      if (RegExp(r'^\d+\.').hasMatch(section)) {
        // Split the section into question and answer
        List<String> parts = section.split('\n');
        String question = parts[0]; // First line is the question
        String answer = parts.sublist(1).join('\n'); // Remaining lines are the answer

        // Add question to PDF
        graphics.drawString(
          '$question\n',
          font,
          bounds: Rect.fromLTWH(0, yOffset, 400, 100),
        );

        // Increment yOffset to move to the next section
        yOffset += 20; // Adjust as needed based on the spacing you want between sections

        // Add answer to PDF
        graphics.drawString(
          '$answer\n',
          font,
          bounds: Rect.fromLTWH(0, yOffset, 400, 100),
        );

        // Increment yOffset to move to the next section
        yOffset += 40; // Adjust as needed based on the spacing you want between sections
      } else {
        // Add regular section to PDF
        graphics.drawString(
          '$section\n',
          font,
          bounds: Rect.fromLTWH(0, yOffset, 400, 100),
        );

        // Increment yOffset to move to the next section
        yOffset += 20; // Adjust as needed based on the spacing you want between sections
      }
    }

    // Save the PDF document as bytes
    final List<int> bytes = await document.save();

    // Dispose the document
    document.dispose();

    // Encode the PDF bytes to base64
    final String base64String = base64Encode(bytes);

    // Now you can use the base64String as needed, for example, send it to an API

    // Example usage:
    // print('Base64 PDF: $base64String');

    // Display the PDF viewer (optional)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PDFViewerScreen(base64String: base64String)),
    );
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

class PDFViewerScreen extends StatelessWidget {
  final String base64String;

  PDFViewerScreen({required this.base64String});

  @override
  Widget build(BuildContext context) {
    // Decode the base64 string to bytes
    final Uint8List bytes = base64Decode(base64String);

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: SfPdfViewer.memory(
        bytes,
      ),
    );
  }
}