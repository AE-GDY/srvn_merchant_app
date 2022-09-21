import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/database.dart';


class BlockHours extends StatefulWidget {
  const BlockHours({Key? key}) : super(key: key);

  @override
  _BlockHoursState createState() => _BlockHoursState();
}

class _BlockHoursState extends State<BlockHours> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  DatabaseService databaseService = DatabaseService();

  String openingHour = '10:00 AM';
  String endingHour = '10:00 PM';

  String startDay = "";
  String startMonth = "";
  String startYear = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Block Hours', style: TextStyle(
          color: Colors.black,
        ),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Card(
                elevation: 2.0,
                child: Container(
                  width: 400,
                  height: 400,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Column(
                            children: [
                              Text('Day'),
                              SizedBox(height: 5,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1.0),
                                ),
                                width: 100,
                                child: DropdownButton<String>(
                                  value: startDay,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  //style: const TextStyle(color: Colors.deepPurple),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      startDay = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    '', '1','2','3','4','5','6','7','8','9','10','11','12','13','14','15'
                                    ,'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30',
                                  ]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 10,),

                          Column(
                            children: [
                              Text('Month'),
                              SizedBox(height: 5,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1.0),
                                ),
                                width: 100,
                                child: DropdownButton<String>(
                                  value: startMonth,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  //style: const TextStyle(color: Colors.deepPurple),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      startMonth = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    '',  'JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC',
                                  ]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 10,),

                          Column(
                            children: [
                              Text('Year'),
                              SizedBox(height: 5,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1.0),
                                ),
                                width: 100,
                                child: DropdownButton<String>(
                                  value: startYear,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  //style: const TextStyle(color: Colors.deepPurple),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      startYear = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    '', '2022','2023','2024','2025','2026'
                                  ]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 10,),


                        ],
                      ),


                      SizedBox(height: 20,),

                      Text('Hours to block', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),

                      SizedBox(height: 30,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text('From'),
                              SizedBox(height: 10,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1.0),
                                ),
                                width: 100,
                                child: DropdownButton<String>(
                                  value: openingHour,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  //style: const TextStyle(color: Colors.deepPurple),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      openingHour = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    '10:00 AM',
                                    '11:00 AM',
                                    '12:00 PM',
                                    '1:00 PM',
                                    '2:00 PM',
                                    '3:00 PM',
                                    '4:00 PM',
                                    '5:00 PM',
                                    '6:00 PM',
                                    '7:00 PM',
                                    '8:00 PM',
                                    '9:00 PM',
                                    '10:00 PM',
                                  ]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 30,),
                          Column(
                            children: [
                              Text('To'),
                              SizedBox(height: 10,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1.0),
                                ),
                                width: 100,
                                child: DropdownButton<String>(
                                  value: endingHour,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  //style: const TextStyle(color: Colors.deepPurple),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      endingHour = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    '10:00 AM',
                                    '11:00 AM',
                                    '12:00 PM',
                                    '1:00 PM',
                                    '2:00 PM',
                                    '3:00 PM',
                                    '4:00 PM',
                                    '5:00 PM',
                                    '6:00 PM',
                                    '7:00 PM',
                                    '8:00 PM',
                                    '9:00 PM',
                                    '10:00 PM',
                                  ]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 50,),

                      FutureBuilder(
                        future: categoryData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              return Container(
                                width: 250,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () async {


                                    int monthIndex = 0;
                                    while(monthIndex < months.length){
                                      if(months[monthIndex] == startMonth){
                                        break;
                                      }
                                      monthIndex++;
                                    }

                                    await databaseService.addBlockedHours(
                                        selectedCategory,
                                        currentShopIndex,
                                        snapshot.data['$currentShopIndex']['blocked-hours-amount'],
                                        startDay,
                                        monthIndex,
                                        startYear,
                                        openingHour,
                                        endingHour
                                    );

                                    Navigator.pushNamed(context, '/business-hours-logged-in');

                                  },
                                  child: Text("Block Hours", style: TextStyle(
                                    color: Colors.white,
                                  ),),
                                ),
                              );
                            }
                          }
                          return const Text("Please wait");
                        },

                      ),


                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
