import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/database.dart';
import 'business_hours_logged_in.dart';


class EditBusinessHours extends StatefulWidget {
  const EditBusinessHours({Key? key}) : super(key: key);

  @override
  _EditBusinessHoursState createState() => _EditBusinessHoursState();
}

class _EditBusinessHoursState extends State<EditBusinessHours> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  DatabaseService databaseService = DatabaseService();


  bool dayOffSelected = false;

  String openingHour = '10:00 AM';
  String endingHour = '10:00 PM';

  List<String> weekDays = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text('Business Hours', style: TextStyle(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 2.0,
                child: Container(
                  width: 400,
                  height: 400,
                  child: Column(
                    children: [
                      Text('$daySelectedToEdit Working Hours', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),

                      SizedBox(height: 50,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Switch(
                            value: dayOffSelected,
                            onChanged: (bool value) {
                              setState(() {
                                dayOffSelected = !dayOffSelected;
                              });
                            },
                          ),

                          SizedBox(width: 10,),
                          Text('Day off',style: TextStyle(
                            fontSize: 18,
                          ),),
                        ],
                      ),

                      SizedBox(height: 30,),

                     !dayOffSelected? Row(
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
                      ):Container(),

                      SizedBox(height: 100,),

                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {

                            await databaseService.changeBusinessHours(
                                selectedCategory,
                                currentShopIndex,
                                daySelectedToEdit,
                                openingHour,
                                endingHour,
                                dayOffSelected,
                            );

                            Navigator.pushNamed(context, '/business-hours-logged-in');

                          },
                          child: Text("Save Changes", style: TextStyle(
                            color: Colors.white,
                          ),),
                        ),
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
