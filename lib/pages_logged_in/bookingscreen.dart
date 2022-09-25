import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:servnn_client_side/pages_logged_in/pos.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../services/database.dart';

class BookingScreen extends StatefulWidget {

  List<GlobalKey> _key = [];
  var currentHeight = 200.0;

  @override
  State<StatefulWidget> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }


  CalendarFormat format = CalendarFormat.week;

  List<DateTime> selectedDay = [];
  List<DateTime> focusedDay = [];

  List<int> startYear = [];
  List<int> startMonth = [];
  List<int> startDay = [];
  List<int> startHour = [];
  List<int> startMinutes = [];


  List<int> endYear = [];
  List<int> endMonth = [];
  List<int> endDay = [];
  List<int> endHour = [];
  List<int> endMinutes = [];
  List<int> currentMinuteGaps = [];
  List<dynamic> currentDayTimings = [];


  List<String> weekDays = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];



  final dateFormat = DateFormat('EEEE yyyy-MMMM-dd');
  DateTime _chosenDate = DateTime.now();

  List<String> currentDateInWords = [];
  List<String> currentDayOfWeek = [];

  List<int> currentEmployeeIndex = [];
  List<bool> onCalender = [];
  List<DateTime> timePicked = [];
  dynamic bookingsPerSlot = {};
  List<List<bool>> passedTimeStatuses = [];

  DatabaseService databaseService = DatabaseService();

  bool initialSetter = false;
  bool initialCalendarSetup = true;
  bool initialSetterForBookings = true;


  int amountOfServicesInCart = 0;
  int amountOfProductsInCart = 0;

  @override
  Widget build(BuildContext context) {


    if(!initialSetter){

      int amountInCartIdx = 0;
      while(amountInCartIdx < cart.length){

        currentDayOfWeek.add('');
        currentDateInWords.add(dateFormat.format(_chosenDate));

        int letterIdx = 0;
        while(letterIdx < currentDateInWords[amountInCartIdx].length){
          if(currentDateInWords[amountInCartIdx][letterIdx] != ' '){
            currentDayOfWeek[amountInCartIdx] += currentDateInWords[amountInCartIdx][letterIdx];
          }
          else{
            break;
          }
          letterIdx++;
        }

        selectedDay.add(DateTime.now());
        focusedDay.add(DateTime.now());
        timePicked.add(DateTime.now());
        widget._key.add(GlobalKey());

        startYear.add(0);
        startMonth.add(0);
        startDay.add(0);
        startHour.add(0);
        startMinutes.add(0);
        passedTimeStatuses.add([]);

        endYear.add(0);
        endMonth.add(0);
        endDay.add(0);
        endHour.add(0);
        onCalender.add(false);
        endMinutes.add(0);

        currentEmployeeIndex.add(0);
        currentTime.add(0);


        if(cart[amountInCartIdx].type == 'Services'){
          amountOfServicesInCart++;
        }
        else{
          amountOfProductsInCart++;
        }

        amountInCartIdx++;
      }

      initialSetter = true;

    }



    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/dashboard');
              },
              icon: Icon(Icons.logout)
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: FutureBuilder(
          future: categoryData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return const Text("There is an error");
              }
              else if(snapshot.hasData){


                if(initialCalendarSetup){

                  int cartIndex = 0;
                  while(cartIndex < cart.length){

                    String from = "";
                    String to = "";
                    int minuteGap = 0;

                    if(cart[cartIndex].serviceLinked){
                      from = snapshot.data['$currentShopIndex']['business-hours'][currentDayOfWeek[cartIndex]]['from'];
                      to = snapshot.data['$currentShopIndex']['business-hours'][currentDayOfWeek[cartIndex]]['to'];
                    }
                    else{
                      from = snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-timings'][currentDayOfWeek[cartIndex]]['from'];
                      to = snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-timings'][currentDayOfWeek[cartIndex]]['to'];
                    }
                    minuteGap = snapshot.data['$currentShopIndex']['services']['${cart[cartIndex].serviceIndex}']['minute-gap'];
                    currentMinuteGaps.add(minuteGap);
                    currentDayTimings.add(createTimeData(from, to, minuteGap));
                    cartIndex++;
                  }
                  initialCalendarSetup = false;
                }



                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),

                    Center(
                      child: Container(
                        height: 2000,
                        width: 1000,
                        child: Card(
                          elevation: 3.0,
                          child: Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  itemCount: cart.length,
                                  itemBuilder: (context,cartIndex){
                                    if(cart[cartIndex].type == "Products"){
                                      return Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Product', style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                            SizedBox(height: 10,),
                                            Text(cart[cartIndex].title),
                                            SizedBox(height: 10,),
                                            Text('Quantity', style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                            SizedBox(height: 10,),
                                            Text('${productAmountInCart[cart[cartIndex].title]}'),
                                            Text('Price', style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                            SizedBox(height: 10,),
                                            Text('${cart[cartIndex].price} EGP'),
                                            Divider(),
                                            SizedBox(height: 50,),
                                          ],
                                        ),
                                      );
                                    }
                                    else if(cart[cartIndex].type == "Memberships"){
                                      return Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Membership', style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                            SizedBox(height: 10,),
                                            Text(cart[cartIndex].title),
                                            SizedBox(height: 10,),
                                            Text('Duration', style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                            SizedBox(height: 10,),
                                            Text('${cart[cartIndex].duration} month/s'),
                                            SizedBox(height: 10,),
                                            Text('Membership Services', style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                            SizedBox(height: 10,),
                                            LimitedBox(
                                              maxHeight: 300,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: cart[cartIndex].membershipServices.length,
                                                  itemBuilder: (context,index){
                                                    return Container(
                                                        margin:EdgeInsets.all(10),
                                                        child: Text(cart[cartIndex].membershipServices[index])
                                                    );
                                                  }
                                                  ),
                                            ),

                                            SizedBox(height: 10,),
                                           cart[cartIndex].membershipDiscountedServices.length > 0? Text('Discounted Services', style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),):Container(),
                                            SizedBox(height: 10,),
                                            cart[cartIndex].membershipDiscountedServices.length > 0?Container(
                                              width: 200,
                                              height: 100,
                                              child: ListView.builder(
                                                  itemCount: cart[cartIndex].membershipDiscountedServices.length,
                                                  itemBuilder: (context,index){
                                                    return Container(
                                                        margin:EdgeInsets.all(10),
                                                        child: Text(cart[cartIndex].membershipDiscountedServices[index])
                                                    );
                                                  }
                                              ),
                                            ):Container(),

                                            Text('Price', style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                            SizedBox(height: 10,),
                                            Text('${cart[cartIndex].price} EGP'),
                                            Divider(),
                                            SizedBox(height: 50,),
                                          ],
                                        ),
                                      );
                                    }
                                    else{
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget> [
                                          SizedBox(height: 50,),
                                          Row(
                                            children: [
                                              Text(cart[cartIndex].title, style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                              SizedBox(width: 15,),
                                              Text(cart[cartIndex].duration, style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                              SizedBox(width: 15,),
                                              Text("${cart[cartIndex].price} EGP", style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                            ],
                                          ),
                                          SizedBox(height: 50,),
                                          buildStaffMembers(cartIndex,snapshot),
                                          SizedBox(
                                            height: widget.currentHeight,
                                            child: TableCalendar(
                                              key: widget._key[cartIndex],
                                              focusedDay:selectedDay[cartIndex],
                                              firstDay: DateTime(1990),
                                              lastDay: DateTime(2050),
                                              calendarFormat: format,
                                              daysOfWeekVisible: true,
                                              calendarStyle: CalendarStyle(
                                                isTodayHighlighted:true,
                                                selectedDecoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.rectangle,
                                                  // borderRadius: BorderRadius.circular(10),
                                                ),

                                                todayTextStyle: TextStyle(color: Colors.black),
                                                selectedTextStyle: TextStyle(color: Colors.black),
                                                todayDecoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:Colors.black,
                                                  ),
                                                  color:Colors.white,
                                                  shape: BoxShape.rectangle,
                                                  //borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              headerStyle: HeaderStyle(
                                                formatButtonVisible: true,
                                                titleCentered: true,
                                                formatButtonShowsNext: false,
                                              ),
                                              selectedDayPredicate: (DateTime date){
                                                return isSameDay(selectedDay[cartIndex], date);
                                              },
                                              onDaySelected: (DateTime selectDay, DateTime focusDay){
                                                setState(() {
                                                  if((focusDay.day >= DateTime.now().day && focusDay.month == DateTime.now().month) || focusDay.month > DateTime.now().month){

                                                    setState(() {

                                                      print('1');

                                                      currentDateInWords[cartIndex] = dateFormat.format(focusDay);
                                                      print('2');
                                                      currentDayOfWeek[cartIndex] = '';
                                                      print('3');
                                                      int letterIdx = 0;
                                                      while(letterIdx < currentDateInWords[cartIndex].length){
                                                        if(currentDateInWords[cartIndex][letterIdx] != ' '){
                                                          currentDayOfWeek[cartIndex] += currentDateInWords[cartIndex][letterIdx];
                                                        }
                                                        else{
                                                          break;
                                                        }
                                                        letterIdx++;
                                                      }
                                                      print('4');

                                                      onCalender[cartIndex] = true;
                                                      selectedDay[cartIndex] = selectDay;
                                                      focusedDay[cartIndex] = focusDay;
                                                      timePicked[cartIndex] = selectedDay[cartIndex];

                                                      print('5');

                                                      String from = "";
                                                      String to = "";

                                                      if(cart[cartIndex].serviceLinked){
                                                        from = snapshot.data['$currentShopIndex']['business-hours'][currentDayOfWeek[cartIndex]]['from'];
                                                        to = snapshot.data['$currentShopIndex']['business-hours'][currentDayOfWeek[cartIndex]]['to'];
                                                      }
                                                      else{
                                                        from = snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-timings'][currentDayOfWeek[cartIndex]]['from'];
                                                        to = snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-timings'][currentDayOfWeek[cartIndex]]['to'];
                                                      }

                                                      print('before');

                                                      currentDayTimings[cartIndex] = createTimeData(from, to, currentMinuteGaps[cartIndex]);

                                                      print('after');
                                                    });
                                                  }
                                                });
                                              },
                                              onFormatChanged: (CalendarFormat _format){
                                                setState((){
                                                  format = _format;
                                                  setState(() {
                                                    if(format == CalendarFormat.week){
                                                      widget.currentHeight = 250;
                                                    }
                                                    else if(format == CalendarFormat.twoWeeks){
                                                      widget.currentHeight = 350;
                                                    }
                                                    else if(format == CalendarFormat.month){
                                                      widget.currentHeight = 400;
                                                    }
                                                  });
                                                });
                                              },
                                            ),
                                          ),
                                          Divider(
                                            height: 5,
                                            color: Colors.black54,
                                            thickness: 1,
                                            //indent: 20,
                                            //endIndent: 20,
                                          ),
                                          //SizedBox(height: 40,),


                                          FutureBuilder(
                                            future: categoryData(),
                                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                              if(snapshot.connectionState == ConnectionState.done){
                                                if(snapshot.hasError){
                                                  return const Text("There is an error");
                                                }
                                                else if(snapshot.hasData){


                                                  print('1s');
                                                  List<bool> conflictingTimes = [];
                                                  passedTimeStatuses[cartIndex] = [];

                                                  int timingIndex = 0;

                                                  while(timingIndex < currentDayTimings[cartIndex].length){
                                                    conflictingTimes.add(false);
                                                    timingIndex++;
                                                  }

                                                  int appointmentIndex = 0;

                                                 if(initialSetterForBookings){

                                                   print('2s');

                                                   // INITIALIZES THE BOOKINGS MAP
                                                   while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                                     // START TIME STORED FROM DATABASE IN VARIABLE
                                                     String startTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-time'];

                                                     // END TIME
                                                     String endTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-time'];


                                                     String staffName = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['member-name'];

                                                     bookingsPerSlot['$startTime-$endTime-$staffName'] = 0;

                                                     appointmentIndex++;
                                                   }

                                                   print('4s');

                                                   // FILLS THE BOOKINGS MAP WITH THE AMOUNT OF APPOINTMENTS PER TIMING
                                                   appointmentIndex = 0;
                                                   while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                                     // START TIME STORED FROM DATABASE IN VARIABLE
                                                     String startTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-time'];

                                                     // END TIME
                                                     String endTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-time'];


                                                     String staffName = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['member-name'];
                                                     print('5s');
                                                     int currentAmountOfBookings = bookingsPerSlot['$startTime-$endTime-$staffName'];
                                                     print('6s');
                                                     currentAmountOfBookings++;
                                                     bookingsPerSlot['$startTime-$endTime-$staffName'] = currentAmountOfBookings;
                                                     print('7s');
                                                     appointmentIndex++;
                                                   }

                                                   initialSetterForBookings = false;
                                                 }

                                                  print('8s');

                                                  timingIndex = 0;
                                                  while(timingIndex < currentDayTimings[cartIndex].length){
                                                    bool isConflicting = false;
                                                    appointmentIndex = 0;
                                                    while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){

                                                      isConflicting = isInConflict(
                                                          cartIndex,
                                                          appointmentIndex,
                                                          cart[cartIndex].title,
                                                          cart[cartIndex].serviceLinked?"none":snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-name'],
                                                          selectedDay[cartIndex].day,
                                                          selectedDay[cartIndex].month,
                                                          selectedDay[cartIndex].year,
                                                          currentDayTimings[cartIndex]['$timingIndex'],
                                                          snapshot
                                                      );

                                                      if(isConflicting){
                                                        conflictingTimes[timingIndex] = true;
                                                        break;
                                                      }

                                                      appointmentIndex++;
                                                    }
                                                    timingIndex++;
                                                  }


                                                  timingIndex = 0;
                                                  while(timingIndex < currentDayTimings[cartIndex].length){

                                                    print('timing index: $timingIndex');

                                                    String currentTime = currentDayTimings[cartIndex]['$timingIndex'];
                                                    String currentHourString = getHour(currentTime);

                                                    int currentHour = int.parse(getHour(currentHourString));
                                                    String end = getAMorPM(currentDayTimings[cartIndex]['$timingIndex']);

                                                    String minuteString = getMinute(currentDayTimings[cartIndex]['$timingIndex']);
                                                    int minute = 0;

                                                    if(minuteString != '00'){
                                                      minute = int.parse(minuteString);
                                                    }

                                                    if(end == 'PM'){
                                                      if(currentHour < 12){
                                                        currentHour += 12;
                                                      }
                                                    }
                                                    else{
                                                      if(currentHour == 12){
                                                        currentHour -= 12;
                                                      }
                                                    }


                                                    bool timePassed = passedTime(currentHour, minute, selectedDay[cartIndex].day, selectedDay[cartIndex].month, selectedDay[cartIndex].year);
                                                    passedTimeStatuses[cartIndex].add(timePassed);

                                                    timingIndex++;
                                                  }

                                                  int passedIdx = 0;
                                                  while(passedIdx < passedTimeStatuses[cartIndex].length){

                                                    print('TIME PASSED: ${passedTimeStatuses[cartIndex][passedIdx]}');

                                                    passedIdx++;
                                                  }

                                                  print('9s');


                                                  return Container(
                                                    height: 100,
                                                    child: ListView.builder(
                                                      itemCount: currentDayTimings[cartIndex].length,
                                                      scrollDirection: Axis.horizontal,
                                                      physics: ScrollPhysics(),
                                                      itemBuilder: (context, index){

                                                        if(conflictingTimes[index] || passedTimeStatuses[cartIndex][index]){

                                                          return Container();

                                                        }
                                                        else{

                                                          return MaterialButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                currentTime[cartIndex] = index;
                                                              });
                                                            },
                                                            child: timingsData(
                                                                currentDayTimings[cartIndex]['$index'],
                                                                index,
                                                                snapshot,
                                                                cartIndex
                                                            ),
                                                          );


                                                        }
                                                      },
                                                    ),
                                                  );
                                                }
                                              }
                                              return const Text("Please wait");
                                            },

                                          ),

                                          SizedBox(height: 20,),

                                        ],
                                      );
                                    }
                                  }),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 54,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x17000000),
                            offset: Offset(0, 15),
                            blurRadius: 15,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () async {

                          int appointmentIndex = snapshot.data['$currentShopIndex']['appointments']['appointment-amount']+1;

                          int cartIndex = 0;
                          print('cart length: ${cart.length}');
                          while(cartIndex < cart.length){

                            if(cart[cartIndex].type == 'Services'){
                              print('IN WHILE');
                              print('1');
                              startYear[cartIndex] = timePicked[cartIndex].year;
                              startMonth[cartIndex] = timePicked[cartIndex].month;
                              startDay[cartIndex] = timePicked[cartIndex].day;

                              print('2');
                              String startHourString = getHour(currentDayTimings[cartIndex]['${currentTime[cartIndex]}']);
                              print('3');
                              String startMinuteString = getMinute(currentDayTimings[cartIndex]['${currentTime[cartIndex]}']);
                              print('4');
                              startHour[cartIndex] = int.parse(startHourString);
                              print('5');
                              startMinutes[cartIndex] = int.parse(startMinuteString);
                              print('6');
                              String startTimeEnd = getAMorPM(currentDayTimings[cartIndex]['${currentTime[cartIndex]}']);
                              print('7');
                              int startHourActual = 0;
                              int endHourActual = 0;


                              if(startTimeEnd == 'PM'){
                                if(startHour[cartIndex] == 12){
                                  startHourActual = startHour[cartIndex];
                                }
                                else{
                                  startHourActual = startHour[cartIndex] + 12;
                                }
                              }
                              else{
                                startHourActual = startHour[cartIndex];
                              }

                              print('8');
                              int minutes = getServiceDurationInMinutes(cart[cartIndex].duration);
                              print('9');
                              String endHourString = generateNewHour(startMinuteString, startHourString, minutes);
                              print('10');
                              endHour[cartIndex] = int.parse(endHourString);
                              print('11');


                              String endTime = generateEndTime(currentDayTimings[cartIndex]['${currentTime[cartIndex]}'], cart[cartIndex].duration);

                              print('12');


                              String endMinutesString = getMinute(endTime);
                              endMinutes[cartIndex] = int.parse(endMinutesString);
                              print('13');
                              String endTimeEnd = getAMorPM(endTime);
                              print('14');
                              if(endTimeEnd == 'PM'){
                                if(endHour[cartIndex] == 12){
                                  endHourActual = endHour[cartIndex];
                                }
                                else{
                                  endHourActual = endHour[cartIndex] + 12;
                                }
                              }
                              else{
                                endHourActual = endHour[cartIndex];
                              }
                              print('15');
                              String startTime = currentDayTimings[cartIndex]['${currentTime[cartIndex]}'];
                              print('16');


                              await databaseService.addAppointment(
                                'incomplete',
                                currentDayOfWeek[cartIndex],
                                selectedCategory,
                                currentShopIndex,
                                appointmentIndex,
                                snapshot.data['$currentShopIndex']['appointments']['complete'],
                                snapshot.data['$currentShopIndex']['appointments']['incomplete']+1,
                                startYear[cartIndex],
                                startMonth[cartIndex],
                                startDay[cartIndex],
                                startHour[cartIndex],
                                startHourActual,
                                startMinutes[cartIndex],
                                startYear[cartIndex],
                                startMonth[cartIndex],
                                startDay[cartIndex],
                                endHour[cartIndex],
                                endHourActual,
                                endMinutes[cartIndex],
                                currentClient,
                                serviceBooked[cartIndex],
                                servicePrice[cartIndex],
                                cart[cartIndex].serviceLinked?"none":snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-name'],
                                cart[cartIndex].serviceLinked?"none":snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-role'],
                                cart[cartIndex].type,
                                serviceDuration[cartIndex],
                                startTime,
                                endTime,
                              );
                            }
                            else if(cart[cartIndex].type == 'Memberships'){


                              await databaseService.addMember(
                                  selectedCategory,
                                  currentShopIndex,
                                  snapshot.data['$currentShopIndex']['members-amount']+1,
                                  cart[cartIndex].title,
                                  currentClient,
                                  currentClientEmail,
                                  DateTime.now().day,
                                  DateTime.now().month,
                                  DateTime.now().year,
                              );

                              /*
                              await databaseService.addUserMembership(
                                  currentClientIndex,
                                  snapshot.data['$currentShopIndex']['members-amount']+1,
                                  cart[cartIndex].title,
                                  snapshot.data['$currentShopIndex']['shop-name'],
                                  DateTime.now().day,
                                  DateTime.now().month,
                                  DateTime.now().year,
                              );
                              */

                            }
                            else{
                              int productIndex = 0;
                              while(productIndex <= snapshot.data['$currentShopIndex']['products-amount']){

                                if(cart[cartIndex].title == snapshot.data['$currentShopIndex']['products']['$productIndex']['product-name']){
                                  await databaseService.updateProductData(
                                      selectedCategory,
                                      currentShopIndex,
                                      snapshot.data['$currentShopIndex']['products']['$productIndex']['product-stock'] - 1,
                                      productIndex
                                  );
                                  break;
                                }

                                productIndex++;
                              }

                              int clientIndex= 0;
                              while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                                if(currentClient == snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']) {
                                  await databaseService.updateAmountPaid(
                                    selectedCategory,
                                    clientIndex,
                                    currentShopIndex,
                                    snapshot.data['$currentShopIndex']['clients']['$clientIndex']['amount-paid'] + int.parse(cart[cartIndex].price),
                                  );
                                  break;
                                }
                                clientIndex++;
                              }


                              await databaseService.addAppointment(
                                'complete',
                                '',
                                selectedCategory,
                                currentShopIndex,
                                appointmentIndex,
                                snapshot.data['$currentShopIndex']['appointments']['complete']+1,
                                snapshot.data['$currentShopIndex']['appointments']['incomplete'],
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                currentClient,
                                cart[cartIndex].title,
                                cart[cartIndex].price,
                                '',
                                '',
                                'Products',
                                '',
                                '',
                                '',
                              );
                            }

                            appointmentIndex++;
                            cartIndex++;
                          }

                          currentTotal = 0;
                          cart.clear();
                          serviceBooked.clear();
                          serviceDuration.clear();
                          servicePrice.clear();

                          Navigator.pushNamed(context, '/POS');

                        },
                        child: Text(
                          (amountOfServicesInCart > 1 && amountOfProductsInCart  == 0) ? 'Confirm Appointments' :
                          (amountOfProductsInCart > 1 && amountOfServicesInCart > 1)?'Confirm Appointments and Purchases':
                          (amountOfProductsInCart == 0 && amountOfServicesInCart == 1)?'Confirm Appointment':
                          (amountOfProductsInCart == 1 && amountOfServicesInCart == 0)?'Confirm Purchase':
                          (amountOfProductsInCart == 1 && amountOfServicesInCart == 1)?'Confirm Appointment and Purchase':
                          (amountOfProductsInCart > 1 && amountOfServicesInCart == 1)?'Confirm Appointment and Purchases':
                          (amountOfProductsInCart == 1 && amountOfServicesInCart > 1)?'Confirm Appointments and Purchase':'Confirm Purchases',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                  ],
                );
              }
            }
            return const Text("Please wait");
          },

        ),
      ),
    );
  }


  Widget timingsData(String time, int index, AsyncSnapshot<dynamic> snapshot, int cartIndex) {
    return Container(
      width: 130,
      height: 100,
      margin: EdgeInsets.only(left: 20, top: 10),
      decoration: BoxDecoration(
        color: index == currentTime[cartIndex]?Colors.blue:Color(0xffEEEEEE),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 2, left:5),
            child: Icon(
              Icons.access_time,
              color: Colors.black,
              size: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 2, right:5),
            child: Text(time,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStaffMembers(cartIndex,AsyncSnapshot<dynamic> snapshot){
    if(cart[cartIndex].serviceLinked == false){
      return Column(
        children: [
          Container(
            height: 100,
            child: ListView.builder(
              itemCount: snapshot.data['$currentShopIndex']['staff-members-amount']+1,
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              itemBuilder: (context, index){
                if(index != 0){
                  if(snapshot.data['$currentShopIndex']['staff-members']['${index-1}']['member-role'] != 'Owner'
                      && snapshot.data['$currentShopIndex']['staff-members']['${index-1}']['member-role'] != 'Manager'
                      && findService(cart[cartIndex].title, index-1, snapshot)
                  ){
                    return Column(
                      children: [
                        MaterialButton(
                          onPressed: (){
                            setState(() {
                              currentEmployeeIndex[cartIndex] = index-1;
                            });
                            print("CURRENT EMPLOYEE: ${currentEmployeeIndex[cartIndex]}");
                          },
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundColor: (currentEmployeeIndex[cartIndex] == index-1)?Colors.greenAccent: Colors.transparent,
                            child: CircleAvatar(
                              radius: 28.0,
                              backgroundColor: Colors.transparent,
                              child: ClipRRect(
                                child: Image.asset('assets/no-profile-picture.jpg'),
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10,)),
                        Text(snapshot.data['$currentShopIndex']['staff-members']['${index-1}']['member-name'],
                          style: TextStyle(
                            fontWeight: (currentEmployeeIndex[cartIndex] == index-1)?FontWeight.bold:FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }
                  else{
                    return Container();
                  }
                }
                else if(index == 0){
                  return Column(
                    children: [
                      MaterialButton(
                        onPressed: (){
                          setState(() {
                            currentEmployeeIndex[cartIndex] = index;

                          });
                          print("CURRENT EMPLOYEE: ${currentEmployeeIndex[cartIndex]}");
                        },
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: (currentEmployeeIndex[cartIndex] == index)?Colors.greenAccent: Colors.transparent,
                          child: CircleAvatar(
                            radius: 28.0,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              child: Image.asset('assets/no-profile-picture.jpg'),
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10,)),
                      Text('Anybody',
                        style: TextStyle(
                          fontWeight: (currentEmployeeIndex[cartIndex] == index)?FontWeight.bold:FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }
                else{
                  return Container();
                }
              },
            ),
          ),
          Divider(
            height: 10,
            color: Colors.black54,
            thickness: 1,
            //indent: 20,
            //endIndent: 20,
          ),
        ],
      );
    }
    else{
      return Container();
    }
  }

  // GETS MINUTE FROM INPUT STRING
  String getMinute(String time){

    // WHERE THE MINUTE WILL BE STORES
    String minute = "";

    // CHARACTER INDEX IN TIME STRING (EXAMPLE "10:00 PM" IS TIME STRING)
    int charIndex = 0;

    // CHECKS IF "charIndex" IS AT THE FIRST NUMBER OF THE MINUTE
    bool reachedMinute = false;

    while(charIndex < time.length){


      // IF "reachedMinute" THEN ADD THE CURRENT CHARACTER TO THE MINUTE STRING
      if(reachedMinute){
        minute += time[charIndex];
      }

      // IF CURRENT CHARACTER IS ':', THIS MEANS NEXT CHARACTER IS THE FIRST NUMBER OF THE MINUTE
      if(time[charIndex] == ':'){
        reachedMinute = true;
      }

      // IF CURRENT CHARACTER IS " " (A SPACE), THEN THE LAST
      // NUMBER OF THE MINUTE IS DONE SO RETURN THE MINUTE
      else if(time[charIndex] == " "){
        return minute;
      }

      charIndex++;
    }

    return minute;
  }


  // GETS HOUR FROM TIME STRING
  String getHour(String time){

    // WHERE THE HOUR WILL BE STORED
    String hour = "";

    // CHARACTER INDEX IN TIME STRING (EXAMPLE "10:00 PM" IS TIME STRING)
    int charIndex = 0;

    while(charIndex < time.length){

      if(time[charIndex] == ':'){
        return hour;
      }
      else{
        hour += time[charIndex];
      }

      charIndex++;
    }

    return hour;
  }


  // GETS MINUTE FROM INPUT STRING
  String generateNewMinute(int minuteGap, String currentMinute){

    // WHERE THE MINUTE WILL BE STORES
    String newMinute = "";

    int currentMinuteInt = int.parse(currentMinute);
    int newMinuteInt = currentMinuteInt + minuteGap;

    if(newMinuteInt >= 60){

      if((newMinuteInt % 2) == 0){
        newMinute = '00';
      }
      else{
        newMinute = '${newMinuteInt - 60}';
      }

    }
    else if(newMinuteInt < 10){
      newMinute = '0$newMinuteInt';
    }
    else{
      newMinute = '$newMinuteInt';
    }

    return newMinute;

  }

  // GETS MINUTE FROM INPUT STRING
  String generateNewHour(String oldMinute, String currentHour, int minuteGap){

    // WHERE THE NEW HOUR WILL BE STORED
    String newHour = "";

    int oldMinuteInt = int.parse(oldMinute);

    int newMinute = oldMinuteInt + minuteGap;

    int minuteDifference = newMinute - oldMinuteInt;

    int hoursPassed = 0;

    if(newMinute >= 60){
      hoursPassed = (minuteDifference / 60).ceil();
    }

    int currentHourInt = int.parse(currentHour);
    int newHourInt = currentHourInt + hoursPassed;

    if(newHourInt > 12){
      newHourInt = newHourInt - 12;
    }


    newHour = '$newHourInt';

    return newHour;

  }

  String getAMorPM(String time){

    // WHERE THE MINUTE WILL BE STORES
    String output = "";

    // CHARACTER INDEX IN TIME STRING (EXAMPLE "10:00 PM" IS TIME STRING)
    int charIndex = 0;

    // CHECKS IF "charIndex" IS AT THE FIRST NUMBER OF THE MINUTE
    bool reachedLetter = false;

    while(charIndex < time.length){

      if(time[charIndex] == 'A' || time[charIndex] == 'P'){
        reachedLetter = true;
      }

      if(reachedLetter){
        output += time[charIndex];
      }

      charIndex++;
    }

    return output;
  }

  String createAMorPM(String oldHour, String newHour, String currentEnd){

    // WHERE THE 'AM' OR 'PM' WILL BE STORES
    String output = "";

    int oldHourInt = int.parse(oldHour);
    int newHourInt = int.parse(newHour);

    if(oldHourInt < 12 && newHourInt <= 12){

      if(newHourInt == 12){
        if(currentEnd == 'AM'){
          output = 'PM';
        }
        else{
          output = 'AM';
        }
      }
      else if(oldHourInt > newHourInt){
        if(currentEnd == 'AM'){
          output = 'PM';
        }
        else{
          output = 'AM';
        }
      }
      else{
        output = currentEnd;
      }
    }
    else{
      output = currentEnd;
    }

    return output;
  }


  dynamic createTimeData(String startTime, String endTime, int minuteGap){


    print('start time: $startTime');
    print('end time: $endTime');

    dynamic timeDataMap = {};

    String currentTime = startTime;

    int timeDataMapIndex = 0;


    while(currentTime != endTime){

      // CURRENT INDEX IN TIME DATA MAP IS EQUAL TO THE CURRENT TIME


      timeDataMap['$timeDataMapIndex'] = currentTime;

      String currentHour = getHour(currentTime);

      String currentMinute = getMinute(currentTime);

      // THIS STRING WILL GET EITHER 'AM' OR 'PM' FROM THE CURRENT TIME
      String currentEnd = getAMorPM(currentTime);

      currentTime = generateNewTime(currentTime, currentHour, currentMinute, currentEnd, minuteGap);

      timeDataMapIndex++;

    }

    print('done with while here');

    timeDataMap['$timeDataMapIndex'] = currentTime;
    print('done with updating');

    return timeDataMap;

  }


  String generateNewTime(String currentTime,String currentHour, String currentMinute, String currentEnd, int minuteGap){

    // THIS STRING WILL STORE THE NEW HOUR
    String newHour = generateNewHour(currentMinute, currentHour, minuteGap);

    // THIS STRING WILL STORE THE NEW MINUTE USING THE MINUTE GAP
    String newMinute = generateNewMinute(minuteGap, currentMinute);

    // THIS STRING WILL STORE THE NEW 'AM' OR 'PM' DEPENDING ON THE NEW HOUR
    String newEnd = createAMorPM(currentHour, newHour, currentEnd);

    // UPDATE CURRENT TIME TO BE THE NEW TIME
    currentTime = '$newHour:$newMinute $newEnd';

    return currentTime;

  }

  String generateEndTime(String startTime, String serviceDuration){

    // OUTPUT
    String endTime = "";

    String endHour = "";
    String endMinute = "";

    // Hour duration and minute duration
    int hourDuration = getServiceDurationHour(serviceDuration);
    print('hr duration');
    int minuteDuration = getServiceDurationMinute(serviceDuration);
    print('min duration');
    String startHour = getHour(startTime);
    String startMinute = getMinute(startTime);

    int startHourInt = int.parse(startHour);

    // THIS STRING WILL STORE THE END HOUR
    int endHourInt = generateEndHour(startHour,hourDuration);
    print('end hr done');
    // THIS STRING WILL STORE THE NEW MINUTE USING THE MINUTE GAP
    int endMinuteInt = generateEndMinute(startMinute, minuteDuration);
    print('end min done');
    if(endMinuteInt > 60 || endMinuteInt == 0 || endMinuteInt == 60){
      endHourInt++;

      if(endHourInt > 12){
        endHourInt -= 12;
      }

    }

    bool pastTwelve = reachedPastTwelve(startHourInt,endHourInt);
    String startTimeEnd = getAMorPM(startTime);
    print('startTime done');

    print('end minute: $endMinuteInt');

    if(endMinuteInt == 60 || endMinuteInt == 0){

      if(pastTwelve){
        if(startTimeEnd == 'AM'){
          endTime = '$endHourInt:00 PM';
        }
        else{
          endTime = '$endHourInt:00 AM';
        }
      }
      else{
        endTime = '$endHourInt:00 $startTimeEnd';
      }
    }
    else if(endMinuteInt > 60){

      String updatedEndMinute = '${endMinuteInt - 60}';

      if(pastTwelve){
        if(startTimeEnd == 'AM'){
          endTime = '$endHourInt:$updatedEndMinute PM';
        }
        else{
          endTime = '$endHourInt:$updatedEndMinute AM';
        }
      }
      else{
        endTime = '$endHourInt:$updatedEndMinute $startTimeEnd';
      }
    }
    else{

      endMinute = '$endMinuteInt';

      if(pastTwelve){
        if(startTimeEnd == 'AM'){
          endTime = '$endHourInt:$endMinute PM';
        }
        else{
          endTime = '$endHourInt:$endMinute AM';
        }
      }
      else{
        endTime = '$endHourInt:$endMinute $startTimeEnd';
      }
    }

    return endTime;

  }

  bool reachedPastTwelve(int startHour, int endHour) {
    bool pastTwelve = true;
    int hourIndex = 0;

    List<int> hoursToLoop = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

    while (hourIndex < hoursToLoop.length) {
      if (hoursToLoop[hourIndex] == startHour) {
        hourIndex++;
        while (hourIndex < hoursToLoop.length) {
          if (hoursToLoop[hourIndex] == endHour) {
            pastTwelve = false;
            break;
          }
          hourIndex++;
        }
        break;
      }

      hourIndex++;
    }

    return pastTwelve;
  }

  int generateEndHour(String startHour, int hourDuration){

    int startHourInt = int.parse(startHour);
    int endHour = startHourInt + hourDuration;

    if(endHour > 12){
      endHour -= 12;
    }

    return endHour;


  }

  int generateEndMinute(String startMinute, int minuteDuration){

    int startMinuteInt = int.parse(startMinute);
    print('start minute: $startMinuteInt');
    print('minute duration: $minuteDuration');
    int endMinute = startMinuteInt + minuteDuration;


    return endMinute;


  }



  int getServiceDurationInMinutes(String serviceDuration){

    int serviceDurationInMinutes = 0;

    String hour = '';
    String minute = '';

    int durationIndex = 0;
    while(durationIndex < serviceDuration.length){

      if(serviceDuration[durationIndex] == 'h'){

        durationIndex++;

        while(serviceDuration[durationIndex] != 'm'){
          minute += serviceDuration[durationIndex];
          durationIndex++;
        }
        break;
      }
      else{
        hour += serviceDuration[durationIndex];
      }

      durationIndex++;
    }

    int hourInt = int.parse(hour);
    int minuteInt = int.parse(minute);

    serviceDurationInMinutes = (hourInt * 60) + minuteInt;

    return serviceDurationInMinutes;


  }

  int getServiceDurationHour(String serviceDuration){

    String hour = '';

    int durationIndex = 0;
    while(durationIndex < serviceDuration.length){
      if(serviceDuration[durationIndex] == 'h'){
        break;
      }
      else{
        hour += serviceDuration[durationIndex];
      }
      durationIndex++;
    }

    int hourInt = int.parse(hour);
    return hourInt;

  }

  int getServiceDurationMinute(String serviceDuration){


    print('service duration: $serviceDuration');
    String minute = '';

    int durationIndex = 0;
    while(durationIndex < serviceDuration.length){
      if(serviceDuration[durationIndex] == 'h'){
        print('reached here');
        durationIndex++;
        while(serviceDuration[durationIndex] != 'm'){
          minute += serviceDuration[durationIndex];
          durationIndex++;
        }
        print('done while minute');
        break;
      }
      durationIndex++;
    }

    print('almost');

    int minuteInt = int.parse(minute);
    print('converted minute');
    return minuteInt;

  }

  bool passedTime(int hour, int minute, int day, int month, int year) {
    if(DateTime.now().day == day && DateTime.now().month == month && DateTime.now().year == year) {
      if(hour < DateTime.now().hour) {
        return true;
      }
      else if(hour == DateTime.now().hour) {
        if (minute < DateTime.now().minute) {
          return true;
        }
      }
    }
    return false;
  }



  bool isInConflict(int cartIndex, int appointmentIndex, String serviceName, String staffName, int day, int month, int year,String currentTime, AsyncSnapshot<dynamic> snapshot){

    // IF SERVICE NAME IN THE CURRENT APPOINTMENT IS EQUAL TO CURRENT SERVICE TO BE BOOKED
    // AND STAFF MEMBER NAME IN THE CURRENT APPOINTMENT IS EQUAL TO THE CURRENT STAFF MEMBER SELECTED
    // AND THE DAY, MONTH, AND YEAR IN THE CURRENT APPOINTMENT ARE EQUAL TO WHAT IS SELECTED IN THE CALENDAR
    // THEN WE CAN BEGIN TO CHECK IF THE TIME SELECTED IS OCCUPIED OR NOT

    if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] == 'incomplete'){
      //print('X');
      if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['member-name'] == staffName){
        //print('B');
        if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-day'] == day){
          //  print('C');
          if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-month'] == month){
            //      print('D');
            if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-year'] == year){

              // print('EQUAL');
              // START TIME STORED FROM DATABASE IN VARIABLE
              String startTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-time'];

              print('start time: $startTime');

              // END TIME
              String endTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-time'];
              print('end time: $endTime');

              // FUNCTION THAT CHECKS IF CURRENT TIME IS ALREADY OCCUPIED
              bool checkOccupied = isOccupied(startTime, endTime, currentTime, currentMinuteGaps[cartIndex]);

              // FUNCTION THAT GETS THE DURATION OF A SERVICE IN MINUTES
              int currentServiceDuration = getServiceDurationInMinutes(cart[cartIndex].duration);

              // FUNCTION THAT CHECKS IF THE CURRENT TIME WILL CLASH WITH ANOTHER APPOINTMENT
              // GIVEN THE DURATION OF THE SERVICE
              bool checkClashing = isClashing(startTime, currentTime,currentServiceDuration);



              print('CURRENT TIME: $currentTime');
              if(checkClashing || checkOccupied){

                print('$currentTime clashing for $startTime-$endTime');
                print(' ');

                if(bookingsPerSlot['$startTime-$endTime-$staffName'] >= snapshot.data['$currentShopIndex']['services']['${cart[cartIndex].serviceIndex}']['max-amount-per-timing']){
                  return true;
                }
                else{
                  return false;
                }
              }


            }
          }
        }
      }
    }


    return false;

  }


  bool isClashing(String startTime, String currentTime, int currentServiceDuration){

    String startHour = getHour(startTime);
    String currentHour = getHour(currentTime);


    int startHourInt = int.parse(startHour);
    int currentHourInt = int.parse(currentHour);

    int hourDifference = 0;

    List<int> hours = [1,2,3,4,5,6,7,8,9,10,11,12];



    int hourIndex = 0;

    while(hours[hourIndex] != currentHourInt){
      hourIndex++;
    }

    while(hours[hourIndex] != startHourInt){

      hourDifference++;
      hourIndex++;

      if(hourIndex == hours.length){
        hourIndex = 0;
      }

    }

    String startMinute = getMinute(startTime);
    String currentMinute = getMinute(currentTime);

    int startMinuteInt = int.parse(startMinute);
    int currentMinuteInt = int.parse(currentMinute);

    int minuteDifference = 0;

    if(startMinuteInt > currentMinuteInt){
      minuteDifference = startMinuteInt - currentMinuteInt;
    }
    else{
      minuteDifference = currentMinuteInt - startMinuteInt;
    }

    int hourToMinutes = hourDifference * 60;

    int totalMinutes = 0;

    if(startMinuteInt > currentMinuteInt){
      totalMinutes = hourToMinutes + minuteDifference;
    }
    else{
      totalMinutes = hourToMinutes - minuteDifference;
    }

    if(currentServiceDuration > totalMinutes){
      return true;
    }

    return false;


  }

  bool isOccupied(String startTime, String endTime, String currentTime, int currentMinuteGap){

    String tempTime = startTime;



    while(tempTime != endTime){

      String endHour = getHour(endTime);
      String endMinute = getMinute(endTime);
      String endEnd = getAMorPM(endTime);

      String tempHour = getHour(tempTime);
      String tempMinute = getMinute(tempTime);
      String tempEnd = getAMorPM(tempTime);

      /*
      if((tempHour == endHour) && (tempEnd == endEnd)){
        if(int.parse(tempMinute) > int.parse(endMinute)){
          return true;
        }
      }
      else{

      }
      */
      print('TEMP TIME OUT: ${tempTime}');
      if(tempTime == currentTime){
        print(' ');
        print('TEMP TIME: $tempTime');
        print('CURRENT TIME: $currentTime');
        return true;
      }



      String newTime = generateNewTime(tempTime, tempHour, tempMinute, tempEnd, currentMinuteGap);
      tempTime = newTime;

    }
    return false;
  }

  // Checks if staff member at "staffIndex" has the current cart's service title in their services
  bool findService(String service, int staffIndex, AsyncSnapshot<dynamic> snapshot){

    int serviceIndex = 0;
    while(serviceIndex < snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-services-amount']){

      if(service == snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-services']['$serviceIndex']){
        return true;
      }

      serviceIndex++;
    }

    return false;
  }



}