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
                                              //print(selectedDay.);
                                              if((focusDay.day >= DateTime.now().day && focusDay.month == DateTime.now().month) || focusDay.month > DateTime.now().month){

                                                setState(() {
                                                  availableTimes[cartIndex] = [];

                                                  //print("THE DAY IN OTHER FORMAT: $focusDay");
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

                                                  print("CURRENT DAY: ${selectedDay[cartIndex].day}");


                                                });

                                                //print("CURRENT DAY: $currentDayOfWeek");

                                              }
                                            });
                                          },
                                          onFormatChanged: (CalendarFormat _format){
                                            setState((){
                                              format = _format;
                                              print(format.toString());
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
                                              //   print(widget._key!.currentContext!.size!.height);
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
                                              if(cart[cartIndex].serviceLinked){
                                                if(cart[cartIndex].type == 'Services'){
                                                  while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){
                                                    if(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name'] == cart[cartIndex].title){
                                                      print("CART TITLE: ${cart[cartIndex].title}");
                                                      timingAmount[cartIndex] = int.parse(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-timings'][currentDayOfWeek[cartIndex]]['${-1}']);
                                                      print("TIMING AMOUNT: ${timingAmount[cartIndex]}");
                                                      break;
                                                    }
                                                    serviceIndex++;
                                                  }
                                                }
                                                else if(cart[cartIndex].type == 'Packages'){
                                                  int packageIndex = 0;
                                                  while(packageIndex <= snapshot.data['$currentShopIndex']['packages-amount']){
                                                    if(snapshot.data['$currentShopIndex']['packages']['$packageIndex']['package-name'] == cart[cartIndex].title){
                                                      timingAmount[cartIndex] = int.parse(snapshot.data['$currentShopIndex']['packages']['$packageIndex']['package-timings'][currentDayOfWeek[cartIndex]]['${-1}']);
                                                      print('11s');
                                                      break;
                                                    }
                                                    packageIndex++;
                                                  }
                                                  print('12s');
                                                }
                                              }
                                              else{
                                                if(currentEmployeeIndex[cartIndex] == 0){
                                                  int staffMemberIndex = 0;
                                                  int greatestAvailability = 0;
                                                  while(staffMemberIndex < snapshot.data['$currentShopIndex']['staff-members-amount']){
                                                    print("A");
                                                    if(snapshot.data['$currentShopIndex']['staff-members']['$staffMemberIndex']['member-role'] != 'Owner'
                                                        && snapshot.data['$currentShopIndex']['staff-members']['$staffMemberIndex']['member-role'] != 'Manager'){

                                                      print("B");
                                                      int memberServiceIndex = 0;
                                                      bool serviceFound = false;
                                                      while(memberServiceIndex < snapshot.data['$currentShopIndex']['staff-members']['$staffMemberIndex']['member-services-amount']){
                                                        print("C");

                                                        if(snapshot.data['$currentShopIndex']['staff-members']['$staffMemberIndex']['member-services']['$memberServiceIndex'] == cart[cartIndex].title){
                                                          print("D");
                                                          serviceFound = true;
                                                          break;
                                                        }

                                                        memberServiceIndex++;
                                                      }

                                                      if(serviceFound){
                                                        int currentTimingsAmount = int.parse(snapshot.data['$currentShopIndex']['staff-members']['$staffMemberIndex']['member-availability']['${currentDayOfWeek[cartIndex]}']['${-1}']);
                                                        if(currentTimingsAmount > greatestAvailability){
                                                          greatestAvailability = currentTimingsAmount;
                                                          currentBarberTimingIdx[cartIndex] = staffMemberIndex;
                                                        }
                                                      }

                                                    }
                                                    staffMemberIndex++;
                                                  }
                                                  currentEmployeeIndex[cartIndex] = currentBarberTimingIdx[cartIndex];
                                                  timingAmount[cartIndex] = greatestAvailability;
                                                }
                                                else{
                                                  timingAmount[cartIndex] = int.parse(snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-availability']['${currentDayOfWeek[cartIndex]}']['${-1}']);
                                                }
                                              }


                                              print("CART INDEX $cartIndex AMOUNT: ${timingAmount[cartIndex]} ");

                                              return Container(
                                                height: 100,
                                                child: ListView.builder(
                                                  itemCount: timingAmount[cartIndex],
                                                  scrollDirection: Axis.horizontal,
                                                  physics: ScrollPhysics(),
                                                  itemBuilder: (context, index){
                                                    int appointmentsBookedIndex = 0;
                                                    List<String> timesBookedOnCurrentDay = [];
                                                    List<String> serviceDurations = [];
                                                    Map<String,int> bookedTimings = {};

                                                    int serviceIndex = 0;


                                                    if(cart[cartIndex].type == 'Services'){
                                                      while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){
                                                        if(cart[cartIndex].title == snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name']){
                                                          print("1 H");
                                                          break;
                                                        }
                                                        serviceIndex++;
                                                      }
                                                    }
                                                    else{
                                                      print('1s');
                                                      while(serviceIndex <= snapshot.data['$currentShopIndex']['packages-amount']){
                                                        print("2 H");
                                                        if(cart[cartIndex].title == snapshot.data['$currentShopIndex']['packages']['$serviceIndex']['package-name']){
                                                          break;
                                                        }
                                                        serviceIndex++;
                                                      }
                                                      print('2s');
                                                    }



                                                    String currentMember = '';
                                                    print("3 H");
                                                    if(cart[cartIndex].serviceLinked){
                                                      print("4 H");
                                                      currentMember = "none";
                                                    }
                                                    else{
                                                      print("5 H");
                                                      currentMember = snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-name'];
                                                    }

                                                    while(appointmentsBookedIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                                      if(selectedDay[cartIndex].year == snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-year']
                                                          && selectedDay[cartIndex].month == snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-month']
                                                          && selectedDay[cartIndex].day == snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-day']
                                                          && currentMember == snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['member-name']
                                                          && snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['appointment-status'] == 'incomplete'){
                                                        print("REACHED HERE");

                                                        serviceDurations.add(snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['service-duration']);
                                                        if(snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-minutes'] == 0){
                                                          if(snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-hour-actual'] >= 12){
                                                            bookedTimings['${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-hour']}:00 PM'] = 0;
                                                            timesBookedOnCurrentDay.add('${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-hour']}:00 PM');
                                                          }
                                                          else{
                                                            bookedTimings['${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-hour']}:00 AM'] = 0;
                                                            timesBookedOnCurrentDay.add('${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-hour']}:00 AM');
                                                          }
                                                        }
                                                        else{
                                                          if(snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-hour-actual'] >= 12){
                                                            bookedTimings['${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-hour']}:${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-minutes']} PM'] = 0;
                                                            timesBookedOnCurrentDay.add('${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-hour']}:${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-minutes']} PM');
                                                          }
                                                          else{
                                                            bookedTimings['${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-hour']}:${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-minutes']} AM'] = 0;
                                                            timesBookedOnCurrentDay.add('${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-hour']}:${snapshot.data['$currentShopIndex']['appointments']['$appointmentsBookedIndex']['start-minutes']} AM');
                                                          }
                                                        }
                                                      }
                                                      appointmentsBookedIndex++;
                                                    }

                                                    print("6 H");


                                                    timingsOnDayList[cartIndex] = timesBookedOnCurrentDay;
                                                    serviceDurationOnDayList[cartIndex] = serviceDurations;



                                                    int availabilityIndex = 0;
                                                    while(availabilityIndex < timingAmount[cartIndex]){
                                                      availableTimes[cartIndex].add(true);
                                                      availabilityIndex++;
                                                    }

                                                    print('3s');

                                                    int durationIndex = 0;
                                                    String hourAmount = '';
                                                    String minutes = '';
                                                    bool reachedMinutes = false;

                                                    while(durationIndex < serviceDuration[cartIndex].length){
                                                      if(serviceDuration[cartIndex][durationIndex] == 'h'){
                                                        int minuteIndex = durationIndex+1;
                                                        while(minuteIndex < serviceDuration[cartIndex].length){
                                                          if(serviceDuration[cartIndex][minuteIndex] == 'm'){
                                                            reachedMinutes = true;
                                                            break;
                                                          }
                                                          minutes += serviceDuration[cartIndex][minuteIndex];
                                                          minuteIndex++;
                                                        }
                                                        if(reachedMinutes){
                                                          break;
                                                        }
                                                      }
                                                      hourAmount += serviceDuration[cartIndex][durationIndex];
                                                      durationIndex++;
                                                    }

                                                    print("TIMINGS ON CURRENT DAY:${timesBookedOnCurrentDay.length}");
                                                    int minutesInteger = int.parse(minutes);
                                                    int hoursInteger = int.parse(hourAmount);

                                                    int minuteGapForAmountToLoop = 0;

                                                    if(cart[cartIndex].serviceLinked){
                                                      if(cart[cartIndex].type == 'Services'){
                                                        print("8 H");
                                                        minuteGapForAmountToLoop = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['minute-gap'];
                                                      }
                                                      else{
                                                        print('4s');
                                                        minuteGapForAmountToLoop = snapshot.data['$currentShopIndex']['packages']['$serviceIndex']['minute-gap'];
                                                        print('5s');
                                                      }
                                                    }
                                                    else{
                                                      minuteGapForAmountToLoop = snapshot.data['$currentShopIndex']['minute-gap'];
                                                    }


                                                    print("9 H");
                                                    double amountToLoop = (minutesInteger + (hoursInteger * 60)) / (cart[cartIndex].serviceLinked?minuteGapForAmountToLoop:snapshot.data['$currentShopIndex']['minute-gap']);

                                                    print('6s');

                                                    int currentTimeBookedIndex = 0;
                                                    while(currentTimeBookedIndex < timesBookedOnCurrentDay.length){
                                                      int timeAvailabilityIndex = 0;
                                                      while(timeAvailabilityIndex < timingAmount[cartIndex]){

                                                        print("1000 H");

                                                        String currentTiming = '';

                                                        if(cart[cartIndex].serviceLinked){
                                                          print("10 H");
                                                          if(cart[cartIndex].type == 'Services'){
                                                            currentTiming = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-timings'][currentDayOfWeek[cartIndex]]['$timeAvailabilityIndex'];
                                                            print("11 H");
                                                          }
                                                          else{
                                                            //print('7s');
                                                            currentTiming = snapshot.data['$currentShopIndex']['packages']['$serviceIndex']['package-timings'][currentDayOfWeek[cartIndex]]['$timeAvailabilityIndex'];
                                                            print('8s');
                                                          }
                                                        }
                                                        else{
                                                          print("12 H");
                                                          currentTiming = snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-availability']['${currentDayOfWeek[cartIndex]}']['$timeAvailabilityIndex'];
                                                        }


                                                        //String currentTiming  = cart[cartIndex].serviceLinked?snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-timings'][currentDayOfWeek[cartIndex]]['$timeAvailabilityIndex']:snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-availability']['${currentDayOfWeek[cartIndex]}']['$timeAvailabilityIndex'];

                                                        if(timingsOnDayList[cartIndex][currentTimeBookedIndex] == currentTiming){

                                                          print('9s');


                                                          int durationIndexService = 0;
                                                          String hourAmountService = '';
                                                          String minutesService = '';
                                                          bool reachedMinutesService = false;
                                                          while(durationIndexService < serviceDurationOnDayList[cartIndex][currentTimeBookedIndex].length){
                                                            if(serviceDurationOnDayList[cartIndex][currentTimeBookedIndex][durationIndexService] == 'h'){
                                                              int minuteIndex = durationIndexService+1;
                                                              while(minuteIndex < serviceDurationOnDayList[cartIndex][currentTimeBookedIndex].length){
                                                                if(serviceDurationOnDayList[cartIndex][currentTimeBookedIndex][minuteIndex] == 'm'){
                                                                  reachedMinutesService = true;
                                                                  break;
                                                                }
                                                                minutesService += serviceDurationOnDayList[cartIndex][currentTimeBookedIndex][minuteIndex];
                                                                minuteIndex++;
                                                              }
                                                              if(reachedMinutesService){
                                                                break;
                                                              }
                                                            }
                                                            hourAmountService += serviceDurationOnDayList[cartIndex][currentTimeBookedIndex][durationIndexService];
                                                            durationIndexService++;
                                                          }

                                                          int minutesIntegerService = int.parse(minutesService);
                                                          int hoursIntegerService = int.parse(hourAmountService);
                                                          double amountToLoopService = (minutesIntegerService + (hoursIntegerService * 60)) / (minuteGapForAmountToLoop);

                                                          print("amount to loop: ${amountToLoopService}");
                                                          if(cart[cartIndex].serviceLinked){
                                                            int currentTimeAmountBooked = 0;
                                                            currentTimeAmountBooked = bookedTimings[currentTiming]!;
                                                            currentTimeAmountBooked++;
                                                            bookedTimings[currentTiming] = currentTimeAmountBooked;
                                                          }

                                                          print("booked amount: ${bookedTimings[currentTiming]}");


                                                          print("available times length: ${availableTimes[cartIndex].length}");
                                                          int loopIdx = 0;
                                                          while(loopIdx < amountToLoopService){
                                                            print("loopIdx: $loopIdx");
                                                            availableTimes[cartIndex][timeAvailabilityIndex] = false;
                                                            print("avidx: $timeAvailabilityIndex");
                                                            bookedTimings['$timeAvailabilityIndex'] = bookedTimings[currentTiming]!;
                                                            print("bidx: $timeAvailabilityIndex");
                                                            loopIdx++;
                                                            timeAvailabilityIndex++;
                                                          }
                                                          timeAvailabilityIndex--;
                                                        }
                                                        timeAvailabilityIndex++;
                                                      }
                                                      currentTimeBookedIndex++;
                                                    }

                                                    bool conflicting = false;

                                                    int loopIndex = 0;
                                                    int tempIdx = index;
                                                    while(loopIndex < amountToLoop){
                                                      if(availableTimes[cartIndex][tempIdx] == false){
                                                        if(cart[cartIndex].serviceLinked){

                                                          if(cart[cartIndex].type == 'Services'){
                                                            if(bookedTimings['$tempIdx']! >= int.parse(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['max-amount-per-timing'])){
                                                              print("TIME INDEX: $tempIdx : AMOUNT BOOKED IN INDEX: ${bookedTimings['${availableTimes[cartIndex][tempIdx]}']}");
                                                              conflicting = true;
                                                            }
                                                          }
                                                          else{
                                                            print('13s');
                                                            if(bookedTimings['$tempIdx']! >= int.parse(snapshot.data['$currentShopIndex']['packages']['$serviceIndex']['max-amount-per-timing'])){
                                                              print("TIME INDEX: $tempIdx : AMOUNT BOOKED IN INDEX: ${bookedTimings['${availableTimes[cartIndex][tempIdx]}']}");
                                                              conflicting = true;
                                                            }
                                                            print('14s');
                                                          }
                                                        }
                                                        else{
                                                          conflicting = true;
                                                        }
                                                        break;
                                                      }
                                                      tempIdx++;
                                                      loopIndex++;
                                                    }

                                                    String time = '';

                                                    if(cart[cartIndex].serviceLinked){
                                                      if(cart[cartIndex].type == 'Services'){
                                                        time = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-timings'][currentDayOfWeek[cartIndex]]['$index'];
                                                      }
                                                      else{
                                                        //print('16s');
                                                        time = snapshot.data['$currentShopIndex']['packages']['$serviceIndex']['package-timings'][currentDayOfWeek[cartIndex]]['$index'];
                                                        print('17s');
                                                      }
                                                    }
                                                    else{
                                                      time = snapshot.data['$currentShopIndex']['staff-members']['${currentEmployeeIndex[cartIndex]}']['member-availability']['${currentDayOfWeek[cartIndex]}']['$index'];
                                                    }


                                                    if(!conflicting){
                                                      return MaterialButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            currentTime[cartIndex] = index;
                                                          });
                                                        },
                                                        child: timingsData(
                                                            time,
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

                                            print("AT BEGINNING");
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

                                            print("AT 2ND");
                                            while(currentTimeIdx < currentTimeString.length){
                                              if(currentTimeString[currentTimeIdx] == ':'){
                                                currentTimeIdx++;
                                                break;
                                              }

                                              startHourString += currentTimeString[currentTimeIdx];
                                              currentTimeIdx++;
                                            }

                                            print("AT 3RD");

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
                                            print("AT FOURTH");
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

                                            print("AT FIFTH");
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

                                            print("AT SIXTH");
                                            print("hour: $serviceHourAmount");
                                            print("minte: $serviceMinuteAmount");

                                            int hourAmountInteger = int.parse(serviceHourAmount);
                                            int minuteAmountInteger = int.parse(serviceMinuteAmount);

                                            print("INT CONVERSION COMPLETE!");

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
                                              print("START TIME HERE");


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




}