import 'package:flutter/material.dart';

import '../constants.dart';


class BusinessHoursDetails extends StatefulWidget {
  const BusinessHoursDetails({Key? key}) : super(key: key);

  @override
  _BusinessHoursDetailsState createState() => _BusinessHoursDetailsState();
}

class _BusinessHoursDetailsState extends State<BusinessHoursDetails> {

  String openingHour = '10:00 AM';
  String endingHour = '10:00 PM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$currentDayWorkingHoursToChange working hours"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: 1500,
          height: 1500,
          child: Stack(
            children: [
              Positioned(
                top: 200,
                left: 400,
                child: Container(
                  width: 400,
                  height: 500,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Opening hours ", style: TextStyle(
                            fontSize: 20,
                          ),),
                          SizedBox(width: 30,),
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
                          SizedBox(width: 30,),
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
                      SizedBox(height: 40,),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 300,
                  left: 520,
                  child:Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 150,
                    height: 40,
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          businessHours[currentDayWorkingHoursToChange]!['from'] = openingHour;
                          businessHours[currentDayWorkingHoursToChange]!['to'] = endingHour;
                        });

                        Navigator.pushNamed(context, '/business-hours');
                      },
                      child: Center(
                        child: Text("Save", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
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
