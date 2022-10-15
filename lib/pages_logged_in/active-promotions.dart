import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/services/database.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../constants.dart';


class ActivePromotions extends StatefulWidget {
  const ActivePromotions({Key? key}) : super(key: key);

  @override
  _ActivePromotionsState createState() => _ActivePromotionsState();
}


List<int> promotionServiceIndexes = [];
List<String> promotionServices = [];
List<String> originalPrices = [];
List<String> discountedPrices = [];
List<String> promotionDurations = [];
List<String> promotionDiscounts = [];
List<String> promotionBookingWindows = [];


List<String> startDates = [];
List<String> endDates = [];

List<bool> activeIndexes = [];

class _ActivePromotionsState extends State<ActivePromotions> {

  String selectedType = "Flash Promotions";

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

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
        title: Text('Active Promotions',style: TextStyle(
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (selectedType == "Flash Promotions")?Colors.green:Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            selectedType = "Flash Promotions";
                          });
                        },
                        child: Text("Flash Promotions", style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (selectedType == "Last Minute Promotions")?Colors.green:Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            selectedType = "Last Minute Promotions";
                          });
                        },
                        child: Text("Last Minute Promotions", style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (selectedType == "Happy Hours Promotions")?Colors.green:Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            selectedType = "Happy Hours Promotions";
                          });
                        },
                        child: Text("Happy Hours Promotions", style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
              ),

              SizedBox(height: 10,),

              FutureBuilder(
                future: categoryData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                      return buildBody(snapshot);
                    }
                  }
                  return const Text("Please wait");
                },

              ),






            ],
          ),
        ),
      ),


    );
  }

  Widget buildBody(AsyncSnapshot<dynamic> snapshot){

    promotionServiceIndexes = [];
    promotionServices = [];
    originalPrices = [];
    discountedPrices = [];
    promotionDurations = [];
    promotionDiscounts = [];

    startDates = [];
    endDates = [];

    activeIndexes = [];




    if(selectedType == "Flash Promotions"){

      int serviceIndex = 0;
      while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){

        int promotionIndex = 0;
        while(promotionIndex < snapshot.data['$currentShopIndex']['services']['$serviceIndex']['flash-promotions-amount']){

          promotionServiceIndexes.add(serviceIndex);
          promotionServices.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name']);
          originalPrices.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-price']);
          promotionDurations.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['flash-promotions']['$promotionIndex']['promotion-duration']);
          promotionDiscounts.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['flash-promotions']['$promotionIndex']['promotion-discount']);


          int currentDiscount = int.parse(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['flash-promotions']['$promotionIndex']['promotion-discount']);
          int currentOriginalPrice = int.parse(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-price']);

          double discountedPrice = currentOriginalPrice - (currentOriginalPrice * (currentDiscount / 100));
          discountedPrices.add('${discountedPrice.round()}');

          int startDay = int.parse(snapshot.data!['$currentShopIndex']['services']['$serviceIndex']['flash-promotions']['$promotionIndex']['promotion-start-day']);
          int startYear = int.parse(snapshot.data!['$currentShopIndex']['services']['$serviceIndex']['flash-promotions']['$promotionIndex']['promotion-start-year']);

          int endDay = int.parse(snapshot.data!['$currentShopIndex']['services']['$serviceIndex']['flash-promotions']['$promotionIndex']['promotion-end-day']);
          int endYear = int.parse(snapshot.data!['$currentShopIndex']['services']['$serviceIndex']['flash-promotions']['$promotionIndex']['promotion-end-year']);

          int startMonth = 0;
          int endMonth = 0;

          // Converting month string to int
          int monthIndex = 0;
          while(monthIndex < months.length){

            print(months[monthIndex]);

            if(months[monthIndex] == snapshot.data!['$currentShopIndex']['services']['$serviceIndex']['flash-promotions']['$promotionIndex']['promotion-start-month']){
              startMonth = monthIndex + 1;
            }
            if(months[monthIndex] == snapshot.data!['$currentShopIndex']['services']['$serviceIndex']['flash-promotions']['$promotionIndex']['promotion-end-month']){
              endMonth = monthIndex + 1;
            }

            monthIndex++;

          }

          String startDate = '$startDay/$startMonth/$startYear';
          String endDate = '$endDay/$endMonth/$endYear';

          bool isActive = false;

          if(DateTime.now().year >= startYear && DateTime.now().year <= endYear){
            if(DateTime.now().month >= startMonth && DateTime.now().month <= endMonth){
              if(DateTime.now().day >= startDay && DateTime.now().day <= endDay){
                isActive = true;
                activeIndexes.add(true);
              }
            }
          }

          if(!isActive){
            activeIndexes.add(false);
          }

          startDates.add(startDate);
          endDates.add(endDate);

          promotionIndex++;
        }

        serviceIndex++;
      }


      return Container(
        width: MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height * 2,
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20,),

            Row(
              children: [
                SizedBox(width: 5,),
                Text("All Promotions", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(width: MediaQuery.of(context).size.width - 450,),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                  ),
                  child: IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/add-promotion');
                    },
                    icon: Icon(Icons.add),
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10,),
                Text("Add New Promotion", style: TextStyle(
                  fontSize: 16,
                ),)


              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 310,
              child: Card(
                elevation: 5.0,
                child: ListView.builder(
                    itemCount: promotionServices.length,
                    itemBuilder: (context,index){
                      return buildListTile(index);
                }),
              ),
            ),

            SizedBox(height: 50,),

            Row(
              children: [
                SizedBox(width: 5,),
                Text("Active Promotions", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 310,
              child: Card(
                elevation: 5.0,
                child: ListView.builder(
                    itemCount: promotionServices.length,
                    itemBuilder: (context,index){

                      if(activeIndexes[index]){
                        return buildListTile(index);
                      }
                      else{
                        return Container();
                      }
                    }),
              ),
            ),

            SizedBox(height: 50,),

            Row(
              children: [
                SizedBox(width: 5,),
                Text("Pending Promotions", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 310,
              child: Card(
                elevation: 5.0,
                child: ListView.builder(
                    itemCount: promotionServices.length,
                    itemBuilder: (context,index){

                      if(activeIndexes[index] == false){
                        return buildListTile(index);
                      }
                      else{
                        return Container();
                      }
                    }),
              ),
            ),

          ],
        )
      );
    }
    else if(selectedType == "Last Minute Promotions"){

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
      int serviceIndex = 0;
      while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){

        int promotionIndex = 0;
        while(promotionIndex < snapshot.data['$currentShopIndex']['services']['$serviceIndex']['last-minute-promotions-amount']){

          promotionServiceIndexes.add(serviceIndex);
          promotionServices.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name']);
          originalPrices.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-price']);
          promotionBookingWindows.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['last-minute-promotions']['$promotionIndex']['booking-window']);
          promotionDiscounts.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['last-minute-promotions']['$promotionIndex']['promotion-discount']);


          int currentDiscount = int.parse(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['last-minute-promotions']['$promotionIndex']['promotion-discount']);
          int currentOriginalPrice = int.parse(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-price']);

          double discountedPrice = currentOriginalPrice - (currentOriginalPrice * (currentDiscount / 100));
          discountedPrices.add('${discountedPrice.round()}');


          promotionIndex++;
        }

        serviceIndex++;
      }


      return Container(
          width: MediaQuery.of(context).size.width,
          height:  MediaQuery.of(context).size.height * 2,
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 20,),

              Row(
                children: [
                  SizedBox(width: 5,),
                  Text("All Promotions", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(width: MediaQuery.of(context).size.width - 450,),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green,
                    ),
                    child: IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/add-promotion');
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text("Add New Promotion", style: TextStyle(
                    fontSize: 16,
                  ),)


                ],
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 310,
                child: Card(
                  elevation: 5.0,
                  child: ListView.builder(
                      itemCount: promotionServices.length,
                      itemBuilder: (context,index){
                        return buildListTile(index);
                      }),
                ),
              ),

              SizedBox(height: 50,),

            ],
          )
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
    }
  }



  Widget buildListTile(int index){
    if(selectedType == "Flash Promotions" && activeIndexes[index]){
      return ListTile(
        leading: Container(
          width: 220,
          height: 100,
          child: Row(
            children: [
              VerticalDivider(color: Colors.blue, thickness: 2.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Service", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  Text(promotionServices[index]),
                ],
              ),
            ],
          ),
        ),
        title: Container(
          width: 950,
          height: 80,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text("Discount",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(height: 5,),
                  Text('${promotionDiscounts[index]}%'),
                ],
              ),

              SizedBox(width: 20,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text("Original Price",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(height: 5,),
                  Text('${originalPrices[index]} EGP'),
                ],
              ),

              SizedBox(width: 20,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text("Discounted Price",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(height: 5,),
                  Text('${discountedPrices[index]} EGP'),
                ],
              ),
              SizedBox(width: 50,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text("Duration",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(height: 5,),
                  Text(promotionDurations[index]),
                ],
              ),

              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text("Start Date",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(height: 5,),
                  Text(startDates[index]),
                ],
              ),

              SizedBox(width: 10,),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text("End Date",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(height: 5,),
                  Text(endDates[index]),
                ],
              ),

            ],
          ),
        ),
        trailing: Container(
          width: 250,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: (){

                    promotionToBeEdited = index;
                    promotionType = selectedType;

                    Navigator.pushNamed(context, '/edit-promotion');
                  },
                  child: Text("Edit", style: TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ),

              SizedBox(width: 20,),

              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: (){


                    promotionType = selectedType;
                    promotionToBeEdited = index;

                    Navigator.pushNamed(context, '/delete-promotion');
                  },
                  child: Text("Delete", style: TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ),

            ],
          ),
        ),
      );
    }
    else if (selectedType == "Last Minute Promotions"){
      return ListTile(
        leading: Container(
          width: 220,
          height: 100,
          child: Row(
            children: [
              VerticalDivider(color: Colors.blue, thickness: 2.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Service", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  Text(promotionServices[index]),
                ],
              ),
            ],
          ),
        ),
        title: Container(
          width: 950,
          height: 80,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text("Discount",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(height: 5,),
                  Text('${promotionDiscounts[index]}%'),
                ],
              ),

              SizedBox(width: 20,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text("Original Price",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(height: 5,),
                  Text('${originalPrices[index]} EGP'),
                ],
              ),

              SizedBox(width: 20,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text("Discounted Price",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(height: 5,),
                  Text('${discountedPrices[index]} EGP'),
                ],
              ),
              SizedBox(width: 20,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text("Booking Window",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(height: 5,),
                  Text('${promotionBookingWindows[index]} hours'),
                ],
              ),
              SizedBox(width: 50,),

            ],
          ),
        ),
        trailing: Container(
          width: 250,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: (){

                    promotionToBeEdited = index;
                    promotionType = selectedType;

                    Navigator.pushNamed(context, '/edit-promotion');
                  },
                  child: Text("Edit", style: TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ),

              SizedBox(width: 20,),

              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: (){


                    promotionType = selectedType;
                    promotionToBeEdited = index;

                    Navigator.pushNamed(context, '/delete-promotion');
                  },
                  child: Text("Delete", style: TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ),

            ],
          ),
        ),
      );
    }
    else{
      return Container();
    }

  }


}
