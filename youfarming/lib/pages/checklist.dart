import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


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
    final endOfWeek = startOfWeek.add(Duration(days: 6));

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

class ParentPage extends StatefulWidget {
  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  DateTime? current_date;
  final GlobalKey<ChildPageState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    current_date = DateTime.now();
    print("current_date");
    print(current_date);
  }

  Future<List<Task>> _fetchTasksForCurrentWeek() async {
    return TaskService.fetchTasksForCurrentWeek();
  }

  void methodInParent() {
    Fluttertoast.showToast(msg: "Method called in parent", gravity: ToastGravity.CENTER);
  }

  void reloadChildPage(DateTime date) {

    setState(() {
      current_date = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parent")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Task>>(
                future: _fetchTasksForCurrentWeek(),
                builder: (context, snapshot) {
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
                    final tasks = snapshot.data!;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(""),
                                Text(""),
                                Text('${tasks[0].month}  ${tasks[0].date.year}'),
                                Text(""),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (var c = 0; c < tasks.length; c++) ...[
                                      // Change color for picked day
                                      if(DateFormat('yyyy-MM-dd').format( current_date!) == DateFormat('yyyy-MM-dd').format( tasks[c].date))...[
                                        GestureDetector(
                                          onTap: () => reloadChildPage(tasks[c].date),

                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.15,
                                            width: MediaQuery.of(context).size.width * 0.13,
                                            padding: EdgeInsets.fromLTRB(0,15.0,0,5.0),
                                            margin: EdgeInsets.all(2.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                              border: Border.all(
                                                color: Colors.black45, // Set the border color here
                                                width: 2, // Set the border width
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Text('${DateFormat.E().format(tasks[c].date)}'),
                                                Text('${tasks[c].date.day}'),

                                              ],
                                            ),
                                          ),
                                        )
                                      ]else...[
                                        GestureDetector(
                                          onTap: () => reloadChildPage(tasks[c].date),

                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.15,
                                            width: MediaQuery.of(context).size.width * 0.13,
                                            padding: EdgeInsets.fromLTRB(0,15.0,0,5.0),
                                            margin: EdgeInsets.all(2.0),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.all(Radius.circular(15)),

                                            ),
                                            child: Column(
                                              children: [
                                                Text('${DateFormat.E().format(tasks[c].date)}'),
                                                Text('${tasks[c].date.day}'),

                                              ],
                                            ),
                                          ),
                                        )
                                      ],

                                    ]
                                  ],
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width * 0.90, // Adjust the width as needed
                                  child: Divider(
                                    color: Colors.black45, // Set the color of the line
                                    thickness: 3, // Set the thickness of the line
                                  ),
                                ),

                                Text(""),
                              ],
                            )
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
              ChildPage(
                key: _key,
                function: methodInParent,
                current_date: current_date,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildPage extends StatefulWidget {
  final VoidCallback function;
  final DateTime? current_date;

  ChildPage({Key? key, required this.function, this.current_date}) : super(key: key);

  @override
  ChildPageState createState() => ChildPageState();
}

class ChildPageState extends State<ChildPage> {
  List<String> event_09 = [];
  List<String> current_days_checklist = [];
  List<Widget> stuff2 = [];

  List<String> headings_items = [];
  String date22 = '';
  List<String> g_tasks = [];
  List<int> tasks_length = [];
  List<bool> ischecked_values = [];

  int _index_heading = 0;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    getEventOfDate2();
  }

  @override
  void didUpdateWidget(covariant ChildPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.current_date != oldWidget.current_date) {
      getEventOfDate2();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          ListView.builder(
            shrinkWrap: true, // Add shrinkWrap property
            physics: NeverScrollableScrollPhysics(), // Add physics property
            itemCount: g_tasks!.length,
            itemBuilder: (context, index) {
              var heading = '';
              // if(index == tasks_length[(counting - 1)]){
              //   heading = headings_items[counting - 1];
              //   counting = 0;
              // }
              bool indicator = true;
              bool indicator_end = false;
              // print(tasks_length[_index]);
              if(index == 0){
                heading = headings_items[_index_heading];
                _index_heading++;
                indicator_end = false;
              }else if(index == tasks_length[_index]){
                heading = headings_items[_index_heading];
                _index_heading++;
                _index++;
                indicator_end = false;
              }else if(index == tasks_length[_index]-1){
                indicator_end = true;
              }else{
                indicator = true;
                indicator_end = false;
              }

              return Container(
                margin: EdgeInsets.fromLTRB(15,0,8,0), // Apply 16 pixels margin to all sides
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    if(indicator)...[
                      Text("${heading}"),
                      Text(""),
                      Text(""),
                    ],
                    Container(
                      margin: EdgeInsets.fromLTRB(5,0,5,0), // Apply 16 pixels margin to all sides
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: Text("${g_tasks[index]}"),
                          ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.15,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(8), // Adjust the border radius as needed
                          //     border: Border.all(color: Colors.grey), // Add a border for the checkbox
                          //   ),
                          //   child: Checkbox(
                          //     value: ischecked_values[index],
                          //     onChanged: (bool? value) {
                          //       _index_heading = 0;
                          //       _index = 0;
                          //       setState(
                          //             () {
                          //           ischecked_values[index] = value!;
                          //         },
                          //       );
                          //     },
                          //
                          //   ),
                          // ),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Checkbox(
                              value: ischecked_values.isNotEmpty && index < ischecked_values.length
                                  ? ischecked_values[index]
                                  : false,
                              onChanged: (bool? value) {
                                _index_heading = 0;
                                _index = 0;
                                setState(() {
                                  if (ischecked_values.isNotEmpty && index < ischecked_values.length) {
                                    ischecked_values[index] = value!;
                                  }
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                    ),


                    if(indicator_end)...[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70, // Adjust the width as needed
                        child: Divider(
                          color: Colors.black45, // Set the color of the line
                          thickness: 1, // Set the thickness of the line
                        ),
                      ),
                      Text(""),
                    ],
                    ///
                  ],
                ),
              );

            },
          ),


          //   Text("!!!!!!!!!!!!!!!"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    update_is_checked_locally();
                  },
                  child: Text('to sync'),
                ),
              ),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/checklist_dashboard',);
                  },
                  child: Text('Back to dashboard'),
                ),
              )

            ],
          ),

        ],
      ),

      ///
    );
  }

  Future<List<String>> getEventOfDate2() async {
    _index_heading = 0;
    _index = 0;

    headings_items = [];
    date22 = '';
    g_tasks = [];
    tasks_length = [];
    ischecked_values = [];
    String TASK = await get_edu_https();
    var Tasks_list = await jsonDecode(TASK);
    print("TASK: ${Tasks_list}");

    List<String> updatedEventing = [];
    for (var c = 0; c < TASK.length; c++) {
      // if (TASK[c].date.toLocal().toString().split(' ')[0] ==
      //     widget.current_date!.toLocal().toString().split(' ')[0]) {
      //   updatedEventing.add(DateFormat('yyyy-MM-dd').format( widget.current_date!));
      // }
    }
    /// find build the list needed
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    // String? full_checklist = await pref.getString('full_checklist');
    //
    // List<dynamic> checklist_example = [];
    // checklist_example = await jsonDecode(full_checklist!);
    //
    // String formattedDate = DateFormat('yyyy-MM-dd').format( widget.current_date!);
    // current_days_checklist = [];

    // Create current days list
    // for (var i = 0; i < checklist_example.length; i++) {
    //   if (checklist_example[i].contains(formattedDate)) {
    //     // print("i:${i}");
    //     current_days_checklist.add(checklist_example[i]);
    //   }
    // }

    // Set global varibles

    List<String> heading_item = [];
    String date2 = '';
    List<String> tasks = [];
    ischecked_values = [];
    int count_tasks_break = 0;
    // organise list. morning afternoon evening
    var order = ["morning","afternoon", "evening"];
    var morning = [];
    var afternoon= [];
    var evening = [];
    for(var x = 0; x < Tasks_list.length; x++) {
      morning.add(Tasks_list[x]);
      if(Tasks_list[x][0].toLowerCase().contains("morning")){
        morning.add(Tasks_list[x]);
      }else if(Tasks_list[x][0].toLowerCase().contains("afternoon")){
        afternoon.add(Tasks_list[x]);
      }else if(Tasks_list[x][0].toLowerCase().contains("evening")){
        evening.add(Tasks_list[x]);
      }

    }

    var ordered = [];
    ordered.add(morning);
    ordered.add(afternoon);
    ordered.add(evening);
    Tasks_list = ordered;

    print("taskData = ${Tasks_list}");
    for (var y = 0; y < Tasks_list.length; y++) {
      for(var index = 0; index < Tasks_list[y].length; index++) {
        List<dynamic> taskData = Tasks_list[y][index];

        print("taskData = ${taskData}");
        for (int x = 0; x < taskData.length; x++) {
          if (x == 0) {
            headings_items.add("${taskData[x]}");
            date2 = taskData[x];
          } else if (taskData[x].contains('isChecked')) {
            // print("taskData[x].substring(11, taskData[x].length) ${taskData[x].substring(11, taskData[x].length)}");
            if (taskData[x].substring(11, taskData[x].length).replaceAll(' ', '') == 'true') {
              ischecked_values.add(true);
            } else if (taskData[x].substring(11, taskData[x].length).replaceAll(' ', '') == 'false') {
              // print("2 taskData[x].substring(11, taskData[x].length) ${taskData[x].substring(11, taskData[x].length)}");
              ischecked_values.add(false);
            } else {
              print(taskData[x].substring(12, taskData[x].length));
            }
          } else if (x == taskData.length - 1) {
            // do nothing at the end
          } else {
            count_tasks_break++;
            tasks.add("${taskData[x]}");
          }
        }

      }

      date22 = date2;
      tasks_length.add(tasks.length);

      count_tasks_break = 0;
      date2 = '';
    }
    // print(headings_items);
    // print(tasks_length);
    //print(widget.current_date!);
    setState(() {
      headings_items;
      ischecked_values;
      g_tasks = tasks;
      date22;
      tasks_length;
      event_09 = updatedEventing;
    });
    setState(() {
      event_09 = updatedEventing;
    });

    return updatedEventing;
  }

  ///
  Future<void> update_is_checked_locally() async {
    _index_heading = 0;
    _index = 0;

    String Date = '';
    int count_ischecked = 0;
    /// loop through all the checkboxes ischecked global var and assign them to curent days checklist

    /// then update current days checklist into fulldb checklist
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? full_checklist = await pref.getString('full_checklist');

    List<dynamic> checklist_example = [];
    checklist_example = await jsonDecode(full_checklist!);

    String formattedDate = DateFormat('yyyy-MM-dd').format( widget.current_date!);
    current_days_checklist = [];
    for (var i = 0; i < checklist_example.length; i++) {
      if (checklist_example[i].contains(formattedDate)) {
        // print("i:${i}");
        current_days_checklist.add(checklist_example[i]);
      }
    }
    //print(current_days_checklist.length);
    for (var i = 0; i < current_days_checklist.length; i++) {
      //print(current_days_checklist[i]);
      List<dynamic> taskData = current_days_checklist[i].split(', ');

      for (int x = 0; x < taskData.length; x++) {
        if (x == 0) {
        } else if (taskData[x].contains('isChecked')) {
          taskData[x] = "'isChecked': ${ischecked_values[count_ischecked].toString()}";
          count_ischecked++;

        } else if (x == taskData.length - 1) {
          // do nothing at the end
        } else if (x == 1) {
        } else {
        }
      }
      String day_checklist = jsonEncode(taskData);
      current_days_checklist[i] = day_checklist;
      // print(current_days_checklist[i]);
    }
    int count_current_day_index = 0;
    for (var y = 0; y < checklist_example.length; y++) {
      if (checklist_example[y].contains(formattedDate)) {
        //print(y);
        //print(checklist_example[y]);
        // print("vs");
        String new_holder = jsonDecode(current_days_checklist[count_current_day_index]).toString();
        var length = new_holder.length;
        //print(new_holder.substring(1, length - 1));
        checklist_example[y] = new_holder.substring(1, length - 1);
        //current_days_checklist.add(checklist_example[count_current_day_index]);
        count_current_day_index++;
        //print(checklist_example[y]);
      }
    }

    String serialized_full_checklist = await jsonEncode(checklist_example);
    await pref.setString('full_checklist', serialized_full_checklist);
    setState(() {
      print("done");
    });

  }


  // ACCOUNT SIMULATION get all assigned tasks for manager checlist assign display
  Future<String> get_edu_https() async {
    var items_list = [];

    // // Get the current date
    // DateTime currentDate = DateTime.now();
    //
    // // Format the date
    // String formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(widget.current_date!);

    DateTime currentDate = widget.current_date!;

    // Set hours, minutes, seconds, and milliseconds to 0
    DateTime adjustedDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      0,
      0,
      0,
      0,
    );

    // Format the adjusted date
    String formattedDate = DateFormat("yyyy-MM-dd'T'00:00:00.000'Z'").format(adjustedDate);


    var url = "https://www.site.com/get_schedule_task_app";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        //get the drivers working location and get all orders from the drivers province
        'id': '1',
        'date': formattedDate,
      }),
    );
    print("response.statusCode ${response.statusCode}");
    if(response.statusCode == 200){
      print("the token was set successfully");
      print(response);
      var data = jsonDecode(response.body);
      print("error in getting order id");
      var data2 = data['day_tasks'].toString().split("item_d_start,");
      print("lenght: ${data['day_tasks'].length}");
      var place_holder = [];
      for(var x = 0 ;x <= data['day_tasks'].length-1; x++){
        print("data['day_tasks']: ${data['day_tasks'][x]}");
        if(x == 0 || data['day_tasks'][x] == ''){

        }else if(data['day_tasks'][x] == 'item_d_start' ){
          items_list.add(place_holder);
          place_holder = [];
        }else if(data['day_tasks'][x].contains('isChecked:') ) {
          print("place_holder.length ${place_holder.length}");
          // if(place_holder.length == 0){
          //  // place_holder[0] = data['day_tasks'][x];
          //   place_holder.add(data['day_tasks'][x]);
          // }else
          place_holder.add(data['day_tasks'][x]);
          if (x == data['day_tasks'].length - 1) {
            items_list.add(place_holder);
            place_holder = [];
          }
        }else{
          //   place_holder.add(data['day_tasks'][x]);
          // }
          place_holder.add(data['day_tasks'][x]);
          if (x == data['day_tasks'].length - 1) {
            items_list.add(place_holder);
            place_holder = [];
          }
          //place_holder.add(data['day_tasks'][x]);
        }
        print("items_list ${items_list}");
      }
      print("place_holder ${place_holder}");
      print("items_list ${items_list}");
      print(data2);

    }


    String serialized_assigned_to_all = await jsonEncode(items_list);
    return serialized_assigned_to_all;

  }

}





