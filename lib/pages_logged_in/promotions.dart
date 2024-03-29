import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/services/database.dart';

import '../constants.dart';


class AddPromotion extends StatefulWidget {
  const AddPromotion({Key? key}) : super(key: key);

  @override
  _AddPromotionState createState() => _AddPromotionState();
}

class _AddPromotionState extends State<AddPromotion> {


  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  String selectedType = "Services";


  String message = "";

  String selectedItem = "All Services";

  // Keeps track of which type of promotion to add
  String selectedPromotionType = "Flash Sale";

  // The promotion period
  String salePeriod = "Today Only";

  // Variables that will store the start date of the promotion
  String startDay = "";
  String startMonth = "";
  String startYear = "";

  // Variables that will store the end date of promotion
  String endDay = "";
  String endMonth = "";
  String endYear = "";


  // Discount percentage from sale price
  int discount = 10;

  // Booking Window for last minute discount
  int bookingWindow = 1;

  // Start hours for each day of week for happy hours promotion type
  List<String> startHours = ['10:00 AM','10:00 AM','10:00 AM','10:00 AM','10:00 AM','10:00 AM','10:00 AM',];
  List<String> endHours = ['10:00 PM','10:00 PM','10:00 PM','10:00 PM','10:00 PM','10:00 PM','10:00 PM',];

  // Discounts for each day of week for happy hours promotion type
  List<int> happyHoursDiscounts = [10,10,10,10,10,10,10,];


  List<bool> isActive = [false,false,false,false,false,false,false,];

  List<bool> selectedServices = [];

  bool initialEdit = true;

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
              leading: Icon(IconData(0xf006c, fontFamily: 'MaterialIcons')),
              title: Text("Business Hours"),
              onTap: (){
                setState(() {
                  selectedPage = 'businessHours';
                });
                Navigator.pushNamed(context, '/business-hours-logged-in');
              },
            ),
            ListTile(
              leading: Icon(Icons.bolt_rounded),
              title: Text("Marketing"),
              onTap: (){
                setState(() {
                  selectedPage = 'marketing';
                });
                Navigator.pushNamed(context, '/marketing');
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
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Promotion Details',style: TextStyle(
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
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            width: 1000,
            height: MediaQuery.of(context).size.height + 700,
            child: Card(
              elevation: 5.0,
              child: Column(
                children: [

                  SizedBox(height: 30,),

                  Text('Promotion Type', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),

                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: selectedPromotionType == "Flash Sale"?Colors.deepPurple:Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              selectedPromotionType = "Flash Sale";
                            });
                          },
                          child: Text("Flash Sale", style: TextStyle(
                            color: Colors.white,
                          ),),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: selectedPromotionType == "Last Minute Discount"?Colors.deepPurple:Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              selectedPromotionType = "Last Minute Discount";
                            });
                          },
                          child: Text("Last Minute Discount", style: TextStyle(
                            color: Colors.white,
                          ),),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: selectedPromotionType == "Happy Hours"?Colors.deepPurple:Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              selectedPromotionType = "Happy Hours";
                            });
                          },
                          child: Text("Happy Hours", style: TextStyle(
                            color: Colors.white,
                          ),),
                        ),
                      ),
                      SizedBox(width: 10,),
                    ],
                  ),

                  SizedBox(height: 10,),

                  selectedPromotionType != 'Flash Sale'?Container(): Text('Services Included in Promotion', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),

                  selectedPromotionType != 'Flash Sale'?Container(): SizedBox(height: 10,),

                  selectedPromotionType != 'Flash Sale'?Container(): Center(
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){

                            List<String> dropDownItems = [];

                            if(selectedType == "Packages"){
                              dropDownItems.add('All Packages');
                            }
                            else{
                              dropDownItems.add('All Services');
                            }



                            if(initialEdit){
                              selectedServices.add(true);
                            }

                            int index = 0;

                            if(selectedType == "Services"){
                              while(index < snapshot.data['$currentShopIndex']['services-amount']){
                                dropDownItems.add(snapshot.data['$currentShopIndex']['services']['$index']['service-name']);

                                if(initialEdit){
                                  selectedServices.add(false);
                                }
                                index++;
                              }
                            }
                            else{
                              while(index <= snapshot.data['$currentShopIndex']['packages-amount']){
                                dropDownItems.add(snapshot.data['$currentShopIndex']['packages']['$index']['package-name']);
                                if(initialEdit){
                                  selectedServices.add(false);
                                }
                                index++;
                              }
                            }


                            if(initialEdit){
                              initialEdit = false;
                            }

                            return Container(
                              width: 300,
                              height: 280,
                              child: ListView.builder(
                                  itemCount: dropDownItems.length,
                                  itemBuilder: (context,index){
                                    return ListTile(
                                      leading: Switch(
                                        activeColor: Colors.deepPurple,
                                        value: selectedServices[index],
                                        onChanged: (bool value) {
                                          setState(() {
                                            if(index == 0){


                                              if(selectedServices[index] == false){
                                                int serviceIdx = 0;
                                                while(serviceIdx < dropDownItems.length){
                                                  selectedServices[serviceIdx] = true;
                                                  serviceIdx++;
                                                }
                                              }
                                              else{
                                                int serviceIdx = 0;
                                                while(serviceIdx < dropDownItems.length){
                                                  selectedServices[serviceIdx] = false;
                                                  serviceIdx++;
                                                }
                                              }
                                            }
                                            else{
                                              selectedServices[0] = false;
                                              selectedServices[index] = !selectedServices[index];
                                            }

                                            // Check if all services are selected, if they are, then automatically
                                            // turn "all services" switch to be on
                                            int serviceIdx = 1;
                                            bool allActive = true;
                                            while(serviceIdx < dropDownItems.length){

                                              if(selectedServices[serviceIdx] == false){
                                                allActive = false;
                                                break;
                                              }
                                              serviceIdx++;
                                            }

                                            if(allActive){
                                              selectedServices[0] = true;
                                            }


                                          });
                                        },
                                      ),
                                      title: Text(dropDownItems[index]),
                                    );
                              })
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),





                  SizedBox(height: 10,),



                  buildBody(),

                  Center(
                    child: buildError(),
                  ),

                  SizedBox(height:10),

                  FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){

                            if(selectedPromotionType != 'Flash Sale'){
                              return Container();
                            }

                            return Center(
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () async {

                                    if(selectedPromotionType == "Flash Sale"){


                                      bool datesAreValid = true;

                                      // CONVERTS START AND END MONTH TO INTEGERS

                                      int startMonthInt = 0;
                                      while(startMonthInt < months.length){
                                        if(startMonth == months[startMonthInt]){
                                          startMonthInt++;
                                          break;
                                        }
                                        startMonthInt++;
                                      }

                                      int endMonthInt = 0;
                                      while(endMonthInt < months.length){
                                        if(endMonth == months[endMonthInt]){
                                          endMonthInt++;
                                          break;
                                        }
                                        endMonthInt++;
                                      }



                                      // CHECKS IF START DATE IS VALID
                                      if(int.parse(startYear) < DateTime.now().year){
                                        setState(() {
                                          message = "Start year is smaller than present year";
                                        });
                                        datesAreValid = false;
                                      }
                                      else{

                                        if(int.parse(startYear) == DateTime.now().year){

                                          if(startMonthInt < DateTime.now().month){
                                            setState(() {
                                              message = "Start month is smaller than present month";
                                            });
                                            datesAreValid = false;
                                          }
                                          else{
                                            if(startMonthInt == DateTime.now().month && int.parse(startDay) < DateTime.now().day){
                                              setState(() {
                                                message = "Start day is smaller than today";
                                              });
                                              datesAreValid = false;
                                            }
                                          }
                                        }
                                      }


                                      // CHECKS IF END DATE IS SMALLER THAN START DATE

                                      bool endDateGreater = true;

                                      if(datesAreValid){
                                        if(int.parse(endYear) >= int.parse(startYear)){
                                          if(endMonthInt >= startMonthInt){
                                            if(int.parse(endDay) >= int.parse(startDay)){
                                              endDateGreater = false;
                                            }
                                          }
                                        }
                                      }

                                      if(endDateGreater){
                                        setState(() {
                                          message = "Start date is greater than end date";
                                        });
                                        datesAreValid = false;
                                      }

                                      // CHECKS IF DURATION PERIOD IS EQUAL TO DIFFERENCE BETWEEN DATES

                                      if(datesAreValid){
                                        int durationInt = 0;

                                        if(salePeriod == 'Today Only'){
                                          durationInt = 1;

                                          bool datesEqual = false;

                                          if(startDay == endDay){
                                            if(startMonth == endMonth){
                                              if(startYear == endYear){
                                                datesEqual == true;
                                              }
                                            }
                                          }

                                          if(!datesEqual){
                                            setState(() {
                                              message = "Sale period is not equal to period between dates";
                                            });
                                            datesAreValid = false;
                                          }

                                        }
                                        else{
                                          String durationString = '';
                                          int salePeriodIndex = 0;
                                          while(salePeriod[salePeriodIndex] != ' '){
                                            durationString += salePeriod[salePeriodIndex];
                                            salePeriodIndex++;
                                          }

                                          durationInt = int.parse(durationString);


                                          int yearDifference = int.parse(endYear) - int.parse(startYear);
                                          int monthDifference = endMonthInt - startMonthInt;
                                          int dayDifference = int.parse(endDay) - int.parse(startDay);



                                          int durationBetweenDates = (yearDifference*365) + (monthDifference * 30) + (dayDifference);

                                          print('year difference: $yearDifference');
                                          print('month difference: $monthDifference');
                                          print('duration between dates: $durationBetweenDates');

                                          if(durationInt != durationBetweenDates){
                                            setState(() {
                                              message = "Sale period is not equal to period between dates";
                                            });
                                            datesAreValid = false;
                                          }
                                        }
                                      }



                                      // IF DATES ARE VALID THEN UPDATE DATABASE
                                      if(datesAreValid){
                                        int serviceIndex = 0;

                                        if(selectedServices[0] == true){
                                          while(serviceIndex < selectedServices.length - 1){

                                            int newPromotionAmount = snapshot.data!['$currentShopIndex']['services']['$serviceIndex']['flash-promotions-amount'];

                                            await databaseService.addFlashPromotion(
                                                selectedCategory,
                                                currentShopIndex,
                                                serviceIndex,
                                                newPromotionAmount,
                                                salePeriod,
                                                '$discount',
                                                selectedPromotionType,
                                                startDay,
                                                endDay,
                                                startMonth,
                                                endMonth,
                                                startYear,
                                                endYear
                                            );

                                            serviceIndex++;
                                          }
                                        }
                                        else{
                                          serviceIndex = 1;
                                          while(serviceIndex < selectedServices.length){

                                            if(selectedServices[serviceIndex] == true){

                                              int newPromotionAmount = snapshot.data!['$currentShopIndex']['services']['${serviceIndex-1}']['flash-promotions-amount'];

                                              await databaseService.addFlashPromotion(
                                                  selectedCategory,
                                                  currentShopIndex,
                                                  serviceIndex-1,
                                                  newPromotionAmount,
                                                  salePeriod,
                                                  '$discount',
                                                  selectedPromotionType,
                                                  startDay,
                                                  endDay,
                                                  startMonth,
                                                  endMonth,
                                                  startYear,
                                                  endYear
                                              );
                                            }

                                            serviceIndex++;
                                          }


                                        }

                                        Navigator.pushNamed(context, '/active-promotions');

                                      }



                                    }
                                    else if(selectedPromotionType == "Last Minute Discount"){
                                      int serviceIndex = 0;

                                      if(selectedServices[0] == true){
                                        while(serviceIndex < selectedServices.length - 1){

                                          int newPromotionAmount = snapshot.data!['$currentShopIndex']['services']['$serviceIndex']['last-minute-promotions-amount'];


                                          await databaseService.addLastMinutePromotion(
                                              selectedCategory,
                                              currentShopIndex,
                                              serviceIndex,
                                              newPromotionAmount,
                                              '$discount',
                                              selectedPromotionType,
                                              '$bookingWindow',
                                          );

                                          serviceIndex++;
                                        }
                                      }
                                      else{
                                        serviceIndex = 1;
                                        while(serviceIndex < selectedServices.length){

                                          if(selectedServices[serviceIndex] == true){

                                            int newPromotionAmount = snapshot.data!['$currentShopIndex']['services']['${serviceIndex-1}']['last-minute-promotions-amount'];

                                            await databaseService.addLastMinutePromotion(
                                                selectedCategory,
                                                currentShopIndex,
                                                serviceIndex-1,
                                                newPromotionAmount,
                                                '$discount',
                                                selectedPromotionType,
                                                '$bookingWindow',
                                            );
                                          }

                                          serviceIndex++;
                                        }
                                      }
                                    }
                                    else{

                                    }





                                  },
                                  child: Text("Activate Promotion", style: TextStyle(
                                    color: Colors.white,
                                  ),),
                                ),
                              ),
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildError(){

    if(message == ""){
      return Container();
    }
    else{

      String errorMessage = message;
      message = "";

      return Text(errorMessage,style: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),);
    }

  }


  Widget buildBody(){
    if(selectedPromotionType == "Flash Sale"){
      return Container(
        width: 400,
        height: 500,
        child: Column(
          children: [

            SizedBox(height: 10,),

            Text('Sale Discount', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        discount--;
                      });
                    },
                    icon: Icon(Icons.remove,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 10,),
                Text("$discount%"),
                SizedBox(width: 10,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        discount++;
                      });
                    },
                    icon: Icon(Icons.add,color: Colors.white,),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),

            Text("Off The Service Price"),



            SizedBox(height: 10,),

            Text('Sale Period', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 10,),


            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              width: 200,
              child: DropdownButton<String>(
                value: salePeriod,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                //style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? newValue) {
                  setState(() {
                    salePeriod = newValue!;
                  });
                },
                items: <String>[
                  'Today Only',
                  '2 days',
                  '3 days',
                  '7 days',
                  '14 days',
                  '30 days',
                  '45 days',
                  '60 days',
                  '90 days',
                ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),


            SizedBox(height: 10,),
            Text("Start Date", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

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

                SizedBox(width: 10,),

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

                SizedBox(width: 10,),

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

                SizedBox(width: 10,),


              ],
            ),


            SizedBox(height: 10,),

            Text("End Date",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  width: 100,
                  child: DropdownButton<String>(
                    value: endDay,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    //style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        endDay = newValue!;
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

                SizedBox(width: 10,),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  width: 100,
                  child: DropdownButton<String>(
                    value: endMonth,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    //style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        endMonth = newValue!;
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

                SizedBox(width: 10,),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  width: 100,
                  child: DropdownButton<String>(
                    value: endYear,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    //style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        endYear = newValue!;
                      });
                    },
                    items: <String>[
                      '',    '2022','2023','2024','2025','2026'
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(width: 10,),


              ],
            ),
          ],
        ),
      );
    }
    else if(selectedPromotionType == "Last Minute Discount"){


      return Center(
        child: Container(
          width: 500,
          height: 500,
          child: Card(
            elevation: 2.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 10,),

                Text("Coming Soon!", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),

                SizedBox(height: 30,),

                Container(
                  margin: EdgeInsets.all(15),
                  child: Text("Last Minute Discounts are offered at a maximum time before an appointment.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                ),


                SizedBox(height: 10,),

                Container(
                  margin: EdgeInsets.all(15),
                  child: Text("When business is slow "
                      "you will be able to use Last Minute to encourage client"
                      " bookings.",
                    textAlign: TextAlign.center,),
                ),

                SizedBox(height: 20,),

                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){},
                    child: Text("Go To Dashboard", style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
                ),

              ],
            ),
          ),
        ),
      );


      /*
      return Container(
        width: 400,
        height: 600,
        child: Column(
          children: [



            Text("Applied To All Services", style: TextStyle(

            ),),

            SizedBox(height: 10,),
            Text("Last Minute Discount"),
            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        discount--;
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                ),
                SizedBox(width: 10,),
                Text("$discount%"),
                SizedBox(width: 10,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        discount++;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),

            Text("Off The Service"),

            SizedBox(height: 10,),

            Text("Booking Window"),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        bookingWindow--;
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                ),
                SizedBox(width: 10,),
                Text("$bookingWindow hours"),
                SizedBox(width: 10,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        bookingWindow++;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ],
            ),

          ],
        ),
      );
      */
    }
    else{

      return Center(
        child: Container(
          width: 500,
          height: 500,
          child: Card(
            elevation: 2.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 10,),

                Text("Coming Soon!", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),

                SizedBox(height: 30,),

                Container(
                  margin: EdgeInsets.all(15),
                  child: Text("Happy Hours are discounts that are offered at specific days and times.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                ),


                SizedBox(height: 10,),

                Container(
                  margin: EdgeInsets.all(15),
                  child: Text("When business is slow "
                      "you will be able to use Happy Hours to encourage client"
                      " bookings. You choose the discount along with"
                      " which days and times you'd like it to apply to.",
                    textAlign: TextAlign.center,),
                ),

                SizedBox(height: 20,),

                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){},
                    child: Text("Go To Dashboard", style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
                ),

              ],
            ),
          ),
        ),
      );

      /*
      return Container(
        width: 800,
        height: 900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Manage your Happy Hours"),

            SizedBox(height: 10,),

            Container(
              width: 800,
              height: 800,
              child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context,index){
                    return Container(
                      width: 600,
                      height: 100,
                      child: Row(
                        children: [

                          // 1st Column
                          Column(
                            children: [
                              Text(weekDays[index]),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 1.0),
                                    ),
                                    width: 100,
                                    child: DropdownButton<String>(
                                      value: startHours[index],
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      //style: const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          startHours[index] = newValue!;
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
                                  SizedBox(width: 10,),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 1.0),
                                    ),
                                    width: 100,
                                    child: DropdownButton<String>(
                                      value: endHours[index],
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      //style: const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          endHours[index] = newValue!;
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

                          SizedBox(width: 40,),

                          // 2nd Column
                          Column(
                            children: [

                              SizedBox(height: 20,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: IconButton(
                                      onPressed: (){
                                        happyHoursDiscounts[index]++;
                                      },
                                      icon: Icon(Icons.add),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("${happyHoursDiscounts[index]}%"),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: IconButton(
                                      onPressed: (){
                                        happyHoursDiscounts[index]--;
                                      },
                                      icon: Icon(Icons.remove),
                                    ),
                                  ),

                                  SizedBox(width: 90,),

                                  Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isActive[index]?Colors.green:Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: (){
                                        setState(() {
                                          isActive[index] = true;
                                        });
                                      },
                                      child: Text("Active", style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isActive[index]?Colors.grey:Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: (){
                                        setState(() {
                                          isActive[index] = false;
                                        });
                                      },
                                      child: Text("Inactive", style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 10,),

                              Row(
                                children: [

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
              }),
            ),

          ],
        ),
      );
      */
    }
  }
}
