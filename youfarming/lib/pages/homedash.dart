import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:youfarming/pages/stage_info.dart';

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

//////////////////////////////
class Task {
  final String name;
  final DateTime date;
  final String month;

  Task({required this.name, required this.date, required this.month});
}

class TaskService {
  static Future<List<Task>> fetchTasksForCurrentWeek() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating API call delay

    final currentDate = DateTime.now();
    final startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday));
    final endOfWeek = startOfWeek.add(Duration(days: 7));

    List<Task> tasks = [];

    // Generate sample tasks for the current week
    for (int i = 0; i < 7; i++) {
      final taskDate = startOfWeek.add(Duration(days: i));
      final taskName = 'Task ${i + 1}';
      String currentMonth = DateFormat('MMMM').format(taskDate);

      tasks.add(Task(name: taskName, date: taskDate, month: currentMonth));
    }

    return tasks;
  }
}
//////////////////////////////

class _HomeDashboardState extends State<HomeDashboard> {
  double gPercent = 0;
  double gPercent2 = 0;

  @override
  void initState() {
    super.initState();
    countWeekTasksTillDate();
    getBusinessInformationLength();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Dashboard'),
        automaticallyImplyLeading: false,
      ),
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 375.0,
                      // decoration: BoxDecoration(
                      //   color: Colors.grey,
                      // ),
                    ),
                    Container(
                      height: 40.0,
                      width: 375.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF5C6B73),
                      ),
                    ),
                    Container(
                      height: 90.0,
                      width: 375.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(), backgroundColor: Color(0xFFFFFFFF)),
                            child: Container(
                              width: 50,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: Icon(Icons.map),
                            ),
                            onPressed: () {},
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(), backgroundColor: Color(0xFFFFFFFF)),
                            child: Container(
                              width: 50,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: Icon(Icons.people),
                            ),
                            onPressed: () {},
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(), backgroundColor: Color(0xFFFFFFFF)),
                            child: Container(
                              width: 50,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: Icon(Icons.info),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/_information');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<Map<String, dynamic>>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('No data available'));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildCarousel(context, 0, snapshot.data!),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),

            ///weekly progress
            FutureBuilder<Map<String, double>>(
              future: countWeekTasksTillDate(),
              builder: (BuildContext context, AsyncSnapshot<Map<String, double>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No tasks available for the current week.'),
                  );
                } else {
                  final event = snapshot.data!;
                  final List<String> keys = event.keys.toList();
                  /// create bar
                  List<Widget> barRowItems = [];
                  for(var x = 0; x < event.length; x++){
                    barRowItems.add(
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 150,
                                width: (MediaQuery.of(context).size.width / event.length) * 0.8,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: RotatedBox(
                                        quarterTurns: 3,
                                        child: LinearProgressIndicator(
                                          value: event[keys[x]],
                                          minHeight: 20,
                                          backgroundColor: Colors.grey[200],
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: (MediaQuery.of(context).size.width / event.length) * 0.8,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: RotatedBox(
                                        quarterTurns: 3,
                                        child: Column(
                                          children: [
                                            RotatedBox(
                                              quarterTurns: -3,
                                              child: Container(
                                                width: (MediaQuery.of(context).size.width / event.length) * 0.8,
                                                child: Text(
                                                  "${keys[x]}",
                                                  style: TextStyle(fontSize: 14),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  /// end of creating bar
                  return Column(
                    children: [
                      Center(
                        child: Text('Weekly Progress'),
                      ),

                      /// Progress Table graph
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: barRowItems,
                        ),
                      )

                    ],
                  );
                }
              },
            ),
            ///##############

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(18), // Apply 16 pixels of padding to all sides
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/MyApp',
                      );
                    },
                    child: Text('View Daily Checklist'),
                  ),
                )
              ],
            ),

            /// Column section for business admin
            /// Progression indicator for business admin
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          "Business Documents Profile Progress:",
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(18),
                      child: Text("%${gPercent2}"),
                    ),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/business_dashboard2',
                      );
                    },
                    child: Text('Business Information'),
                  ),
                )
              ],
            ),

            /// Quiz button
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          "Quiz: Placeholder for Quiz Information",
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(18),
                      child: Text("%${gPercent2}"),
                    ),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/QuizPage',
                      );
                    },
                    child: Text('Learn More, Quiz'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex, Map<String, dynamic> jsonData) {
    final List<dynamic> firstSet = jsonData['portfolio'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Carousel $carouselIndex'),
        SizedBox(
          height: 200.0,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.8),
            itemCount: firstSet.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(
                  context,
                  carouselIndex,
                  itemIndex,
                  firstSet[itemIndex][0][0],
                  firstSet[itemIndex]
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(
      BuildContext context, int carouselIndex, int itemIndex, Map<String, dynamic> data, List<dynamic> Set) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Item $itemIndex'),
              Text('p_stage_id: ${data["p_stage_id"]}'),
              Text('p_stage_name: ${data["p_stage_name"]}'),
              Text('farming_type: ${data["farming_type"]}'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardStack(
                          dataItems: Set,
                        ),
                      )
                  );
                },
                child: Text('Info ${data["p_stage_name"]}'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchData() async {
    final Map<String, dynamic> requestData = {
      'lang': "English",
      'farming_type': "chicken for meat",
    };

    final String requestBody = jsonEncode(requestData);
    final String apiUrl = 'https://www.site.com/get_schedule_information_app';

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data['portfolio'].length);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, double>> countWeekTasksTillDate() async {
    DateTime currentDate = DateTime.now();
    DateTime nextDay = currentDate.add(Duration(days: 1));
    String globalFormattedDate = DateFormat('yyyy-MM-dd').format(nextDay);

    List<Task> week = await TaskService.fetchTasksForCurrentWeek();

    List<String> titles = [];
    List<int> titlesDaysOverall = [];
    List<int> titlesDaysTrues = [];

    Future<void> countTasks(List<String> taskList) async {
      int counter = 0;
      for (String task in taskList) {
        List<dynamic> taskData = task.split(', ');
        String index1 = taskData[1];

        String date = taskData[0].substring(1);

        if (date.compareTo(globalFormattedDate) >= 0) {
          break;
        } else {
          for(var x = 0; x < week.length; x++){
            if(date == DateFormat('yyyy-MM-dd').format(week[x].date)){
              counter = counter + 1;

              if (titles.contains('${taskData[1]}')) {

              } else {
                titles.add('${taskData[1]}');
                titlesDaysOverall.add(0);
                titlesDaysTrues.add(0);
              }

              for (var g = 0; g < taskData.length; g++) {
                if (taskData[g] == "'isChecked': false") {
                  for (var t = 0; t < titles.length; t++) {
                    if (titles[t] == '${taskData[1]}') {
                      titlesDaysOverall[t] = titlesDaysOverall[t] + 1;
                    }
                  }
                } else if (taskData[g] == "'isChecked': true") {
                  for (var t = 0; t < titles.length; t++) {
                    if (titles[t] == '${taskData[1]}') {
                      titlesDaysOverall[t] = titlesDaysOverall[t] + 1;
                      titlesDaysTrues[t] = titlesDaysTrues[t] + 1;
                    }
                  }
                }
              }
            }
          }
        }
      }

      print("Object: ${counter}");
    }

    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? fullChecklist = await pref.getString('full_checklist');
    List<dynamic> listFullChecklist = jsonDecode(fullChecklist!);
    List<String> stringListListFullChecklist = listFullChecklist.map((item) => item.toString()).toList();
    countTasks(stringListListFullChecklist);

    print(titles);
    print(titlesDaysOverall);
    print(titlesDaysTrues);

    Map<String, double> percents = {};
    for(int x = 0; x < titlesDaysOverall.length; x++){
      double total = (titlesDaysTrues[x] / titlesDaysOverall[x]) * 1.0;
      percents["${titles[x]}"] = total;
    }

    print(percents);
    return percents;
  }

  Future<double> getBusinessInformationLength() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? businessQInput = await pref.getString('business_information_qs_answers');
    String? businessA = await pref.getString('business_information_answers');
    List<dynamic> LBusinessQInput = jsonDecode(businessQInput!);

    int questionsLength = 0;
    int counter = 1;

    print("LBusinessQInput: ${LBusinessQInput.length/2} ");
    List<dynamic> LBusinessA = jsonDecode(businessA!);

    print("LBusinessQInput: ${LBusinessA.length} ");
    int answerCounter = 0;
    LBusinessA.forEach((element) {
      String holding = element.toString().trim();
      if(holding == 'file_upload'){
        print("Object");
      } else if(holding == ''){
        print("Object1");
      } else{
        answerCounter++;
      }
      print("LBusinessA: ${element}");
    });
    print("AnswerCounter ${answerCounter}");
    double percent = (answerCounter / (LBusinessQInput.length/2)) * 1.0;
    print("Percentage: ${percent}");
    setState(() {
      gPercent2 = percent;
    });
    return percent;
  }
}


//
// {"categories":["All","null","nullz"],
// "itemsbycategory":{
//   "null":[
//     {"info_item_id":1,"info_item_sec_id":1,"info_item_name":"null_2023-10-11_17:35:57","info_item_image":"null","info_item_link":"null","info_item_desc1":"null","info_item_desc1_images":"null","info_item_desc1_link":"null","info_item_desc2":"null","info_item_desc2_images":"null","info_item_desc2_link":"null","info_item_desc3":"null","info_item_desc3_images":"null","info_item_desc3_link":"null","info_item_desc4":"null","info_item_desc4_images":"null","info_item_desc4_link":"null","info_item_desc5":"null","info_item_desc5_images":"null","info_item_desc5_link":"null","info_item_desc6":"null","info_item_desc6_images":"null","info_item_desc6_link":"null"},
// {"info_item_id":4,"info_item_sec_id":1,"info_item_name":"null2_2023-10-11_17:58:26","info_item_image":"null","info_item_link":"null","info_item_desc1":"null","info_item_desc1_images":"null","info_item_desc1_link":"null","info_item_desc2":"null","info_item_desc2_images":"null","info_item_desc2_link":"null","info_item_desc3":"null","info_item_desc3_images":"null","info_item_desc3_link":"null","info_item_desc4":"null","info_item_desc4_images":"null","info_item_desc4_link":"null","info_item_desc5":"null","info_item_desc5_images":"null","info_item_desc5_link":"null","info_item_desc6":"null","info_item_desc6_images":"null","info_item_desc6_link":"null"}],
// "nullz":[
//   {"info_item_id":5,"info_item_sec_id":2,"info_item_name":"null_2023-10-11_17:59:35","info_item_image":"nullxxx","info_item_link":"null","info_item_desc1":"null","info_item_desc1_images":"null","info_item_desc1_link":"null","info_item_desc2":"null","info_item_desc2_images":"null","info_item_desc2_link":"null","info_item_desc3":"null","info_item_desc3_images":"null","info_item_desc3_link":"null","info_item_desc4":"null","info_item_desc4_images":"null","info_item_desc4_link":"null","info_item_desc5":"null","info_item_desc5_images":"null","info_item_desc5_link":"null","info_item_desc6":"null","info_item_desc6_images":"null","info_item_desc6_link":"null"},
// {"info_item_id":6,"info_item_sec_id":2,"info_item_name":"null777_2023-10-11_18:23:04","info_item_image":"null","info_item_link":"null","info_item_desc1":"null","info_item_desc1_images":"null","info_item_desc1_link":"null","info_item_desc2":"null","info_item_desc2_images":"null","info_item_desc2_link":"null","info_item_desc3":"null","info_item_desc3_images":"null","info_item_desc3_link":"null","info_item_desc4":"null","info_item_desc4_images":"null","info_item_desc4_link":"null","info_item_desc5":"null","info_item_desc5_images":"null","info_item_desc5_link":"null","info_item_desc6":"null","info_item_desc6_images":"null","info_item_desc6_link":"null"}],
// "All":[
//   {"info_item_id":1,"info_item_sec_id":1,"info_item_name":"null_2023-10-11_17:35:57","info_item_image":"null","info_item_link":"null","info_item_desc1":"null","info_item_desc1_images":"null","info_item_desc1_link":"null","info_item_desc2":"null","info_item_desc2_images":"null","info_item_desc2_link":"null","info_item_desc3":"null","info_item_desc3_images":"null","info_item_desc3_link":"null","info_item_desc4":"null","info_item_desc4_images":"null","info_item_desc4_link":"null","info_item_desc5":"null","info_item_desc5_images":"null","info_item_desc5_link":"null","info_item_desc6":"null","info_item_desc6_images":"null","info_item_desc6_link":"null"},
// {"info_item_id":4,"info_item_sec_id":1,"info_item_name":"null2_2023-10-11_17:58:26","info_item_image":"null","info_item_link":"null","info_item_desc1":"null","info_item_desc1_images":"null","info_item_desc1_link":"null","info_item_desc2":"null","info_item_desc2_images":"null","info_item_desc2_link":"null","info_item_desc3":"null","info_item_desc3_images":"null","info_item_desc3_link":"null","info_item_desc4":"null","info_item_desc4_images":"null","info_item_desc4_link":"null","info_item_desc5":"null","info_item_desc5_images":"null","info_item_desc5_link":"null","info_item_desc6":"null","info_item_desc6_images":"null","info_item_desc6_link":"null"},
// {"info_item_id":5,"info_item_sec_id":2,"info_item_name":"null_2023-10-11_17:59:35","info_item_image":"nullxxx","info_item_link":"null","info_item_desc1":"null","info_item_desc1_images":"null","info_item_desc1_link":"null","info_item_desc2":"null","info_item_desc2_images":"null","info_item_desc2_link":"null","info_item_desc3":"null","info_item_desc3_images":"null","info_item_desc3_link":"null","info_item_desc4":"null","info_item_desc4_images":"null","info_item_desc4_link":"null","info_item_desc5":"null","info_item_desc5_images":"null","info_item_desc5_link":"null","info_item_desc6":"null","info_item_desc6_images":"null","info_item_desc6_link":"null"},
// {"info_item_id":6,"info_item_sec_id":2,"info_item_name":"null777_2023-10-11_18:23:04","info_item_image":"null","info_item_link":"null","info_item_desc1":"null","info_item_desc1_images":"null","info_item_desc1_link":"null","info_item_desc2":"null","info_item_desc2_images":"null","info_item_desc2_link":"null","info_item_desc3":"null","info_item_desc3_images":"null","info_item_desc3_link":"null","info_item_desc4":"null","info_item_desc4_images":"null","info_item_desc4_link":"null","info_item_desc5":"null","info_item_desc5_images":"null","info_item_desc5_link":"null","info_item_desc6":"null","info_item_desc6_images":"null","info_item_desc6_link":"null"}]}}