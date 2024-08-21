import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LessonSection {
  final int id;
  final String name;
  final String title;
  final String group;
  bool quizStarted = false;
  int questionIndex = 0;

  LessonSection({
    required this.id,
    required this.name,
    required this.title,
    required this.group,
  });
}

class LessonContent {
  final int id;
  final int sectionId;
  final String name;
  final String description;

  LessonContent({
    required this.id,
    required this.sectionId,
    required this.name,
    required this.description,
  });
}

class LessonQuestion {
  final int id;
  final int sectionId;
  final String date;
  final int orderNum;
  final String questionText;

  LessonQuestion({
    required this.id,
    required this.sectionId,
    required this.date,
    required this.orderNum,
    required this.questionText,
  });
}

class LessonAnswer {
  final int id;
  final int questionId;
  final String answerText;
  final int isCorrect;
  final String answerText2;
  final int isCorrect2;
  final String answerText3;
  final int isCorrect3;
  final String answerText4;
  final int isCorrect4;

  LessonAnswer({
    required this.id,
    required this.questionId,
    required this.answerText,
    required this.isCorrect,
    required this.answerText2,
    required this.isCorrect2,
    required this.answerText3,
    required this.isCorrect3,
    required this.answerText4,
    required this.isCorrect4,
  });
}

class LessonPage extends StatefulWidget {
  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  List<LessonSection> lessonSections = [];
  List<LessonContent> lessonContents = [];
  List<LessonQuestion> lessonQuestions = [];
  List<LessonAnswer> lessonAnswers = [];
  List<Map<String, dynamic>> _questions = [];
  List<String> groups = [];
  List<List<Map<String, dynamic>>> _total_questions = [];
  var total_questions_counter = 0;
  String apiresponse = '';
  var card_control = "null";
  var group_control = "null";
  // void _answerQuestion(bool isCorrect, LessonSection section) {
  //   if (isCorrect) {
  //     section.quizStarted = false; // Mark the quiz as completed
  //   }
  //
  //   if (section.questionIndex < _questions.length - 1) {
  //     setState(() {
  //       section.questionIndex++; // Move to the next question
  //     });
  //   }
  // }
  Map<int, int> scores = {};
  void _answerQuestion(bool isCorrect, LessonSection section) {
    if (isCorrect) {
      scores[section.id] = (scores[section.id] ?? 0) + 1;
    }

    if (section.questionIndex < _questions.length - 1) {
      setState(() {
        section.questionIndex++; // Move to the next question
      });
    } else {
      // Quiz completed, display the score
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Completed'),
            content: Column(
              children: <Widget>[
                Text('Your Score for ${section.title}: ${scores[section.id]}/${_questions.length}'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    setState(() {
                      section.quizStarted = false; // Reset quiz state
                      section.questionIndex = 0;
                    });
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  // Function to fetch and process data
  Future<void> fetchData() async {
    // Create a map containing the data to be sent in the request body
    final Map<String, dynamic> requestData = {
      'lang': "english"
      // Add other parameters if needed
    };

    // Convert the map to a JSON string
    final String requestBody = jsonEncode(requestData);
    final String apiUrl = 'https://www.site.com/get_edu_info';

    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody,
    );

    print("response.statusCode ${response.statusCode}");
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      Map<String, dynamic> listToMap(List<dynamic> list) {
        Map<String, dynamic> result = {};

        for (int i = 0; i < list.length; i++) {
          result['item_$i'] = list[i];
        }

        return result;
      }
      final _parsedData = json.decode(response.body);
      Map<String, dynamic> parsedData = listToMap(_parsedData);
      //print(_parsedData[0]['section']['id']);
      //final parsedData = json.decode(parseddata);
      print( "${ parsedData.runtimeType}" );
      for (var item in _parsedData) {
        var q_text = '';

        if( item["section"]["Lesson_S_Group"] == null){
          groups.add('null');
        }else{
          groups.add(item["section"]["Lesson_S_Group"]);
        }
        LessonSection section = LessonSection(
          id: item["section"]["Lesson_Section_Id"],
          name: item["section"]["Lesson_Section_Name"],
          title: item["section"]["Lesson_Section_Title"],
          group: item["section"]["Lesson_S_Group"].toString(),
        );
        lessonSections.add(section);

        List<LessonContent> contents = [];
        for (var contentItem in item["contents"]) {

          LessonContent content = LessonContent(
            id: contentItem["Lesson_C_Id"],
            sectionId: contentItem["Lesson_Section_id"],
            name: contentItem["Lesson_C_Name"],
            description: contentItem["Lesson_C_Desc"],
          );
          contents.add(content);
        }
        lessonContents.addAll(contents);

        List<LessonQuestion> questions = [];
        for (var questionItem in item["questions"]) {
          q_text = questionItem["questionText"];
          LessonQuestion question = LessonQuestion(
            id: questionItem["id"],
            sectionId: questionItem["lesson_sec_id"],
            date: questionItem["question_date"],
            orderNum: questionItem["order_num"],
            questionText: questionItem["questionText"],
          );
          questions.add(question);
        }
        lessonQuestions.addAll(questions);

        List<LessonAnswer> answers = [];
        for (var answerItem in item["answers"]) {
          LessonAnswer answer = LessonAnswer(
            id: answerItem["id"],
            questionId: answerItem["questionId"],
            answerText: answerItem["answerText"],
            isCorrect: answerItem["isCorrect"],
            answerText2: answerItem["answerText2"],
            isCorrect2: answerItem["isCorrect2"],
            answerText3: answerItem["answerText3"],
            isCorrect3: answerItem["isCorrect3"],
            answerText4: answerItem["answerText4"],
            isCorrect4: answerItem["isCorrect4"],
          );
          answers.add(answer);
        }
        lessonAnswers.addAll(answers);
        _questions = [];
        var count = 0;
        for(var answerItem in item["answers"]){
          _questions.add(
              {
                'questionText': item["questions"][count]['questionText'],
                'answers': [
                  {'text': answerItem["answerText"], 'isCorrect': answerItem["isCorrect"]},
                  {'text': answerItem["answerText2"], 'isCorrect': answerItem["isCorrect2"]},
                  {'text': answerItem["answerText3"], 'isCorrect': answerItem["isCorrect3"]},
                  {'text': answerItem["answerText4"], 'isCorrect': answerItem["isCorrect4"]},
                ],
              }
          );
          count++;
        };
        _total_questions.add(_questions);
      print("groups:");
      print(groups.toSet());

      }
      // return groups.toSet().toList();
      setState(() {
        groups = groups.toSet().toList();
      });
    } else {
      // Handle the case when the response status code is not 200
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();


    fetchData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Quiz'),
      ),
      body: Column(
        children: <Widget>[
      if(group_control == "null")...[
        Expanded(
          child: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (ctx, sectionIndex) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(groups[sectionIndex]),
                        onTap: (){
                          setState(() {
                            card_control = groups[sectionIndex];
                            group_control = groups[sectionIndex];
                          });
                        },
                      ),
                    ],
                  ),
                );
              }
          ),
        ),
      ],



          if(card_control != "null")...[
            // Row(
            //   children: [
            //
            //   ],
            // )
            Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Back"),
                    onTap: (){
                      setState(() {
                        group_control = "null";
                        card_control = "null";
                      });
                    },
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(card_control),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: lessonSections.length,
                itemBuilder: (ctx, sectionIndex) {
                  final section = lessonSections[sectionIndex];
                  final contentList = lessonContents.where((content) => content.sectionId == section.id).toList();
                  final questionIndex = section.questionIndex;
                  var question = _total_questions[sectionIndex];

                  if(card_control == section.group ){
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(section.title),
                            subtitle: Text(section.name),
                          ),
                          Column(
                            children: contentList
                                .map(
                                  (content) => ListTile(
                                title: Text(content.name),
                                subtitle: Text(content.description),
                              ),
                            )
                                .toList(),
                          ),
                          if (section.quizStarted && questionIndex < question.length)
                            Quiz(
                              questionText: question[questionIndex]['questionText'],
                              answers: question[questionIndex]['answers'],
                              answerHandler: (isCorrect) {
                                _answerQuestion(isCorrect, section);
                              },
                            )
                          else if (questionIndex == question.length)
                            Text('Quiz Completed') // Show this when the quiz is completed
                          else
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  section.quizStarted = true;
                                  section.questionIndex = 0;
                                });
                              },
                              child: Text('Start Quiz'),
                            ),
                        ],
                      ),
                    );
                  }else{
                    return Text("");
                  }

                },
              ),
            ),
          ],

        ],
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final String questionText;
  final List<Map<String, dynamic>> answers;
  final Function(bool) answerHandler;

  Quiz({
    required this.questionText,
    required this.answers,
    required this.answerHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questionText),
        ...answers.map((answer) {
          return Answer(
            answer['text'],
                () => answerHandler(answer['isCorrect'] == 1),
          );
        }).toList(),
      ],
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final String answerText;
  final Function() selectHandler;

  Answer(this.answerText, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}
