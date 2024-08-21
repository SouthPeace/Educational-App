import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
//////////////////////
// LOCATION
//////////////////////

// inside the get function we set the location details that will come from the database

Future<String> get_Onbaord_Location_Details() async {
  // set location details
  // NOTE: this represents one row pulled from the database
  Map<dynamic,String> location_details = {
    'FarmAddress': 'house number/street number,City/Town Name,Province',
    'FarmAdress_input':'text',
    'FarmContactName': 'farm contact name and sirname',
    'FarmContactName_input':'text',
    'exampleupload2': 'upload detail pdf2',
    'exampleupload_input':'file_upload',
    'FarmContactCellNo': 'farm contact cellphone number',
    'FarmContactCellNo_input':'text',
    'AplicantAddress': 'house number/street number,City/Town Name,Province',
    'AplicantAddress_input':'text',
    'ApplicantContactName': 'farm contact name and sirname',
    'ApplicantContactName_input':'text',
    'ApplicantContactCellNo': 'farm contact cellphone number',
    'ApplicantContactCellNo_input':'text',
    'exampleupload3': 'upload detail pdf',
    'exampleupload3_input':'file_upload',
    'ApplicantContactCellNo2': 'farm contact cellphone number',
    'ApplicantContactCellNo_input2':'text',
  };

  // serialize data from datafrom database
  String serialized_location_details = await jsonEncode(location_details);

  final SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('Location_details', serialized_location_details);

  return serialized_location_details;
}

// store onbaording answer submittions
Future<void> store_Onbaord_Location_Details(List<String> answers) async {
  List<String> Questions = [];
  // get the questions from the shared preference local storage
  final SharedPreferences pref = await SharedPreferences.getInstance();
  String? serialized_location_details = await pref.getString('Location_details');
  Map<String, dynamic> location_details = jsonDecode(serialized_location_details!);

  // for(var x = 0; x < location_details.length - 1; x++){
  //   if(x%2 == 0){
  //
  //   }else{
  //     Questions.add(location_details[x]!);
  //   }
  // }
  location_details.forEach((key, value) {
    if(value == 'text'|| value == 'file_upload'){

    }else{
      Questions.add(value);
    }
  });

  // then set serialize and set the quenstions and answers
  List<String> Q_And_Answers = [];

  for(var i = 0; i < answers.length - 1; i++){
    // add question first and then answer
    Q_And_Answers.add(Questions[i]);
    Q_And_Answers.add(answers[i]);
  }

  //print(Q_And_Answers);
  // set answerto local storage
  await pref.setString('location_q_answer', jsonEncode(Q_And_Answers));

}

// stage 2 onbaording messages/notices and imgaes ( convince )
Future<String> get_Onbaord_stage_Details() async {
  // set location details
  // NOTE: this represents one row pulled from the database
  Map<dynamic,String> equipment_details = {
    "Intro": "To raise chickens for meat, you will need the following equipment",
    "Intro_image":"",
    "1. Chicken Coop": "A secure and ventilated enclosure where chickens can live and roost. The size of the coop will depend on the number of chickens you plan to raise.",
    // "":"",
    "2. Feeder and Waterer": "Provide a constant supply of feed and fresh water to your chickens. Use feeders and waterers designed specifically for poultry to keep the feed clean and prevent spillage.",

    "3. Heat Source": "If you're raising chicks, you'll need a heat source like a heat lamp or a brooder to maintain the right temperature during their early weeks. As they grow, you can gradually reduce the heat.",

    "4. Brooder": "A separate area or container used to house newly hatched chicks until they are old enough to join the rest of the flock. It should be warm, draft-free, and well-lit.",

    "5. Bedding Material": "Use bedding material such as straw, wood shavings, or sawdust to provide a comfortable and absorbent surface for the chickens. Regularly clean and replace the bedding to maintain cleanliness.",

    "6. Nesting Boxes": "If you plan to breed or allow your chickens to lay eggs, provide nesting boxes filled with straw or shavings for them to lay their eggs. These boxes should be dark and secluded to encourage nesting behavior.",

    "7. Incubator (Optional)": "If you plan to hatch your own chicks, an incubator will be necessary to provide the right conditions for eggs to hatch. This is optional if you plan to purchase chicks or fully-grown birds.",

    "8. Slaughtering and Processing Equipment": "If you intend to process the chickens yourself, you'll need equipment such as a killing cone, scalder, plucker, and butcher knives to humanely slaughter, scald, and pluck the birds.",

    "9. Protective Gear": "When handling chickens, especially during processing, it's important to wear gloves, aprons, and other protective gear to maintain hygiene and prevent the spread of diseases.",

    "10. Fencing and Predator Protection": "Install sturdy fencing around the chicken coop to keep predators out. This can be wire mesh or electric fencing depending on the predators in your area. Consider measures like reinforced doors and secure latches to protect your chickens.",

    "11. Lighting System (Optional)": "If you're raising chickens indoors or in areas with limited natural light, you may need artificial lighting to simulate day and night cycles, ensuring optimal growth and egg production.",

  };

  // serialize data from datafrom database
  String serialized_equipment_details = await jsonEncode(equipment_details);

  // final SharedPreferences pref = await SharedPreferences.getInstance();
  // await pref.setString('Location_details', serialized_location_details);

  return serialized_equipment_details;
}

/////////////////////////////////////////////////
// daily check list
////////////////////////////////
Future<String> get_daily_checklist() async {
  List<String> routines = [];

  // morning rourine
  Map<dynamic,String> routine = {
    'title1': 'Morning Routine:',
    'to-do11': 'Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds.',
    'to-do21':'Inspect the ventilation system and adjust it if necessary to maintain proper airflow.',
    'to-do31':'Check the water supply and make sure all waterers are functioning correctly.',
    'to-do41':'Inspect the feeding system and ensure that feeders are clean and working properly.',
    'to-do51':'Conduct a visual inspection of the chickens, looking for any signs of illness or distress.',
    'interval1':'1',

    'title2':'Feeding and Watering:',
    'to-do12':'Provide fresh feed to the chickens according to their age and nutritional requirements.',
    'to-do22':'Monitor feed consumption and adjust the feed quantity if needed.',
    'to-do32':'Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times.',
    'to-do42':'Clean and refill waterers as needed to prevent contamination and spillage.',
    'interval2':'1',


    'title3':'Health Management:',
    'to-do13':'Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress.',
    'to-do23':'If any birds appear sick, separate them from the healthy ones and seek veterinary advice.',
    'to-do33':'Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases.',
    'to-do43':'Check for parasites like mites or lice and take appropriate measures for their control if necessary.',
    'interval3':'2',

    'title4':'Housing and Bedding:',
    'to-do14':'Ensure that the broiler house is clean and well-ventilated.',
    'to-do24':'Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled.',
    'to-do34':'Monitor the temperature inside the broiler house throughout the day and make adjustments as needed.',
    'interval4':'3',

    'title5':'Growth Monitoring:',
    'to-do15':'Weigh a representative sample of chickens regularly to track their growth progress.',
    'to-do25':'Keep records of the weights and growth rates to identify any issues or deviations.',
    'to-do35':'Adjust feed rations based on the growth rate and performance of the birds.',
    'interval5':'2',

    'title6':'Waste Management:',
    'to-do16':'Regularly clean the broiler house and remove accumulated manure.',
    'to-do26':'Dispose of the waste appropriately, following local regulations and guidelines.',
    'to-do36':'Monitor the ammonia levels in the house and take steps to maintain good air quality.',
    'interval6':'3',

    'title7':'Evening Routine:',
    'to-do17':'Conduct a final visual inspection of the chickens to ensure their well-being.',
    'to-do27':'Check the feed and water supply for any issues.',
    'to-do37':'Make sure the chickens have sufficient lighting and adjust it if necessary.',
    'to-do47':'Secure the broiler house against predators or potential risks.',
    'interval7':'1',
  };

  // serialize data from datafrom database
  String serialized_routines_details = await jsonEncode(routine);


  return serialized_routines_details;
}

Future<String> set_daily_checklist() async {
  //print('hh');
  List<String> routines = [];

  // morning rourine
  Map<dynamic,String> routine = {
    'title1': 'Morning Routine:',
    'to-do11': 'Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds.',
    'to-do21':'Inspect the ventilation system and adjust it if necessary to maintain proper airflow.',
    'to-do31':'Check the water supply and make sure all waterers are functioning correctly.',
    'to-do41':'Inspect the feeding system and ensure that feeders are clean and working properly.',
    'to-do51':'Conduct a visual inspection of the chickens, looking for any signs of illness or distress.',
    'interval1':'1',

    'title2':'Feeding and Watering:',
    'to-do12':'Provide fresh feed to the chickens according to their age and nutritional requirements.',
    'to-do22':'Monitor feed consumption and adjust the feed quantity if needed.',
    'to-do32':'Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times.',
    'to-do42':'Clean and refill waterers as needed to prevent contamination and spillage.',
    'interval2':'1',


    'title3':'Health Management:',
    'to-do13':'Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress.',
    'to-do23':'If any birds appear sick, separate them from the healthy ones and seek veterinary advice.',
    'to-do33':'Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases.',
    'to-do43':'Check for parasites like mites or lice and take appropriate measures for their control if necessary.',
    'interval3':'2',

    'title4':'Housing and Bedding:',
    'to-do14':'Ensure that the broiler house is clean and well-ventilated.',
    'to-do24':'Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled.',
    'to-do34':'Monitor the temperature inside the broiler house throughout the day and make adjustments as needed.',
    'interval4':'3',

    'title5':'Growth Monitoring:',
    'to-do15':'Weigh a representative sample of chickens regularly to track their growth progress.',
    'to-do25':'Keep records of the weights and growth rates to identify any issues or deviations.',
    'to-do35':'Adjust feed rations based on the growth rate and performance of the birds.',
    'interval5':'2',

    'title6':'Waste Management:',
    'to-do16':'Regularly clean the broiler house and remove accumulated manure.',
    'to-do26':'Dispose of the waste appropriately, following local regulations and guidelines.',
    'to-do36':'Monitor the ammonia levels in the house and take steps to maintain good air quality.',
    'interval6':'3',

    'title7':'Evening Routine:',
    'to-do17':'Conduct a final visual inspection of the chickens to ensure their well-being.',
    'to-do27':'Check the feed and water supply for any issues.',
    'to-do37':'Make sure the chickens have sufficient lighting and adjust it if necessary.',
    'to-do47':'Secure the broiler house against predators or potential risks.',
    'interval7':'1',
  };

  // serialize data from datafrom database
  String serialized_routines_details = await jsonEncode(routine);
  Map<String, dynamic> onbaording_data_ = jsonDecode(serialized_routines_details);
  int lenght_ofChecklist = onbaording_data_.values.length;
  List<String> listz = [];
  List<List<String>> lists = [];
  int counter = 0;

  onbaording_data_.entries.forEach((entry) {



    if(entry.key.contains("title")){


      //print(entry.key);
      listz.add(entry.value);

      counter = counter + 1;


    }else if(entry.key.substring(0,5) == "to-do"){
      counter = counter + 1;
      //list.add(entry.key);
      listz.add(entry.value);
      listz.add("'isChecked': false");

    }else if(entry.key.contains('interval')){

      listz.add(entry.value);
      lists.add(listz);
      listz=[];

    }
  });

  //print(lists);

  List<List<String>> list2 = lists;
  int list_length = list2.length;
  //print(list_length);
  List<List<String>> checklists = [];
  // loop through the next 2.5 months
  Future<List<List<String>>> loopThroughThreeMonths() async {
    DateTime startDate = DateTime.now();
    DateTime endDate = startDate.add(Duration(days: 50));
    int counter = 1;
    for (DateTime date = startDate; date.isBefore(endDate); date = date.add(Duration(days: 1))) {
      // Perform your operations for each day here
      //print('counter: $counter');
      // loop for everyday items
      for(var x = 0; x < list_length; x++ ){
        int len = list2[x].length - 1;
        String intervalStr = list2[x][len];
        //print(list2[x]);
        //try {
        int interval = int.parse(intervalStr);

        if ((counter % interval) == 0) {
          List<String> checklistItem = [];
          String formattedDate = DateFormat('yyyy-MM-dd').format(date);
          checklistItem.add(formattedDate);
          for(var i = 0; i < list2[x].length; i++){
            checklistItem.add(list2[x][i]);
          }
          checklists.add(checklistItem);
          //print(checklistItem[0]);
        }
        // } catch (e) {
        //   print('Invalid interval value: $intervalStr');
        // }

      }
      counter ++;
    }
    // print(lists);
    // print('---');
    // print(list2);
    // print('---');
    // print(checklists.length);
    //debugPrint('$checklists');
    for(var y = 0; y < checklists.length; y++){
      print(checklists[y]);
    }
    return checklists;
  }

  // example
// [Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]
  loopThroughThreeMonths();


  return serialized_routines_details;
}

// the data of the checklist items
Future<void> example_full_checklist() async {
  List<String> checklist_example = [
    "[2023-06-22, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-22, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-22, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-23, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-23, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-23, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-06-23, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-06-23, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-24, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-24, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-24, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-06-24, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-06-24, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-25, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-25, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-25, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-06-25, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-06-25, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-26, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-26, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-26, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-27, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-27, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-27, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-06-27, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-06-27, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-06-27, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-06-27, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-28, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-28, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-28, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-29, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-29, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-29, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-06-29, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-06-29, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-30, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-30, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-30, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-06-30, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-06-30, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-01, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-01, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-01, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-01, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-01, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-02, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-02, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-02, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-03, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-03, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-03, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-03, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-03, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-03, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-03, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-04, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-04, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-04, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-05, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-05, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-05, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-05, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-05, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-06, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-06, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-06, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-06, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-06, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-07, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-07, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-07, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-07, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-07, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-08, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-08, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-08, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-09, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-09, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-09, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-09, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-09, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-09, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-09, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-10, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-10, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-10, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-11, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-11, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-11, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-11, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-11, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-12, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-12, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-12, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-12, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-12, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-13, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-13, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-13, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-13, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-13, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-14, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-14, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-14, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-15, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-15, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-15, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-15, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-15, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-15, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-15, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-16, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-16, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-16, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-17, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-17, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-17, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-17, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-17, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-18, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-18, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-18, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-18, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-18, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-19, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-19, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-19, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-19, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-19, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-20, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-20, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-20, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-21, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-21, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-21, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-21, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-21, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-21, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-21, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-22, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-22, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-22, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-23, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-23, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-23, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-23, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-23, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-24, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-24, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-24, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-24, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-24, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-25, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-25, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-25, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-25, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-25, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-26, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-26, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-26, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-27, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-27, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-27, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-27, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-27, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-27, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-27, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-28, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-28, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-28, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-29, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-29, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-29, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-29, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-29, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-30, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-30, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-30, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-30, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-30, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-31, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-31, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-31, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-31, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-31, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-01, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-01, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-01, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-02, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-02, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-02, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-08-02, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-08-02, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-08-02, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-08-02, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-03, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-03, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-03, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-04, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-04, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-04, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-08-04, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-08-04, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-05, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-05, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-05, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-08-05, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-08-05, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-06, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-06, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-06, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-08-06, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-08-06, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-07, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-07, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-07, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-08, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-08, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-08, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-08-08, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g. wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-08-08, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-08-08, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-08-08, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-09, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-09, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-09, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-10, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-10, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-10, Health Management:, Monitor the birds for any signs of illness such as lethargy or abnormal droppings or respiratory distress., 'isChecked': false, If any birds appear sick. Separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures such as foot baths in order to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-08-10, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-08-10, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
  ];
  // serialize data from datafrom database
  String serialized_full_checklist = await jsonEncode(checklist_example);

  final SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('full_checklist', serialized_full_checklist);

  //return serialized_location_details;

  //return checklist_example;
}

// this finction gets the completion rate/progress of completion of the tasks
Future<List<String>> get_progress_of_items() async {
  List<String> checklist_example = [
    "[2023-06-22, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-22, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-22, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-23, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-23, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-23, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-06-23, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-06-23, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-24, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-24, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-24, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-06-24, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-06-24, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-25, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-25, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-25, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-06-25, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-06-25, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-26, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-26, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-26, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-27, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-27, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-27, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-06-27, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-06-27, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-06-27, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-06-27, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-28, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-28, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-28, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-29, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-29, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-29, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-06-29, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-06-29, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-06-30, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-06-30, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-06-30, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-06-30, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-06-30, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-01, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-01, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-01, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-01, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-01, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-02, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-02, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-02, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-03, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-03, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-03, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-03, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-03, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-03, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-03, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-04, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-04, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-04, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-05, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-05, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-05, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-05, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-05, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-06, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-06, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-06, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-06, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-06, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-07, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-07, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-07, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-07, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-07, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-08, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-08, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-08, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-09, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-09, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-09, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-09, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-09, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-09, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-09, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-10, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-10, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-10, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-11, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-11, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-11, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-11, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-11, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-12, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-12, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-12, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-12, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-12, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-13, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-13, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-13, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-13, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-13, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-14, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-14, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-14, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-15, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-15, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-15, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-15, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-15, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-15, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-15, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-16, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-16, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-16, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-17, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-17, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-17, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-17, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-17, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-18, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-18, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-18, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-18, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-18, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-19, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-19, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-19, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-19, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-19, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-20, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-20, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-20, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-21, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-21, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-21, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-21, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-21, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-21, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-21, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-22, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-22, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-22, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-23, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-23, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-23, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-23, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-23, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-24, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-24, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-24, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-24, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-24, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-25, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-25, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-25, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-25, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-25, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-26, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-26, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-26, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-27, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-27, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-27, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-27, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-27, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-27, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-27, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-28, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-28, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-28, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-29, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-29, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-29, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-29, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-29, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-30, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-30, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-30, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-07-30, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-07-30, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-07-31, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-07-31, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-07-31, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-07-31, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-07-31, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-01, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-01, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-01, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-02, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-02, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-02, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-08-02, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-08-02, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-08-02, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-08-02, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-03, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-03, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-03, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-04, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-04, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-04, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-08-04, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-08-04, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-05, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-05, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-05, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-08-05, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-08-05, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-06, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-06, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-06, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-08-06, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-08-06, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-07, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-07, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-07, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-08, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-08, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-08, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-08-08, Housing and Bedding:, Ensure that the broiler house is clean and well-ventilated., 'isChecked': false, Check the bedding material (e.g., wood shavings or straw) and replace it if it becomes damp or soiled., 'isChecked': false, Monitor the temperature inside the broiler house throughout the day and make adjustments as needed., 'isChecked': false, 3]",
    "[2023-08-08, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-08-08, Waste Management:, Regularly clean the broiler house and remove accumulated manure., 'isChecked': false, Dispose of the waste appropriately, following local regulations and guidelines., 'isChecked': false, Monitor the ammonia levels in the house and take steps to maintain good air quality., 'isChecked': false, 3]",
    "[2023-08-08, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-09, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-09, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-09, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
    "[2023-08-10, Morning Routine:, Check the temperature and humidity levels in the broiler house to ensure they are within the optimal range for the age of the birds., 'isChecked': false, Inspect the ventilation system and adjust it if necessary to maintain proper airflow., 'isChecked': false, Check the water supply and make sure all waterers are functioning correctly., 'isChecked': false, Inspect the feeding system and ensure that feeders are clean and working properly., 'isChecked': false, Conduct a visual inspection of the chickens, looking for any signs of illness or distress., 'isChecked': false, 1]",
    "[2023-08-10, Feeding and Watering:, Provide fresh feed to the chickens according to their age and nutritional requirements., 'isChecked': false, Monitor feed consumption and adjust the feed quantity if needed., 'isChecked': false, Ensure that there is an adequate supply of clean and fresh water available to the chickens at all times., 'isChecked': false, Clean and refill waterers as needed to prevent contamination and spillage., 'isChecked': false, 1]",
    "[2023-08-10, Health Management:, Monitor the birds for any signs of illness, such as lethargy, abnormal droppings, or respiratory distress., 'isChecked': false, If any birds appear sick, separate them from the healthy ones and seek veterinary advice., 'isChecked': false, Conduct regular biosecurity measures, such as foot baths, to prevent the introduction and spread of diseases., 'isChecked': false, Check for parasites like mites or lice and take appropriate measures for their control if necessary., 'isChecked': false, 2]",
    "[2023-08-10, Growth Monitoring:, Weigh a representative sample of chickens regularly to track their growth progress., 'isChecked': false, Keep records of the weights and growth rates to identify any issues or deviations., 'isChecked': false, Adjust feed rations based on the growth rate and performance of the birds., 'isChecked': false, 2]",
    "[2023-08-10, Evening Routine:, Conduct a final visual inspection of the chickens to ensure their well-being., 'isChecked': false, Check the feed and water supply for any issues., 'isChecked': false, Make sure the chickens have sufficient lighting and adjust it if necessary., 'isChecked': false, Secure the broiler house against predators or potential risks., 'isChecked': false, 1]",
  ];

  //loop through the list of checklist and
  void countTasks(List<String> taskList) {
    Map<String, int> checkedTaskCountByIndex = {};
    Map<String, int> taskCountByDate = {};
    List<String> titles = [];
    List<int> titles_days = [];
    List<String> titles_weeks = [];
    List<String> titles_total = [];


    for (String task in taskList) {
      List<dynamic> taskData = task.split(', ');
      String index1 = taskData[1];

      // List<dynamic> taskData = task.split(', ');
      String date = taskData[0].substring(
          1); // Extract the date from the first element

      if (date.compareTo('2023-06-27') >= 0) {
        // Stop counting tasks after 2023-06-25
        break;
      } else {

      }

      //create titles list
      if (titles.contains('${taskData[1]}')) {

      } else {
        titles.add('${taskData[1]}');
        titles_days.add(0);
      }
      /////////////////////////////
      // this counts the amount of times ischecked is false for all the days until the current day and orders the count by title
      for (var g = 0; g < taskData.length; g++) {
        if(taskData[g] == "'isChecked': false"){

          for (var t = 0; t < titles.length; t++) {
            if (titles[t] == '${taskData[1]}') {

              print("titles[t]: ${titles[t]} vs taskData[1]: ${taskData[1]} vs '${taskData[g]}'");

              titles_days[t] = titles_days[t] + 1;

            }
          }

        }

      }
      /////////////////////////////
      print(titles);
      print(titles_days);
    }
  }

  countTasks(checklist_example);

  List<String> placeholder = [];
  return placeholder;
}

////////////////////////////////////////////
//####################
// for BUSINESS ADMIN
//####################


// business information page
Future<String> get_Business_Information_Details() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  // set location details
  // NOTE: this represents one row pulled from the database
  Map<dynamic,String> Business_inormation = {
    'Information1': 'house number/street number,City/Town Name,Province',
    'Information2': 'farm contact name and sirname',
    'image_Information1':"",
    'Information3': 'house number/street number,City/Town Name,Province',
    'Information4': 'farm contact name and sirname',
  };
  // serialize data from datafrom database
  String serialized_business_information = await jsonEncode(Business_inormation);

  await pref.setString('Business_inofrmation', serialized_business_information);

  Map<dynamic,String> Business_Questions_and_Input = {
    'FarmAddress': 'house number/street number,City/Town Name,Province',
    'FarmAdress_input':'text',
    'FarmContactName': 'farm contact name and sirname',
    'FarmContactName_input':'text',
    'exampleupload2': 'upload detail pdf2',
    'exampleupload_input':'file_upload',
    'FarmContactCellNo': 'farm contact cellphone number',
    'FarmContactCellNo_input':'text',
    'AplicantAddress': 'house number/street number,City/Town Name,Province',
    'AplicantAddress_input':'text',
    'ApplicantContactName': 'farm contact name and sirname',
    'ApplicantContactName_input':'text',
    'ApplicantContactCellNo': 'farm contact cellphone number',
    'ApplicantContactCellNo_input':'text',
    'exampleupload3': 'upload detail pdf',
    'exampleupload3_input':'file_upload',
    'ApplicantContactCellNo2': 'farm contact cellphone number',
    'ApplicantContactCellNo_input2':'text',
  };

  // serialize data from datafrom database
  String serialized_location_details = await jsonEncode(Business_Questions_and_Input);


  await pref.setString('Business_question_and_answers', serialized_location_details);

  return serialized_location_details;
}

// business plan page
Future<String> get_Business_plan_Details() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  // set location details
  // NOTE: this represents one row pulled from the database
  Map<dynamic,String> Business_plan = {
    'Information1': 'house number/street number,City/Town Name,Province',
    'Information2': 'farm contact name and sirname',
    'image_Information1':"",
    'Information3': 'house number/street number,City/Town Name,Province',
    'Information4': 'farm contact name and sirname',
  };
  // serialize data from datafrom database
  String serialized_business_plan = await jsonEncode(Business_plan);

  await pref.setString('Business_plan', serialized_business_plan);

  Map<dynamic,String> Business_plan_Questions_and_Input = {
    'FarmAddress': 'house number/street number,City/Town Name,Province',
    'FarmAdress_input':'text',
    'FarmContactName': 'farm contact name and sirname',
    'FarmContactName_input':'text',
    'exampleupload2': 'upload detail pdf2',
    'exampleupload_input':'file_upload',
    'FarmContactCellNo': 'farm contact cellphone number',
    'FarmContactCellNo_input':'text',
    'AplicantAddress': 'house number/street number,City/Town Name,Province',
    'AplicantAddress_input':'text',
    'ApplicantContactName': 'farm contact name and sirname',
    'ApplicantContactName_input':'text',
    'ApplicantContactCellNo': 'farm contact cellphone number',
    'ApplicantContactCellNo_input':'text',
    'exampleupload3': 'upload detail pdf',
    'exampleupload3_input':'file_upload',
    'ApplicantContactCellNo2': 'farm contact cellphone number',
    'ApplicantContactCellNo_input2':'text',
  };

  // serialize data from datafrom database
  String serialized_location_details = await jsonEncode(Business_plan_Questions_and_Input);


  await pref.setString('Business_plan_question_and_answers', serialized_location_details);

  return serialized_location_details;
}

// Financial information page
Future<String> get_Financial_information_Details() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  // set location details
  // NOTE: this represents one row pulled from the database
  Map<dynamic,String> Financial_information = {
    'Information1': 'house number/street number,City/Town Name,Province',
    'Information2': 'farm contact name and sirname',
    'image_Information1':"",
    'Information3': 'house number/street number,City/Town Name,Province',
    'Information4': 'farm contact name and sirname',
  };
  // serialize data from datafrom database
  String serialized_Financial_information = await jsonEncode(Financial_information);

  await pref.setString('Financial_information', serialized_Financial_information);

  Map<dynamic,String> Financial_information_Questions_and_Input = {
    'FarmAddress': 'house number/street number,City/Town Name,Province',
    'FarmAdress_input':'text',
    'FarmContactName': 'farm contact name and sirname',
    'FarmContactName_input':'text',
    'exampleupload2': 'upload detail pdf2',
    'exampleupload_input':'file_upload',
    'FarmContactCellNo': 'farm contact cellphone number',
    'FarmContactCellNo_input':'text',
    'AplicantAddress': 'house number/street number,City/Town Name,Province',
    'AplicantAddress_input':'text',
    'ApplicantContactName': 'farm contact name and sirname',
    'ApplicantContactName_input':'text',
    'ApplicantContactCellNo': 'farm contact cellphone number',
    'ApplicantContactCellNo_input':'text',
    'exampleupload3': 'upload detail pdf',
    'exampleupload3_input':'file_upload',
    'ApplicantContactCellNo2': 'farm contact cellphone number',
    'ApplicantContactCellNo_input2':'text',
  };

  // serialize data from datafrom database
  String serialized_location_details = await jsonEncode(Financial_information_Questions_and_Input);


  await pref.setString('Financial_information_Questions_and_Input', serialized_location_details);

  return serialized_location_details;
}

// funding request page
Future<String> get_Fundind_request_Details() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  // set location details
  // NOTE: this represents one row pulled from the database
  Map<dynamic,String> Fundind_request = {
    'Information1': 'house number/street number,City/Town Name,Province',
    'Information2': 'farm contact name and sirname',
    'image_Information1':"",
    'Information3': 'house number/street number,City/Town Name,Province',
    'Information4': 'farm contact name and sirname',
  };
  // serialize data from datafrom database
  String serialized_Fundind_request = await jsonEncode(Fundind_request);

  await pref.setString('Fundind_request', serialized_Fundind_request);

  Map<dynamic,String> Fundind_request_Questions_and_Input = {
    'FarmAddress': 'house number/street number,City/Town Name,Province',
    'FarmAdress_input':'text',
    'FarmContactName': 'farm contact name and sirname',
    'FarmContactName_input':'text',
    'exampleupload2': 'upload detail pdf2',
    'exampleupload_input':'file_upload',
    'FarmContactCellNo': 'farm contact cellphone number',
    'FarmContactCellNo_input':'text',
    'AplicantAddress': 'house number/street number,City/Town Name,Province',
    'AplicantAddress_input':'text',
    'ApplicantContactName': 'farm contact name and sirname',
    'ApplicantContactName_input':'text',
    'ApplicantContactCellNo': 'farm contact cellphone number',
    'ApplicantContactCellNo_input':'text',
    'exampleupload3': 'upload detail pdf',
    'exampleupload3_input':'file_upload',
    'ApplicantContactCellNo2': 'farm contact cellphone number',
    'ApplicantContactCellNo_input2':'text',
  };

  // serialize data from datafrom database
  String serialized_location_details = await jsonEncode(Fundind_request_Questions_and_Input);

  await pref.setString('Fundind_request_Questions_and_Input', serialized_location_details);

  return serialized_location_details;
}

// social environment impact page
Future<String> get_Social_Envi_impact_Details() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  // set location details
  // NOTE: this represents one row pulled from the database
  Map<dynamic,String> Social_Envi_Impact = {
    'Information1': 'house number/street number,City/Town Name,Province',
    'Information2': 'farm contact name and sirname',
    'image_Information1':"",
    'Information3': 'house number/street number,City/Town Name,Province',
    'Information4': 'farm contact name and sirname',
  };
  // serialize data from datafrom database
  String serialized_Social_Envi_Impact = await jsonEncode(Social_Envi_Impact);

  await pref.setString('Social_Envi_Impact', serialized_Social_Envi_Impact);

  Map<dynamic,String> Social_Envi_Impact_Questions_and_Input = {
    'FarmAddress': 'house number/street number,City/Town Name,Province',
    'FarmAdress_input':'text',
    'FarmContactName': 'farm contact name and sirname',
    'FarmContactName_input':'text',
    'exampleupload2': 'upload detail pdf2',
    'exampleupload_input':'file_upload',
    'FarmContactCellNo': 'farm contact cellphone number',
    'FarmContactCellNo_input':'text',
    'AplicantAddress': 'house number/street number,City/Town Name,Province',
    'AplicantAddress_input':'text',
    'ApplicantContactName': 'farm contact name and sirname',
    'ApplicantContactName_input':'text',
    'ApplicantContactCellNo': 'farm contact cellphone number',
    'ApplicantContactCellNo_input':'text',
    'exampleupload3': 'upload detail pdf',
    'exampleupload3_input':'file_upload',
    'ApplicantContactCellNo2': 'farm contact cellphone number',
    'ApplicantContactCellNo_input2':'text',
  };

  // serialize data from datafrom database
  String serialized_location_details = await jsonEncode(Social_Envi_Impact_Questions_and_Input);

  await pref.setString('Social_Envi_Impact_Questions_and_Input', serialized_location_details);

  return serialized_location_details;
}

// supporting documents page
Future<String> get_supporting_documents_Details() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  // set location details
  // NOTE: this represents one row pulled from the database
  Map<dynamic,String> Supporting_documents = {
    'Information1': 'house number/street number,City/Town Name,Province',
    'Information2': 'farm contact name and sirname',
    'image_Information1':"",
    'Information3': 'house number/street number,City/Town Name,Province',
    'Information4': 'farm contact name and sirname',
  };
  // serialize data from datafrom database
  String serialized_Supporting_documents = await jsonEncode(Supporting_documents);

  await pref.setString('Supporting_documents', serialized_Supporting_documents);

  Map<dynamic,String> Supporting_documents_Questions_and_Input = {
    'FarmAddress': 'house number/street number,City/Town Name,Province',
    'FarmAdress_input':'text',
    'FarmContactName': 'farm contact name and sirname',
    'FarmContactName_input':'text',
    'exampleupload2': 'upload detail pdf2',
    'exampleupload_input':'file_upload',
    'FarmContactCellNo': 'farm contact cellphone number',
    'FarmContactCellNo_input':'text',
    'AplicantAddress': 'house number/street number,City/Town Name,Province',
    'AplicantAddress_input':'text',
    'ApplicantContactName': 'farm contact name and sirname',
    'ApplicantContactName_input':'text',
    'ApplicantContactCellNo': 'farm contact cellphone number',
    'ApplicantContactCellNo_input':'text',
    'exampleupload3': 'upload detail pdf',
    'exampleupload3_input':'file_upload',
    'ApplicantContactCellNo2': 'farm contact cellphone number',
    'ApplicantContactCellNo_input2':'text',
  };

  // serialize data from datafrom database
  String serialized_location_details = await jsonEncode(Supporting_documents_Questions_and_Input);

  await pref.setString('Supporting_documents_Questions_and_Input', serialized_location_details);

  return serialized_location_details;
}

//########################
// For Management
//########################

// ACCOUNT SIMULATION
Future<String> Assigned_to_user() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  // set location details
  // NOTE: this represents one row pulled from the database of each user
  List<List<String>> Assigned_to_user = [
    ['2023-07-21','Morning Routine:', 'Evening Routine:'],
    ['2023-07-22','Morning Routine:', 'Feeding and Watering:'],
  ];

  // 'mbali':"['Feeding and Watering:']",

  // serialize data from datafrom database
  String serialized_Assigned_to_user = await jsonEncode(
      Assigned_to_user);

  await pref.setString('Assigned_to_user', serialized_Assigned_to_user);

  return serialized_Assigned_to_user;
}

// ACCOUNT SIMULATION get all assigned tasks for manager checlist assign display
Future<String> Assigned_to_users_manager() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  // set location details
  // NOTE: this represents one row pulled from the database of all users of manager team
  List<List<String>> assigned_to_all = [
    ['1','tasko','2023-07-27','Morning Routine:', 'Evening Routine:'],
    ['2','maven','2023-07-27','Feeding and Watering:'],
  ];

  // 'mbali':"['Feeding and Watering:']",

  // serialize data from datafrom database
  String serialized_assigned_to_all = await jsonEncode(
      assigned_to_all);

  await pref.setString('assigned_user_manager', serialized_assigned_to_all);

  return serialized_assigned_to_all;
}


// ACCOUNT SIMULATION get all assigned tasks for manager checlist assign display
Future<String> get_edu_https() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  bool isValueSet = pref.containsKey('key');
  if(isValueSet){

  }else{

  }
  print('hiz');
  var url = "https://farm-starts.onrender.com/get_edu_info";
  final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    // body: jsonEncode(<String, String>{
    //   //get the drivers working location and get all orders from the drivers province
    //   'driverid': driverid,
    //   'device_token': fcmToken.toString(),
    // }),
  );
  print("response.statusCode ${response.statusCode}");
  if(response.statusCode == 200){
    print("the token was set successfully");
    print(response);
    var data = jsonDecode(response.body);
    print("error in getting order id");
    print(data);
  }


  // set location details
  // NOTE: this represents one row pulled from the database of all users of manager team
  List<List<String>> assigned_to_all = [
    ['1','tasko','2023-07-27','Morning Routine:', 'Evening Routine:'],
    ['2','maven','2023-07-27','Feeding and Watering:'],
  ];

  // 'mbali':"['Feeding and Watering:']",

  // serialize data from datafrom database
  String serialized_assigned_to_all = await jsonEncode(
      assigned_to_all);

  await pref.setString('assigned_user_manager', serialized_assigned_to_all);

  return serialized_assigned_to_all;
}

// GET PORTFOLIO INFORMATION
Future<List> get_portfolio_https() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  bool isValueSet = pref.containsKey('key');
  if(isValueSet){

  }else{

  }
  print('hiz2');
  var url = "https://www.site.com/get_portfolio_app";
  final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    // body: jsonEncode(<String, String>{
    //   //get the drivers working location and get all orders from the drivers province
    //   'driverid': driverid,
    //   'device_token': fcmToken.toString(),
    // }),
  );
  print("response.statusCode ${response.statusCode}");
  if(response.statusCode == 200 || response.statusCode == 503){
    //print("the token was set successfully");
    //print(response);
    var data = jsonDecode(response.body);
    //print("error in getting order id");
    //print(data['portfolio']);
    String serialized_assigned_to_all = await jsonEncode(data['portfolio']);
    await pref.setString('business_information_qs_answers2', serialized_assigned_to_all);
    return data['portfolio'];
  }


  // set location details
  // NOTE: this represents one row pulled from the database of all users of manager team
  List<List<String>> assigned_to_all = [
    ['1','tasko','2023-07-27','Morning Routine:', 'Evening Routine:'],
    ['2','maven','2023-07-27','Feeding and Watering:'],
  ];

  // 'mbali':"['Feeding and Watering:']",

  // serialize data from datafrom database
  //String serialized_assigned_to_all = await jsonEncode(data['portfolio']);

  // await pref.setString('business_information_qs_answers2', serialized_assigned_to_all);

  return assigned_to_all;
}