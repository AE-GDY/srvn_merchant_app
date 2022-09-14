import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
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


  List<List<bool>> availableTimes = [];



  CalendarFormat format = CalendarFormat.week;
  List<DateTime> selectedDay = [];
  List<DateTime> focusedDay = [];

  List<int> startYear = [];
  List<int> startMonth = [];
  List<int> startDay = [];
  List<int> startHour = [];
  List<int> startMinutes = [];

  List<List<String>> timingsOnDayList = [];
  List<List<String>> serviceDurationOnDayList = [];

  List<int> endYear = [];
  List<int> endMonth = [];
  List<int> endDay = [];
  List<int> endHour = [];
  List<int> endMinutes = [];
  List<int> timingAmount = [];
  List<int> currentMinuteGaps = [];
  List<dynamic> currentDayTimings = [];


  List<String> weekDays = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];



  final dateFormat = DateFormat('EEEE yyyy-MMMM-dd');
  DateTime _chosenDate = DateTime.now();


  bool initialSetter = false;
  List<String> currentDateInWords = [];
  List<String> currentDayOfWeek = [];

  List<int> currentEmployeeIndex = [];
  List<bool> onCalender = [];
  List<DateTime> timePicked = [];
  List<int> currentBarberTimingIdx = [];

  List<dynamic> bookingsPerSlot = [];




  DatabaseService databaseService = DatabaseService();


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



        availableTimes.add([]);

        selectedDay.add(DateTime.now());
        focusedDay.add(DateTime.now());
        timePicked.add(DateTime.now());
        widget._key.add(GlobalKey());

        startYear.add(0);
        startMonth.add(0);
        startDay.add(0);
        startHour.add(0);
        startMinutes.add(0);

        endYear.add(0);
        endMonth.add(0);
        endDay.add(0);
        endHour.add(0);
        onCalender.add(false);
        endMinutes.add(0);
        timingAmount.add(0);
        timingsOnDayList.add([]);
        serviceDurationOnDayList.add([]);

        currentEmployeeIndex.add(0);
        currentBarberTimingIdx.add(0);
        currentTime.add(0);

        amountInCartIdx++;
      }

      initialSetter = true;

    }

    bool initialCalendarSetup = true;

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



                return Center(
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
                                  return Column(
                                    children: [
                                      Text(cart[cartIndex].title),
                                      Text(cart[cartIndex].price),
                                      Container(
                                        width: 150,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {

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
                                                snapshot.data['$currentShopIndex']['appointments']['appointment-amount']+1,
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
                                                ''
                                            );

                                            setState(() {
                                              cart.remove(cart[cartIndex]);
                                            });

                                            if(cart.isEmpty){
                                              Navigator.pushNamed(context, '/POS');
                                            }

                                          },
                                          child: Text("Confirm Purchase", style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                        ),
                                      ),
                                      Divider(),
                                      SizedBox(height: 50,),
                                    ],
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
                                                  availableTimes[cartIndex] = [];

                                                  currentDateInWords[cartIndex] = dateFormat.format(focusDay);
                                                  currentDayOfWeek[cartIndex] = '';
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

                                                  onCalender[cartIndex] = true;
                                                  selectedDay[cartIndex] = selectDay;
                                                  focusedDay[cartIndex] = focusDay;
                                                  timePicked[cartIndex] = selectedDay[cartIndex];



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


                                                  
                                                  currentDayTimings[cartIndex] = createTimeData(from, to, currentMinuteGaps[cartIndex]);



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
                                          int serviceIndex = 0;
                                          if(snapshot.connectionState == ConnectionState.done){
                                            if(snapshot.hasError){
                                              return const Text("There is an error");
                                            }
                                            else if(snapshot.hasData){


                                              List<bool> conflictingTimes = [];

                                              int timingIndex = 0;

                                              while(timingIndex < currentDayTimings[cartIndex].length){
                                                conflictingTimes.add(false);
                                                timingIndex++;
                                              }


                                              dynamic bookings = {};
                                              // INITIALIZES THE BOOKINGS MAP
                                              int appointmentIndex = 0;
                                              while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                                // START TIME STORED FROM DATABASE IN VARIABLE
                                                String startTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-time'];

                                                // END TIME
                                                String endTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-time'];


                                                String staffName = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['member-name'];

                                                bookings['$startTime-$endTime-$staffName'] = 0;

                                                appointmentIndex++;
                                              }

                                              bookingsPerSlot.add(bookings);


                                              // FILLS THE BOOKINGS MAP WITH THE AMOUNT OF APPOINTMENTS PER TIMING
                                              appointmentIndex = 0;
                                              while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                                // START TIME STORED FROM DATABASE IN VARIABLE
                                                String startTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-time'];

                                                // END TIME
                                                String endTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-time'];


                                                String staffName = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['member-name'];

                                                int currentAmountOfBookings = bookingsPerSlot[cartIndex]['$startTime-$endTime-$staffName'];
                                                currentAmountOfBookings++;
                                                bookingsPerSlot[cartIndex]['$startTime-$endTime-$staffName'] = currentAmountOfBookings;

                                                appointmentIndex++;
                                              }

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


                                              return Container(
                                                height: 100,
                                                child: ListView.builder(
                                                  itemCount: currentDayTimings[cartIndex].length,
                                                  scrollDirection: Axis.horizontal,
                                                  physics: ScrollPhysics(),
                                                  itemBuilder: (context, index){

                                                    if(!conflictingTimes[index]){

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
                                                    else{
                                                      return Container();
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


                                            startYear[cartIndex] = timePicked[cartIndex].year;
                                            startMonth[cartIndex] = timePicked[cartIndex].month;
                                            startDay[cartIndex] = timePicked[cartIndex].day;
                                            int startHourActual = 0;

                                            int currentTimeIdx = 0;
                                            String startHourString = '';

                                            int serviceIndex = 0;

                                            String currentTimeString = '';

                                            if(cart[cartIndex].serviceLinked){
                                              if(cart[cartIndex].type == 'Services'){
                                                while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){
                                                  if(cart[cartIndex].title == snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name']){
                                                    break;
                                                  }
                                                  serviceIndex++;
                                                }
                                                currentTimeString = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-timings']['${currentDayOfWeek[cartIndex]}']['${currentTime[cartIndex]}'];
                                              }
                                              else{
                                                while(serviceIndex < snapshot.data['$currentShopIndex']['packages-amount']){
                                                  if(cart[cartIndex].title == snapshot.data['$currentShopIndex']['packages']['$serviceIndex']['package-name']){
                                                    break;
                                                  }
                                                  serviceIndex++;
                                                }
                                                currentTimeString = snapshot.data['$currentShopIndex']['packages']['$serviceIndex']['package-timings']['${currentDayOfWeek[cartIndex]}']['${currentTime[cartIndex]}'];
                                              }
                                            }
                                            else{
                                              currentTimeString = snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-availability']['${currentDayOfWeek[cartIndex]}']['${currentTime[cartIndex]}'];
                                            }

                                            while(currentTimeIdx < currentTimeString.length){
                                              if(currentTimeString[currentTimeIdx] == ':'){
                                                currentTimeIdx++;
                                                break;
                                              }

                                              startHourString += currentTimeString[currentTimeIdx];
                                              currentTimeIdx++;
                                            }


                                            int currentTimeIndexActual = 0;
                                            bool isPm = false;
                                            while(currentTimeIndexActual < currentTimeString.length){
                                              if(currentTimeString[currentTimeIndexActual] == 'A'){
                                                currentTimeIndexActual++;
                                                break;
                                              }
                                              else if(currentTimeString[currentTimeIndexActual] == 'P'){
                                                currentTimeIndexActual++;
                                                isPm = true;
                                                break;
                                              }
                                              currentTimeIndexActual++;
                                            }

                                            startHour[cartIndex] = int.parse(startHourString);

                                            if(isPm){
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

                                            String startMinuteString = '';
                                            while(currentTimeIdx < currentTimeString.length){
                                              if(currentTimeString[currentTimeIdx] == ' '){
                                                currentTimeIdx++;
                                                break;
                                              }
                                              startMinuteString += currentTimeString[currentTimeIdx];
                                              currentTimeIdx++;
                                            }


                                            startMinutes[cartIndex] = int.parse(startMinuteString);

                                            int serviceDurationIndex = 0;
                                            String serviceHourAmount = '';
                                            String serviceMinuteAmount = '';
                                            while(serviceDurationIndex < serviceDuration[cartIndex].length){
                                              if(serviceDuration[cartIndex][serviceDurationIndex] == 'h'){
                                                serviceDurationIndex++;
                                                break;
                                              }

                                              serviceHourAmount += serviceDuration[cartIndex][serviceDurationIndex];
                                              serviceDurationIndex++;
                                            }

                                            while(serviceDurationIndex < serviceDuration[cartIndex].length){
                                              if(serviceDuration[cartIndex][serviceDurationIndex] == 'm'){
                                                serviceDurationIndex++;
                                                break;
                                              }

                                              serviceMinuteAmount += serviceDuration[cartIndex][serviceDurationIndex];
                                              serviceDurationIndex++;
                                            }


                                            int hourAmountInteger = int.parse(serviceHourAmount);
                                            int minuteAmountInteger = int.parse(serviceMinuteAmount);



                                            String endCycle = '';

                                            int endHourActual = 0;

                                            String currentTimeInWords = '';


                                            if(cart[cartIndex].serviceLinked){
                                              if(cart[cartIndex].type == 'Services'){
                                                int serviceIndex = 0;
                                                while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){
                                                  if(cart[cartIndex].title == snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name']){
                                                    break;
                                                  }
                                                  serviceIndex++;
                                                }

                                                currentTimeInWords = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-timings']['${currentDayOfWeek[cartIndex]}']['${currentTime[cartIndex]}'];

                                              }
                                              else{
                                                int serviceIndex = 0;
                                                while(serviceIndex < snapshot.data['$currentShopIndex']['packages-amount']){
                                                  if(cart[cartIndex].title == snapshot.data['$currentShopIndex']['packages']['$serviceIndex']['package-name']){
                                                    break;
                                                  }
                                                  serviceIndex++;
                                                }

                                                currentTimeInWords = snapshot.data['$currentShopIndex']['packages']['$serviceIndex']['package-timings']['${currentDayOfWeek[cartIndex]}']['${currentTime[cartIndex]}'];

                                              }
                                            }
                                            else{
                                              currentTimeInWords =  snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-availability']['${currentDayOfWeek[cartIndex]}']['${currentTime[cartIndex]}'];
                                            }


                                            if(startHour[cartIndex] != 12 && startHour[cartIndex] + hourAmountInteger >= 12){


                                              int currentLetter = 0;

                                              while(currentLetter < currentTimeInWords.length){
                                                if(currentTimeInWords[currentLetter] == 'A'){
                                                  endCycle = 'PM';
                                                  endHourActual = startHour[cartIndex] + hourAmountInteger;
                                                }
                                                else if(currentTimeInWords[currentLetter] == 'P'){
                                                  endCycle = 'AM';
                                                  endHourActual = startHour[cartIndex];
                                                }
                                                currentLetter++;
                                              }

                                              if(startHour[cartIndex] + hourAmountInteger > 12){
                                                endHour[cartIndex] = startHour[cartIndex] + hourAmountInteger - 12;
                                              }
                                              else{
                                                endHour[cartIndex] = startHour[cartIndex] + hourAmountInteger;
                                              }
                                            }
                                            else if(startHour[cartIndex] == 12 && startHour[cartIndex] + hourAmountInteger >= 12){

                                              int currentLetter = 0;
                                              while(currentLetter < currentTimeInWords.length){
                                                if(currentTimeInWords[currentLetter] == 'A'){
                                                  endCycle = 'AM';
                                                  if(startHour[cartIndex]+hourAmountInteger > 12){
                                                    endHourActual = startHour[cartIndex] + hourAmountInteger - 12;
                                                  }
                                                  else{
                                                    endHourActual = startHour[cartIndex] + hourAmountInteger;
                                                  }
                                                }
                                                else if(currentTimeInWords[currentLetter] == 'P'){
                                                  endCycle = 'PM';
                                                  if(startHour[cartIndex] + hourAmountInteger == 12){
                                                    endHourActual = startHour[cartIndex] + hourAmountInteger;
                                                  }
                                                  else{
                                                    endHourActual = startHour[cartIndex] + hourAmountInteger;
                                                  }
                                                }
                                                currentLetter++;
                                              }
                                              if(startHour[cartIndex] + hourAmountInteger > 12){
                                                endHour[cartIndex] = startHour[cartIndex] + hourAmountInteger - 12;
                                              }
                                              else{
                                                endHour[cartIndex] = startHour[cartIndex] + hourAmountInteger;
                                              }
                                            }
                                            else{
                                              int currentLetter = 0;
                                              while(currentLetter < currentTimeInWords.length){
                                                if(currentTimeInWords[currentLetter] == 'A'){
                                                  if(startMinutes[cartIndex] + minuteAmountInteger >= 60){
                                                    endCycle = 'PM';
                                                  }
                                                  else{
                                                    endCycle = 'AM';
                                                  }
                                                }
                                                else if(currentTimeInWords[currentLetter] == 'P'){
                                                  if(startMinutes[cartIndex] + minuteAmountInteger >= 60){
                                                    endCycle == 'AM';
                                                  }
                                                  else{
                                                    endCycle = 'PM';
                                                  }
                                                }
                                                currentLetter++;
                                              }

                                              endHour[cartIndex] = startHour[cartIndex] + hourAmountInteger;
                                              endHourActual = startHour[cartIndex] + hourAmountInteger + 12;
                                            }

                                            if(startMinutes[cartIndex] + minuteAmountInteger >= 60){

                                              int newEndHour = endHour[cartIndex] + 1;

                                              if(newEndHour > 12){
                                                endHour[cartIndex] = newEndHour - 12;
                                              }
                                              else{
                                                endHour[cartIndex] = newEndHour;
                                              }

                                              endMinutes[cartIndex] = startMinutes[cartIndex] + minuteAmountInteger - 60;
                                              endHourActual++;
                                            }
                                            else{
                                              endMinutes[cartIndex] = startMinutes[cartIndex] + minuteAmountInteger;
                                            }

                                            String endMinute = '';
                                            String endTime = '';
                                            if(endMinutes[cartIndex] == 0){
                                              endMinute = '00';
                                              endTime = '${endHour[cartIndex]}:$endMinute';
                                            }
                                            else{
                                              endTime = '${endHour[cartIndex]}:${endMinutes[cartIndex]}';
                                            }

                                            endTime += ' $endCycle';

                                            print("END TIME: $endTime");
                                            print("Current day of weeek: ${currentDayOfWeek[cartIndex]}");
                                            print("Initial availability index: ${currentTime[cartIndex]}");

                                            int currentMonth = 1;
                                            while(currentMonth <= 12){
                                              if(startMonth[cartIndex] == currentMonth){
                                                await databaseService.updateAppointmentStats(
                                                  selectedCategory,
                                                  currentShopIndex,
                                                  months[currentMonth - 1],
                                                  snapshot.data['$currentShopIndex']['appointment-stats'][months[currentMonth - 1]]['appointment-amount']+1,
                                                );
                                                break;
                                              }
                                              currentMonth++;
                                            }

                                            await databaseService.addAppointment(
                                              'incomplete',
                                              currentDayOfWeek[cartIndex],
                                              selectedCategory,
                                              currentShopIndex,
                                              snapshot.data['$currentShopIndex']['appointments']['appointment-amount']+1,
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
                                            );

                                            setState(() {
                                              cart.remove(cart[cartIndex]);
                                            });

                                            if(cart.isEmpty){
                                              Navigator.pushNamed(context, '/POS');
                                            }

                                          },
                                          child: Text(
                                            'Make An Appointment',
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
                          })
                      ),
                    ),
                  ),
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
                              availableTimes[cartIndex] = [];
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
                            availableTimes[cartIndex] = [];

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

    timeDataMap['$timeDataMapIndex'] = currentTime;

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

              // END TIME
              String endTime = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['end-time'];

              // FUNCTION THAT CHECKS IF CURRENT TIME IS ALREADY OCCUPIED
              bool checkOccupied = isOccupied(startTime, endTime, currentTime, currentMinuteGaps[cartIndex]);

              // FUNCTION THAT GETS THE DURATION OF A SERVICE IN MINUTES
              int currentServiceDuration = getServiceDurationInMinutes(cart[cartIndex].duration);

              // FUNCTION THAT CHECKS IF THE CURRENT TIME WILL CLASH WITH ANOTHER APPOINTMENT
              // GIVEN THE DURATION OF THE SERVICE
              bool checkClashing = isClashing(startTime, currentTime,currentServiceDuration);



              print('CURRENT TIME: $currentTime');
              if(checkOccupied || checkClashing){

                print('$currentTime clashing for $startTime-$endTime');
                print(' ');

                if(bookingsPerSlot[cartIndex]['$startTime-$endTime-$staffName'] >= snapshot.data['$currentShopIndex']['services']['${cart[cartIndex].serviceIndex}']['max-amount-per-timing']){
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


      if(tempTime == currentTime){
        return true;
      }

      String tempHour = getHour(tempTime);
      String tempMinute = getMinute(tempTime);
      String tempEnd = getAMorPM(tempTime);

      String newTime = generateNewTime(tempTime, tempHour, tempMinute, tempEnd, currentMinuteGap);
      tempTime = newTime;

    }
    return false;
  }



}