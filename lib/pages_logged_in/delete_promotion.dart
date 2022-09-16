import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/constants.dart';
import 'package:servnn_client_side/pages_logged_in/active-promotions.dart';
import 'package:servnn_client_side/services/database.dart';



class DeletePromotion extends StatefulWidget {
  const DeletePromotion({Key? key}) : super(key: key);

  @override
  _DeletePromotionState createState() => _DeletePromotionState();
}

class _DeletePromotionState extends State<DeletePromotion> {


  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Promotion',style: TextStyle(
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
          height: MediaQuery.of(context).size.height * 1.5,
          child: Column(
            children: [
              buildBody(),
            ],
          ),
        ),
      ),

    );
  }


  Widget buildBody(){
    if(promotionType == "Flash Promotions"){
      return Container(
        width: 500,
        height: 800,
        child: Card(
          elevation: 5.0,
          child: Column(
            children: [
              Text("Promotion Details", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 30,),

              Text("Promotion Type", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(promotionType),
              SizedBox(height: 10,),

              Text("Service", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(promotionServices[promotionToBeEdited]),
              SizedBox(height: 10,),

              Text("Discount", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text('${promotionDiscounts[promotionToBeEdited]}%'),
              SizedBox(height: 10,),

              Text("Original Price", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(originalPrices[promotionToBeEdited]),
              SizedBox(height: 10,),

              Text("Discounted Price", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(discountedPrices[promotionToBeEdited]),
              SizedBox(height: 10,),

              Text("Duration", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(promotionDurations[promotionToBeEdited]),
              SizedBox(height: 10,),

              Text("Start Date", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(startDates[promotionToBeEdited]),
              SizedBox(height: 10,),

              Text("End Date", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(endDates[promotionToBeEdited]),
              SizedBox(height: 10,),


              FutureBuilder(
                future: categoryData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                      return Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {

                            int promotionIndex = 0;
                            int databaseIndex = 0;
                            while(promotionIndex < snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions-amount']){

                              if(promotionIndex != promotionToBeEdited){


                                String promotionPeriod = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-duration'];
                                String promotionDiscount = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-discount'];
                                String promotionType = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-type'];
                                String startDay = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-start-day'];
                                String endDay = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-end-day'];
                                String startMonth = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-start-month'];
                                String endMonth = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-end-month'];
                                String startYear = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-start-year'];
                                String endYear = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-end-year'];


                                await databaseService.editFlashPromotion(
                                    selectedCategory,
                                    currentShopIndex,
                                    promotionServiceIndexes[promotionToBeEdited],
                                    databaseIndex,
                                    promotionPeriod,
                                    promotionDiscount,
                                    promotionType,
                                    startDay,
                                    endDay,
                                    startMonth,
                                    endMonth,
                                    startYear,
                                    endYear
                                );

                                databaseIndex++;

                              }
                              promotionIndex++;
                            }

                            await databaseService.deleteFlashPromotion(
                              selectedCategory,
                              currentShopIndex,
                              promotionServiceIndexes[promotionToBeEdited],
                              promotionIndex-1,
                            );


                            Navigator.pushNamed(context, '/active-promotions');

                          },
                          child: Text("Delete Promotion", style: TextStyle(
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
      );
    }
    else if(promotionType == "Last Minute Promotions"){
      return Container(
        width: 500,
        height: 800,
        child: Card(
          elevation: 5.0,
          child: Column(
            children: [
              Text("Promotion Details", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 30,),

              Text("Promotion Type", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(promotionType),
              SizedBox(height: 10,),

              Text("Service", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(promotionServices[promotionToBeEdited]),
              SizedBox(height: 10,),

              Text("Discount", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text('${promotionDiscounts[promotionToBeEdited]}%'),
              SizedBox(height: 10,),

              Text("Original Price", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(originalPrices[promotionToBeEdited]),
              SizedBox(height: 10,),

              Text("Discounted Price", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text(discountedPrices[promotionToBeEdited]),
              SizedBox(height: 10,),

              Text("Booking Window", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 10,),
              Text("${promotionBookingWindows[promotionToBeEdited]} hours"),
              SizedBox(height: 10,),


              FutureBuilder(
                future: categoryData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                      return Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {

                            int promotionIndex = 0;
                            int databaseIndex = 0;
                            while(promotionIndex < snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions-amount']){

                              if(promotionIndex != promotionToBeEdited){


                                String promotionPeriod = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-duration'];
                                String promotionDiscount = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-discount'];
                                String promotionType = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-type'];
                                String startDay = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-start-day'];
                                String endDay = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-end-day'];
                                String startMonth = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-start-month'];
                                String endMonth = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-end-month'];
                                String startYear = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-start-year'];
                                String endYear = snapshot.data['$currentShopIndex']['services']['${promotionServiceIndexes[promotionToBeEdited]}']['flash-promotions']['$promotionIndex']['promotion-end-year'];


                                await databaseService.editFlashPromotion(
                                    selectedCategory,
                                    currentShopIndex,
                                    promotionServiceIndexes[promotionToBeEdited],
                                    databaseIndex,
                                    promotionPeriod,
                                    promotionDiscount,
                                    promotionType,
                                    startDay,
                                    endDay,
                                    startMonth,
                                    endMonth,
                                    startYear,
                                    endYear
                                );

                                databaseIndex++;

                              }
                              promotionIndex++;
                            }

                            await databaseService.deleteFlashPromotion(
                              selectedCategory,
                              currentShopIndex,
                              promotionServiceIndexes[promotionToBeEdited],
                              promotionIndex-1,
                            );



                            Navigator.pushNamed(context, '/active-promotions');

                          },
                          child: Text("Delete Promotion", style: TextStyle(
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
      );
    }
    else{
      return Container();
    }
  }

}
