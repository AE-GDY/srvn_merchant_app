import 'package:flutter/material.dart';
import 'package:servnn_client_side/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BusinessHours extends StatefulWidget {
  GlobalKey _key = GlobalKey();

  @override
  _BusinessHoursState createState() => _BusinessHoursState();
}

class _BusinessHoursState extends State<BusinessHours> {

  List<String> weekDays = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();


  var currentHeight = 200.0;

  int startYear = 0;
  int startMonth = 0;
  int startDay = 0;
  int startHour = 0;
  int startMinutes = 0;

  int endYear = 0;
  int endMonth = 0;
  int endDay = 0;
  int endHour = 0;
  int endMinutes = 0;

  final dateFormat = DateFormat('EEEE yyyy-MMMM-dd');
  DateTime _chosenDate = DateTime.now();


  bool initialSetter = false;
  String currentDateInWords = '';
  String currentDayOfWeek = '';

  bool initialEdit = true;
  bool initialBuild = true;
  bool updateServiceLinked = false;
  bool updateStaffLinked = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Business Hours"),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 50,),

              Card(
                elevation: 2.0,
                child: Container(
                  width: 450,
                  height: 450,
                  margin: EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: weekDays.length,
                      itemBuilder: (context,index){
                        return Container(
                          width: 200,
                          height: 50,
                          margin: EdgeInsets.all(5),
                          child: ListTile(
                            onTap: (){
                              if(daySelected[index]){
                                setState(() {
                                  currentDayWorkingHoursToChange = weekDays[index];
                                });

                                Navigator.pushNamed(context, '/busines-hours-details');
                              }
                            },
                            title: Text(weekDays[index]),
                            subtitle: Text(!daySelected[index]?"Closed":'${businessHours[weekDays[index]]!['from']} - '
                                '${businessHours[weekDays[index]]!['to']}',),
                            trailing: Switch(
                              activeColor: Colors.deepPurple,
                              value: daySelected[index],
                              onChanged: (bool value) {
                                setState(() {
                                  //print("day selected length: ${daySelected.length}");

                                  daySelected[index] = !daySelected[index];

                                  businessHours[weekDays[index]]!['day-off'] = daySelected[index];

                                });
                              },
                            ),
                          ),
                        );
                      }),
                ),
              ),

              SizedBox(height: 10,),

              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/add-staff-members');
                  },
                  child: Text("Continue",style: TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildServiceLinked(int index){
    if(servicesLinkedStatus[index]){
      return Column(
        children: [
          Row(
            children: [
              Text("Minute gap: "),
              SizedBox(width: 10,),
              DropdownButton<String>(
                value: '${serviceLinkedMinuteGaps[index]}',
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                //style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? newValue) {
                  setState(() {

                    updateServiceLinked = true;

                    serviceLinkedMinuteGaps[index] = int.parse(newValue!);

                    serviceLinkedPossibleMinutes[index].clear();
                    serviceLinkedPossibleTimings.clear();

                    int serviceIndex = 0;
                    while(serviceIndex < services.length){
                      serviceLinkedPossibleTimings.add([]);
                      serviceIndex++;
                    }

                    int minutes = 0;
                    while(minutes < 60){
                      if(minutes == 0){
                        serviceLinkedPossibleMinutes[index].add('00');
                      }
                      else if(minutes < 10){
                        serviceLinkedPossibleMinutes[index].add('0$minutes');
                      }
                      else{
                        serviceLinkedPossibleMinutes[index].add('$minutes');
                      }
                      minutes += serviceLinkedMinuteGaps[index];
                    }
                  });
                },
                items: <String>[
                  '5',
                  '10',
                  '15',
                  '20',
                  '25',
                  '30',
                  '35',
                  '40',
                  '45',
                  '50',
                  '55',
                ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          TextField(
            controller: amountPerTimingControllers[index],
            decoration: InputDecoration(
              labelText: "Maximum bookings per slot",
            ),
          ),
        ],
      );
    }

    return Container();

  }


}
