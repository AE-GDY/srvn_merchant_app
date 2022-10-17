import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/models/staff_member.dart';
import 'package:servnn_client_side/services/database.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../constants.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  DateTime selectedDay = DateTime.now();

  CalendarController _controller = CalendarController();

  bool dayChanged = false;


  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 100,),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Dashboard"),
              onTap: (){
                setState(() {
                  selectedPage = 'dashboard';
                });
                Navigator.popAndPushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: Icon(IconData(0xf320, fontFamily: 'MaterialIcons')),
              title: Text("Services"),
              onTap: (){
                setState(() {
                  selectedPage = 'services';
                });
                Navigator.popAndPushNamed(context, '/services-page');
              },
            ),
            ListTile(
              leading: Icon(IconData(0xf006c, fontFamily: 'MaterialIcons')),
              title: Text("Staff Members"),
              onTap: (){
                setState(() {
                  selectedPage = 'staffMembers';
                });
                Navigator.pushNamed(context, '/staff-members-page');
                },
            ),
            ListTile(
              leading: Icon(IconData(0xf44a, fontFamily: 'MaterialIcons')),
              title: Text("Business Hours"),
              onTap: (){
                setState(() {
                  selectedPage = 'businessHours';
                });
                Navigator.pushNamed(context, '/business-hours-logged-in');
              },
            ),
            ListTile(
              leading: Icon(Icons.bolt_rounded,
                color: selectedPage == 'marketing'?Colors.black:Colors.grey,
                size: selectedPage == 'marketing'?35:iconSize,
              ),
              title: Text("Marketing"),
              onTap: (){
                setState(() {
                  selectedPage = 'marketing';
                });
                Navigator.popAndPushNamed(context, '/marketing');
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_chart_outlined),
              title: Text("Statistics and Reports"),
              onTap: (){
                setState(() {
                  selectedPage = 'statistics';
                });
                Navigator.popAndPushNamed(context, '/stats-and-reports');
              },
            ),
            ListTile(
              leading: Icon(IconData(0xf00ad, fontFamily: 'MaterialIcons')),
              title: Text("Point of Sale"),
              onTap: (){
                setState(() {
                  selectedPage = 'POS';
                });
                Navigator.popAndPushNamed(context, '/POS');
                },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {


                setState(() {
                  selectedPage = 'settings';
                });
                Navigator.popAndPushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('$shopName Dashboard',style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/dashboard');
          }, icon: Icon(Icons.refresh,color: Colors.black,),
          ),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(Icons.logout,color: Colors.black,)
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.account_circle,color: Colors.black,),
          ),
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
                top: 20,
                left: 5,
                child: Container(
                  width: 70,
                  height: 1500,
                  decoration: BoxDecoration(
                    //color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Tooltip(
                        message: 'Dashboard',
                        child: ListTile(
                          leading: Icon(Icons.home,
                            color: selectedPage == 'dashboard'?Colors.black:Colors.grey,
                            size: selectedPage == 'dashboard'?35:iconSize,
                          ),
                          //title: Text("Dashboard"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'dashboard';
                            });
                            Navigator.popAndPushNamed(context, '/dashboard');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Services',
                        child: ListTile(
                          leading: Icon(IconData(0xf320, fontFamily: 'MaterialIcons'),
                            color: selectedPage == 'services'?Colors.black:Colors.grey,
                            size: selectedPage == 'services'?35:iconSize,
                          ),
                          // title: Text("Services"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'services';
                            });
                            Navigator.popAndPushNamed(context, '/services-page');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Staff Members',
                        child: ListTile(
                          leading: Icon(IconData(0xf006c, fontFamily: 'MaterialIcons'),
                            color: selectedPage == 'staffMembers'?Colors.black:Colors.grey,
                            size: selectedPage == 'staffMembers'?35:iconSize,
                          ),
                          //title: Text("Staff Members"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'staffMembers';
                            });
                            Navigator.pushNamed(context, '/staff-members-page');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Business Hours',
                        child: ListTile(
                          leading: Icon(IconData(0xf44a, fontFamily: 'MaterialIcons'),
                            color: selectedPage == 'businessHours'?Colors.black:Colors.grey,
                            size: selectedPage == 'businessHours'?35:iconSize,
                          ),
                          //title: Text("Staff Members"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'businessHours';
                            });
                            Navigator.pushNamed(context, '/business-hours-logged-in');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Marketing',
                        child: ListTile(
                          leading: Icon(Icons.bolt_rounded,
                            color: selectedPage == 'marketing'?Colors.black:Colors.grey,
                            size: selectedPage == 'marketing'?35:iconSize,
                          ),
                          //title: Text("Statistics and Reports"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'marketing';
                            });
                            Navigator.popAndPushNamed(context, '/marketing');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Stats and Reports',
                        child: ListTile(
                          leading: Icon(Icons.insert_chart_outlined,
                            color: selectedPage == 'statistics'?Colors.black:Colors.grey,
                            size: selectedPage == 'statistics'?35:iconSize,
                          ),
                          //title: Text("Statistics and Reports"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'statistics';
                            });
                            Navigator.popAndPushNamed(context, '/stats-and-reports');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Checkout',
                        child: ListTile(
                          leading: Icon(IconData(0xf00ad, fontFamily: 'MaterialIcons'),
                            color: selectedPage == 'POS'?Colors.black:Colors.grey,
                            size: selectedPage == 'POS'?35:iconSize,
                          ),
                          //title: Text("Point of Sale"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'POS';
                            });
                            Navigator.popAndPushNamed(context, '/POS');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Settings',
                        child: ListTile(
                          leading: Icon(Icons.settings,color: selectedPage == 'settings'?Colors.black:Colors.grey,size: iconSize,),
                          //title: Text("Settings"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'settings';
                            });
                            Navigator.popAndPushNamed(context, '/settings');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: categoryData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData) {

                      print("SELECTED DAY: ${selectedDay.day}");


                      return Positioned(
                        top: 50,
                        left: 70,
                        child: Container(
                          width: 600,
                          height: 500,
                          child: Card(
                            elevation: 2.0,
                            child: myCalendar(context, CalendarView.month,snapshot),
                          ),
                        ),
                      );
                    }
                  }
                  return const Text("Please wait");
                },

              ),

          Positioned(
            top: 50,
            left: 680,
            child: Container(
              width: 600,
              height: 500,
              child: Card(
                elevation: 2.0,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text((selectedDay.day == DateTime.now().day)?"Today's Appointments": "${selectedDay.day} ${monthsFull[selectedDay.month-1]} Appointments", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),


                      Container(
                        width: 600,
                        height: 400,
                        child: ListView.builder(
                            itemCount: appointmentData.length,
                            itemBuilder: (context,index){


                              if(appointmentData[index].from.day == selectedDay.day){

                                String startTime = "";
                                String endTime = "";




                                String minute = '${appointmentData[index].from.minute}';

                                if(appointmentData[index].from.minute == 0){
                                  minute = '00';
                                }

                                if(appointmentData[index].from.hour >= 12){

                                  if(appointmentData[index].from.hour == 12){
                                    startTime = '${((appointmentData[index].from.hour)).round()}:$minute PM';
                                  }
                                  else{
                                    startTime = '${((appointmentData[index].from.hour)-12).round()}:$minute PM';
                                  }
                                }
                                else{
                                  startTime = '${appointmentData[index].from.hour}:$minute AM';
                                }

                                if(appointmentData[index].to.hour >= 12){

                                  String minute = '${appointmentData[index].to.minute}';

                                  if(appointmentData[index].to.minute == 0){
                                    minute = '00';
                                  }

                                  if(appointmentData[index].to.hour == 12){
                                    endTime = '${((appointmentData[index].to.hour)).round()}:$minute PM';
                                  }
                                  else{
                                    endTime = '${((appointmentData[index].to.hour)-12).round()}:$minute PM';
                                  }
                                }
                                else{
                                  endTime = '${appointmentData[index].to.hour}:$minute AM';
                                }

                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: ListTile(
                                    leading: Container(
                                      width: 180,
                                      child: Row(
                                        children: [
                                          VerticalDivider(color: Colors.blue,),
                                          SizedBox(width: 5,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(child: Text(appointmentData[index].eventName,style: TextStyle(
                                                fontSize: 16,
                                              ),)),
                                              Text("${appointmentData[index].startTime}-${appointmentData[index].endTime}",style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    trailing: Container(
                                      width: 380,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Client Name"),
                                              Text(appointmentData[index].clientName, style: TextStyle(
                                                color: Colors.grey,
                                              ),),
                                            ],
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(left: 10,right: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Client Number"),
                                                Text(appointmentData[index].phoneNumber, style: TextStyle(
                                                  color: Colors.grey,
                                                ),),
                                              ],
                                            ),
                                          ),

                                          appointmentData[index].requiresConfirmation == 'pending-confirmation'?Row(
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: TextButton(
                                                  onPressed: () async {

                                                    setState(() async {
                                                      await databaseService.confirmAppointment(
                                                        selectedCategory,
                                                        currentShopIndex,
                                                        appointmentData[index].appointmentIndex,
                                                      );

                                                      await databaseService.confirmAppointmentForUser(
                                                          appointmentData[index].userIndex,
                                                          appointmentData[index].userAppointmentIndex
                                                      );

                                                    });


                                                  },
                                                  child: Text('Confirm', style: TextStyle(
                                                    color: Colors.white,
                                                  ),),
                                                ),
                                              ),
                                              SizedBox(width: 5,),
                                              Container(
                                                width: 80,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: TextButton(
                                                  onPressed: () async {

                                                    setState(() async {
                                                      await databaseService.declineAppointment(
                                                        selectedCategory,
                                                        currentShopIndex,
                                                        appointmentData[index].appointmentIndex,
                                                        appointmentData[index].declinedAmount + 1,
                                                      );

                                                      await databaseService.declineAppointmentForUser(
                                                          appointmentData[index].userIndex,
                                                          appointmentData[index].userAppointmentIndex
                                                      );

                                                    });


                                                  },
                                                  child: Text('Decline', style: TextStyle(
                                                    color: Colors.white,
                                                  ),),
                                                ),
                                              ),
                                            ],
                                          ):Container(
                                            width: 150,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: TextButton(
                                              onPressed: (){

                                              },
                                              child: Text('Confirmed', style: TextStyle(
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
                              else{
                                return Container();
                              }
                        }),
                      ),

                    ],
                  ),
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

  Widget myCalendar(BuildContext context, CalendarView view, AsyncSnapshot<dynamic> snapshot){
    return SfCalendar(
      key: ValueKey(view),
      view: view,
      initialSelectedDate: selectedDay,
      dataSource: MeetingDataSource(_getDataSource(snapshot)),
      controller: _controller,
      allowedViews: [
        CalendarView.day,
        CalendarView.week,
        CalendarView.month,
        CalendarView.schedule
      ],
      monthViewSettings: MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),
      selectionDecoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.deepPurple, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        shape: BoxShape.rectangle,
      ),
      todayHighlightColor: Colors.deepPurple,
      showNavigationArrow: true,
      onTap: (CalendarTapDetails details){
        setState(() {
          selectedDay = _controller.selectedDate!;
        });
      },
    );
  }

}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    //appointments![index].background
    return Colors.deepPurple;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

List<Meeting> appointmentData = [];

class Meeting {
  Meeting(this.declinedAmount,this.userAppointmentIndex,this.userIndex,this.appointmentIndex,this.phoneNumber,this.requiresConfirmation,this.eventName,this.clientName, this.startTime, this.endTime,this.from, this.to, this.background, this.isAllDay);

  int userIndex;
  int userAppointmentIndex;
  int appointmentIndex;
  String requiresConfirmation;
  String phoneNumber;
  String eventName;
  String clientName;
  String startTime;
  String endTime;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  int declinedAmount;
}
List<Meeting> _getDataSource(AsyncSnapshot<dynamic> snapshot) {
  final List<Meeting> meetings = <Meeting>[];
  appointmentData = [];
  int appointmentIndex = 0;
  while(appointmentIndex < snapshot.data['$currentShopIndex']['appointments']['appointment-amount']+1){

    if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] == 'incomplete'
    || snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] == 'pending-confirmation'){
      final DateTime today = DateTime.now();
      final DateTime startTime = DateTime(
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-year'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-month'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-day'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-hour-actual'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-minutes'],
          0
      );
      final DateTime endTime = DateTime(
        snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-year'],
        snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-month'],
        snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-day'],
        snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-hour-actual'],
        snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-minutes'],
        0,
        0,
      );

      meetings.add(Meeting(
          snapshot.data['$currentShopIndex']['appointments']['declined'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['user-appointment-index'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['user-index'],
          appointmentIndex,
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['client-number'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-name'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['client-name'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-time'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-time'],
          startTime,
          endTime,
          const Color(0xFF0F8644), false));


      appointmentData.add(Meeting(
          snapshot.data['$currentShopIndex']['appointments']['declined'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['user-appointment-index'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['user-index'],
          appointmentIndex,
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['client-number'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-name'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['client-name'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-time'],
          snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-time'],
          startTime,
          endTime,
          const Color(0xFF0F8644), false));
    }
    appointmentIndex++;
  }
  return meetings;
}


