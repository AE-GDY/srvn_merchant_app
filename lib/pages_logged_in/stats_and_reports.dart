import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants.dart';
import '../models/appointment_stats.dart';
import '../models/service.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class StatsAndReports extends StatefulWidget {
  const StatsAndReports({Key? key}) : super(key: key);

  @override
  _StatsAndReportsState createState() => _StatsAndReportsState();
}

class _StatsAndReportsState extends State<StatsAndReports> {
  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable:true);
  TooltipBehavior _tooltipBehavior3 = TooltipBehavior(enable:true);
  TooltipBehavior _tooltipBehavior2 = TooltipBehavior(enable:true);
  TooltipBehavior _tooltipBehavior4 = TooltipBehavior(enable:true);



  String selectedType = "Dashboard";
  List<AppointmentStats> appointmentStats = [];
  List<AppointmentStatusStats> statusesStats = [];
  List<AppointmentRevenueStats> revenueStats = [];
  List<ClientTypeData> clientTypesData = [];
  List<ClientStats> clientStats = [];
  List<ClientData> clientList = [];
  List<StaffMemberStats> staffMemberStats = [];
  int returningLabels = 0;
  int newLabels = 0;

  bool filled = false;

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
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Stats and Reports",style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
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
                return Container(
                  width: 1500,
                  height: 2000,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 70,
                          height: 1500,
                          decoration: BoxDecoration(
                            //color: Colors.grey[200],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 50,),
                              ListTile(
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
                              SizedBox(height: 10,),
                              ListTile(
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
                              SizedBox(height: 10,),
                              ListTile(
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
                              SizedBox(height: 10,),
                              ListTile(
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
                              SizedBox(height: 10,),
                              ListTile(
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
                              SizedBox(height: 10,),
                              ListTile(
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
                              SizedBox(height: 10,),
                              ListTile(
                                leading: Icon(Icons.settings,color: selectedPage == 'settings'?Colors.black:Colors.grey,size: iconSize,),
                                //title: Text("Settings"),
                                onTap: (){
                                  setState(() {
                                    selectedPage = 'settings';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 32,
                        left: 102,
                        child: Container(
                          width: 1095,
                          height: 50,
                          decoration: BoxDecoration(
                            //color: Colors.grey[100],
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 0,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: selectedType=="Dashboard"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      selectedType = "Dashboard";
                                      filled = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Dashboard", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "Dashboard"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),

                                ),
                              ),
                              SizedBox(width: 50,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: selectedType=="Appointments"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      selectedType = "Appointments";
                                      filled = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Appointments", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "Appointments"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),

                                ),
                              ),
                              SizedBox(width: 50,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: selectedType=="Clients"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      selectedType = "Clients";
                                      filled = false;

                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Clients", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "Clients"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),

                                ),
                              ),
                              SizedBox(width: 50,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color:selectedType=="Revenue"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      selectedType = "Revenue";
                                      filled = false;

                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Revenue", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "Revenue"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 50,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color:selectedType=="Cash Flow"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      selectedType = "Cash Flow";
                                      filled = false;

                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Cash Flow", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "Cash Flow"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 50,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color:selectedType=="Inventory"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      selectedType = "Inventory";
                                      filled = false;

                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Inventory", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "Inventory"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 50,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color:selectedType=="Staff"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      selectedType = "Staff";
                                      filled = false;

                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Staff", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "Staff"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 50,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color:selectedType=="Marketing"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      selectedType = "Marketing";
                                      filled = false;

                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Marketing", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "Marketing"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      buildBody(snapshot),

                    ],
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


  Widget buildBody(AsyncSnapshot<dynamic> snapshot){
    if(selectedType == "Dashboard"){
      return Positioned(
        top: 82,
        left: 102,
        child: Container(
          width: 1095,
          height: 1000,
          child: Card(
            elevation: 3.0,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 0,
                  child: Container(
                    width: 800,
                    height: 350,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            if(!filled){

                              appointmentStats = [];
                              statusesStats = [];
                              revenueStats = [];
                              clientStats = [];

                              int monthIndex = 0;
                              while(monthIndex < months.length){
                                int appointmentIndex = 0;
                                int appointmentAmount = 0;
                                while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){

                                  if(monthIndex+1 == snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-month']
                                  && snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-type'] == 'Services'){
                                    appointmentAmount++;
                                  }

                                  appointmentIndex++;
                                }

                                AppointmentStats currentMonthStats = AppointmentStats(
                                  month: double.parse('$monthIndex'),
                                  appointmentAmount: double.parse('$appointmentAmount'),
                                  revenue: double.parse('${snapshot.data['$currentShopIndex']['appointment-stats'][months[monthIndex]]['appointment-revenue']}'),

                                );



                                appointmentStats.add(currentMonthStats);
                                monthIndex++;
                              }

                              int statusIndex = 0;
                              List<String> statuses = ['complete','incomplete','cancelled','no-shows'];
                              List<String> statusesImproved = ['Complete','Incomplete','Cancelled','No-shows'];
                              while(statusIndex < statuses.length){
                                int appointmentIndex = 0;
                                int currentAmount = 0;
                                int currentValue = 0;
                                while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                  if(statuses[statusIndex] == snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status']){
                                    currentAmount++;
                                    currentValue += int.parse(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-price']);
                                  }
                                  appointmentIndex++;
                                }

                                AppointmentStatusStats currentStatusStats = AppointmentStatusStats(
                                    status: statusesImproved[statusIndex],
                                    quantity: currentAmount,
                                    percent: '${(currentAmount /(snapshot.data['$currentShopIndex']['appointments']['appointment-amount'] + 1))*100}%',
                                    value: '$currentValue'
                                );

                                statusesStats.add(currentStatusStats);
                                statusIndex++;
                              }

                              int typeIndex = 0;
                              List<String> appointmentTypes = ['Services','Products','Packages','Memberships','Gift Cards', 'Cancellation fees'];
                              while(typeIndex < appointmentTypes.length){
                                int appointmentIndex = 0;
                                int currentAmount = 0;
                                int currentValue = 0;
                                while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                  if(appointmentTypes[typeIndex] == snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-type']
                                  && snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] != 'incomplete'){
                                    currentAmount++;
                                    currentValue += int.parse(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-price']);
                                  }
                                  appointmentIndex++;
                                }

                                AppointmentRevenueStats currentRevenueStats = AppointmentRevenueStats(
                                    type: appointmentTypes[typeIndex],
                                    quantity: currentAmount,
                                    percent: '${(currentAmount /(snapshot.data['$currentShopIndex']['appointments']['appointment-amount'] + 1))*100}%',
                                    value: '$currentValue'
                                );

                                revenueStats.add(currentRevenueStats);
                                typeIndex++;
                              }



                              filled = true;
                            }


                            return SfCartesianChart(
                              tooltipBehavior: _tooltipBehavior4,
                              title: ChartTitle(
                                text: "Appointments this year",
                              ),
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                                LineSeries<AppointmentStats,String>(
                                    markerSettings: MarkerSettings(
                                        isVisible: true
                                    ),
                                    name: 'Amount',
                                    xAxisName: "Month",
                                    yAxisName: "Amount",
                                    dataSource: appointmentStats,
                                    xValueMapper: (AppointmentStats current, _)=>months[int.parse('${current.month}')], //
                                    yValueMapper: (AppointmentStats current, _)=>current.appointmentAmount,
                                    enableTooltip: true,

                                ),
                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),

                Positioned(
                  top: 450,
                  left: 0,
                  child: Container(
                    width: 780,
                    height: 350,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            return SfCartesianChart(
                              title: ChartTitle(
                                text: "Revenue this year",
                              ),
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                                LineSeries<AppointmentStats,String>(
                                    xAxisName: "Month",
                                    yAxisName: "Amount",
                                    dataSource: appointmentStats,
                                    xValueMapper: (AppointmentStats current, _)=>months[int.parse('${current.month}')], //
                                    yValueMapper: (AppointmentStats current, _)=>current.revenue
                                ),
                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),

                Positioned(
                  top: 90,
                  right: 10,
                  child: Container(
                    width: 250,
                    height: 280,
                    child: Card(
                      elevation: 3.0,
                      child: FutureBuilder(
                        future: categoryData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){

                              int appointmentIndex = 0;

                              int appointmentAmount = 0;
                              int incomplete = 0;
                              int complete = 0;
                              int noShows = 0;
                              int cancelled = 0;

                              while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){


                                if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-type'] == 'Services'){
                                  appointmentAmount++;

                                  if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] == 'complete'){
                                    complete++;
                                  }
                                  else if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] == 'incomplete'){
                                    incomplete++;
                                  }
                                  else if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] == 'no-show'){
                                    noShows++;
                                  }
                                  else if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] == 'cancelled'){
                                    cancelled++;
                                  }
                                }

                                appointmentIndex++;
                              }


                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Appointments"),
                                            SizedBox(height: 10,),
                                            Text("$appointmentAmount"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 15,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Incomplete"),
                                            SizedBox(height: 10,),
                                            Text("$incomplete"),
                                          ],
                                        ),
                                        SizedBox(width: 50,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Finished"),
                                            SizedBox(height: 10,),
                                            Text("$complete"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 15,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("No-shows"),
                                            SizedBox(height: 10,),
                                            Text("$noShows"),
                                          ],
                                        ),
                                        SizedBox(width: 50,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Cancelled"),
                                            SizedBox(height: 10,),
                                            Text("$cancelled"),
                                          ],
                                        ),
                                      ],
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
                  ),
                ),
                Positioned(
                  top: 460,
                  right: 10,
                  child: Container(
                    width: 300,
                    height: 350,
                    child: Card(
                      elevation: 3.0,
                      child: FutureBuilder(
                        future: categoryData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){

                              int appointmentIndex = 0;
                              int totalRevenue = 0;
                              while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] != 'incomplete'){
                                  totalRevenue += int.parse(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-price']);
                                }
                                appointmentIndex++;
                              }


                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Revenue"),
                                            SizedBox(height: 10,),
                                            Text("$totalRevenue EGP"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Services"),
                                            SizedBox(height: 10,),
                                            Text(revenueStats[0].value),
                                          ],
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Products"),
                                            SizedBox(height: 10,),
                                            Text(revenueStats[1].value),
                                          ],
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Cancellations"),
                                            SizedBox(height: 10,),
                                            Text(revenueStats[5].value),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Gift cards"),
                                            SizedBox(height: 5,),
                                            Text(revenueStats[4].value),
                                          ],
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Memberships"),
                                            SizedBox(height: 10,),
                                            Text(revenueStats[3].value),
                                          ],
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Packages"),
                                            SizedBox(height: 10,),
                                            Text(revenueStats[2].value),
                                          ],
                                        ),
                                      ],
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
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if(selectedType == "Appointments"){
      return Positioned(
        top: 82,
        left: 102,
        child: Container(
          width: 1095,
          height: 1000,
          child: Card(
            elevation: 3.0,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(
                    width: 900,
                    height: 350,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            if(!filled){

                              appointmentStats = [];
                              statusesStats = [];
                              revenueStats = [];
                              clientStats = [];


                              int monthIndex = 0;
                              while(monthIndex < months.length){
                                int appointmentIndex = 0;
                                int appointmentAmount = 0;
                                while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){

                                  if(monthIndex+1 == snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['start-month']
                                      && snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-type'] == 'Services'){
                                    appointmentAmount++;
                                  }


                                  appointmentIndex++;
                                }

                                AppointmentStats currentMonthStats = AppointmentStats(
                                  month: double.parse('$monthIndex'),
                                  appointmentAmount: double.parse('$appointmentAmount'),
                                  revenue: double.parse('${snapshot.data['$currentShopIndex']['appointment-stats'][months[monthIndex]]['appointment-revenue']}'),

                                );



                                appointmentStats.add(currentMonthStats);
                                monthIndex++;
                              }


                              int appointmentIndex = 0;
                              int appointmentAmount = 0;


                              // CALCULATES AMOUNT OF "APPOINTMENTS" THAT ARE NOT PRODUCT PURCHASES
                              while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){


                                if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-type'] == 'Services'){
                                  appointmentAmount++;
                                }

                                appointmentIndex++;
                              }


                              int statusIndex = 0;
                              List<String> statuses = ['complete','incomplete','cancelled','no-shows'];
                              List<String> statusesImproved = ['Complete','Incomplete','Cancelled','No-shows'];
                              while(statusIndex < statuses.length){
                                int appointmentIndex = 0;
                                int currentAmount = 0;
                                int currentValue = 0;
                                while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                  if(statuses[statusIndex] == snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status']
                                  && snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-type'] == 'Services'){
                                    currentAmount++;
                                    currentValue += int.parse(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-price']);
                                  }
                                  appointmentIndex++;
                                }

                                AppointmentStatusStats currentStatusStats = AppointmentStatusStats(
                                    status: statusesImproved[statusIndex],
                                    quantity: currentAmount,
                                    percent: (currentAmount != 0)? '${((currentAmount /(appointmentAmount))*100).round()}%':'0%',
                                    value: '$currentValue'
                                );

                                statusesStats.add(currentStatusStats);
                                statusIndex++;
                              }



                              filled = true;
                            }


                            return SfCartesianChart(
                              title: ChartTitle(
                                text: "Appointments this year",
                              ),
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                                LineSeries<AppointmentStats,String>(
                                    xAxisName: "Month",
                                    yAxisName: "Amount",
                                    dataSource: appointmentStats,
                                    xValueMapper: (AppointmentStats current, _)=>months[int.parse('${current.month}')], //
                                    yValueMapper: (AppointmentStats current, _)=>current.appointmentAmount
                                ),
                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),

                Positioned(
                  top: 550,
                  left: 0,
                  child: Container(
                    width: 900,
                    height: 350,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Highlights", style: TextStyle(
                                  fontSize: 18,
                                ),),

                                Container(
                                  width: 600,
                                  child: DataTable(
                                      onSelectAll: (b) {},
                                      sortColumnIndex: 1,
                                      sortAscending: true,
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Text("Appointment Status", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          //tooltip: "To display first name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Quantity",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Percent",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Value",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                      ],
                                      rows: statusesStats
                                          .map(
                                            (current) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(current.status),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.quantity}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.percent}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.value} EGP'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                          ],
                                        ),
                                      )
                                          .toList()),
                                ),

                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if(selectedType == "Clients"){
      return Positioned(
        top: 82,
        left: 102,
        child: Container(
          width: 1095,
          height: 2000,
          child: Card(
            elevation: 3.0,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(
                    width: 900,
                    height: 350,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            if(!filled){

                              appointmentStats = [];
                              revenueStats = [];
                              clientStats = [];
                              clientList = [];
                              clientTypesData = [];
                              newLabels = 0;
                              returningLabels = 0;

                              int monthIndex = 0;
                              while(monthIndex < months.length){
                                AppointmentStats currentMonthStats = AppointmentStats(
                                  month: double.parse('$monthIndex'),
                                  appointmentAmount: double.parse('${snapshot.data['$currentShopIndex']['appointment-stats'][months[monthIndex]]['appointment-amount']}'),
                                  revenue: double.parse('${snapshot.data['$currentShopIndex']['appointment-stats'][months[monthIndex]]['appointment-revenue']}'),
                                );

                                appointmentStats.add(currentMonthStats);
                                monthIndex++;
                              }

                              int typeIndex = 0;
                              List<String> appointmentTypes = ['Services','Products','Packages','Memberships','Gift Cards', 'Cancellation fees'];
                              while(typeIndex < appointmentTypes.length){
                                int appointmentIndex = 0;
                                int currentAmount = 0;
                                int currentValue = 0;
                                while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                  if(appointmentTypes[typeIndex] == snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-type']){
                                    if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] != 'incomplete'){
                                      currentValue += int.parse(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-price']);
                                    }
                                    currentAmount++;
                                  }
                                  appointmentIndex++;
                                }

                                print("CURRENT AMOUNT: $currentAmount");

                                AppointmentRevenueStats currentRevenueStats = AppointmentRevenueStats(
                                    type: appointmentTypes[typeIndex],
                                    quantity: currentAmount,
                                    percent: (currentAmount != 0)?'${(currentAmount /(snapshot.data['$currentShopIndex']['appointments']['appointment-amount'] + 1))*100}%':'0%',
                                    value: '$currentValue'
                                );

                                revenueStats.add(currentRevenueStats);
                                typeIndex++;
                              }

                              List<List<String>> clientsInMonths = [];
                              monthIndex  = 0;
                              while(monthIndex < months.length){

                                clientsInMonths.add([]);
                                monthIndex++;

                              }

                              monthIndex = 0;
                              while(monthIndex < months.length){

                                int clientIndex = 0;
                                int currentQuantity = 0;
                                Map<String,bool> returningClientsMap = {};
                                Map<String,int> monthsMap = {'JAN': 1, 'FEB': 2, 'MAR': 3, 'APR': 4, 'MAY': 5, 'JUN': 6, 'JUL': 7, 'AUG': 8, 'SEP': 9, 'OCT': 10, 'NOV': 11, 'DEC': 12,};

                                while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){

                                  int appIdx = 0;
                                  while(appIdx <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){

                                    if(snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name'] == snapshot.data['$currentShopIndex']['appointments']['$appIdx']['client-name']){
                                      if(monthsMap[months[monthIndex]] == snapshot.data['$currentShopIndex']['appointments']['$appIdx']['start-month']){
                                        currentQuantity++;
                                        break;
                                      }
                                    }

                                    appIdx++;
                                  }

                                  returningClientsMap[snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']] = false;
                                  clientIndex++;
                                }




                                int returningClients = 0;
                                int newClients = 0;

                                print("ABOUT TO EXECUTE WHILE LOOPPP");




                                clientIndex = 0;
                                while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                                  print("ENTERED WHILE LOOP");
                                  if(monthsMap[snapshot.data['$currentShopIndex']['clients']['$clientIndex']['month']]! < monthsMap[months[monthIndex]]!){
                                    print("current month: ${snapshot.data['$currentShopIndex']['clients']['$clientIndex']['month']}");
                                    int appIdx = 0;
                                    while(appIdx <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                      if(snapshot.data['$currentShopIndex']['appointments']['$appIdx']['client-name'] == snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']){
                                        if(snapshot.data['$currentShopIndex']['appointments']['$appIdx']['start-month'] == monthsMap[months[monthIndex]]){
                                          returningClientsMap[snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']] = true;
                                          break;
                                        }
                                      }
                                      appIdx++;
                                    }
                                  }
                                  clientIndex++;
                                }

                                print("REACHED AFTER ABOUT TO EXECUTE WHILE LOOP 1");


                                int returningClientsIndex = 0;
                                while(returningClientsIndex < returningClientsMap.length){
                                  if(returningClientsMap[snapshot.data['$currentShopIndex']['clients']['$returningClientsIndex']['name']]!){
                                    returningClients++;
                                  }
                                  returningClientsIndex++;
                                }


                                print("REACHED AFTER ABOUT TO EXECUTE WHILE LOOP 2");

                                newClients = currentQuantity - returningClients;




                                ClientStats currentClients = ClientStats(
                                    month: months[monthIndex],
                                    quantity:currentQuantity,
                                    returningClients: returningClients,
                                    newClients: newClients,
                                );

                                clientStats.add(currentClients);
                                monthIndex++;
                              }

                              int clientIdx = 0;
                              while(clientIdx <= snapshot.data['$currentShopIndex']['client-amount']){
                                if(snapshot.data['$currentShopIndex']['clients']['$clientIdx']['type'] == 'new'
                                && snapshot.data['$currentShopIndex']['clients']['$clientIdx']['appointments'] != 0){
                                  newLabels++;
                                }
                                else if (snapshot.data['$currentShopIndex']['clients']['$clientIdx']['type'] == 'returning'){
                                  returningLabels++;
                                }

                                print("REACHED AFTER ABOUT TO EXECUTE WHILE LOOP 3");


                                ClientData currentClient = ClientData(
                                  clientName: snapshot.data['$currentShopIndex']['clients']['$clientIdx']['name'],
                                  appointmentAmount: snapshot.data['$currentShopIndex']['clients']['$clientIdx']['appointments'],
                                  amountPaid: snapshot.data['$currentShopIndex']['clients']['$clientIdx']['amount-paid'],
                                );

                                clientList.add(currentClient);

                                print("REACHED AFTER ABOUT TO EXECUTE WHILE LOOP 4");

                                clientIdx++;
                              }

                              print("REACHED AFTER ABOUT TO EXECUTE WHILE LOOP 5");

                              int x = 0;
                              while(x < clientList.length){
                                int y = x+1;
                                while(y < clientList.length){
                                  if(clientList[x].amountPaid < clientList[y].amountPaid){
                                    ClientData temp = clientList[x];
                                    clientList[x] = clientList[y];
                                    clientList[y] = temp;
                                  }
                                  y++;
                                }
                                x++;
                              }

                              int clientAmount = snapshot.data['$currentShopIndex']['client-amount'] + 1;
                              int percentageNew = clientAmount == 0?0:((newLabels/clientAmount) * 100).round();
                              int percentageReturning = clientAmount == 0?0:((returningLabels/clientAmount) * 100).round();

                              print("REACHED AFTER ABOUT TO EXECUTE WHILE LOOP 563");

                              print("PNEW: $percentageNew");
                              print("PRETURNING $percentageReturning");

                              ClientTypeData newClientType = ClientTypeData(
                                  itemType: "New",
                                  percentage: int.parse('$percentageNew'),
                                  clientAmount: newLabels
                              );

                              ClientTypeData returningClientType = ClientTypeData(
                                  itemType: "Returning",
                                  percentage: int.parse('$percentageReturning'),
                                  clientAmount: returningLabels
                              );

                              clientTypesData.add(newClientType);
                              clientTypesData.add(returningClientType);



                              filled = true;
                            }

                            print("REACHED AFTER UPDATING CLIENTS");

                            return SfCartesianChart(
                              title: ChartTitle(
                                text: "Clients this year",
                              ),
                              tooltipBehavior: _tooltipBehavior2,
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                                LineSeries<ClientStats,String>(
                                  name: "Client amount",
                                  xAxisName: "Month",
                                  yAxisName: "Amount",
                                  dataSource: clientStats,
                                  xValueMapper: (ClientStats current, _)=>current.month, //
                                  yValueMapper: (ClientStats current, _)=>current.quantity,
                                  enableTooltip: true,
                                ),
                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),

                Positioned(
                  top: 550,
                  left: 0,
                  child: Container(
                    width: 900,
                    height: 400,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            return SfCartesianChart(
                              title: ChartTitle(
                                text: "New and returning clients this year",
                              ),
                              tooltipBehavior: _tooltipBehavior,
                              primaryXAxis: CategoryAxis(),
                              legend: Legend(isVisible:true),
                              series: <ChartSeries>[
                                LineSeries<ClientStats,String>(
                                  name: "Returning Clients",
                                  xAxisName: "Month",
                                  yAxisName: "Amount",
                                  dataSource: clientStats,
                                  xValueMapper: (ClientStats current, _)=>current.month, //
                                  yValueMapper: (ClientStats current, _)=>current.returningClients,
                                  enableTooltip: true,
                                ),
                                LineSeries<ClientStats,String>(
                                  name: "New Clients",
                                  xAxisName: "Month",
                                  yAxisName: "Amount",
                                  dataSource: clientStats,
                                  xValueMapper: (ClientStats current, _)=>current.month, //
                                  yValueMapper: (ClientStats current, _)=>current.newClients,
                                  enableTooltip: true,

                                ),
                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),

                Positioned(
                  top: 1000,
                  left: 0,
                  child: Container(
                    width: 900,
                    height: 400,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Revenue by Type", style: TextStyle(
                                  fontSize: 18,
                                ),),

                                Container(
                                  width: 600,
                                  child: DataTable(
                                      onSelectAll: (b) {},
                                      sortColumnIndex: 1,
                                      sortAscending: true,
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Text("Item type", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          //tooltip: "To display first name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("%",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Clients",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                      ],
                                      rows: clientTypesData
                                          .map(
                                            (current) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(current.itemType),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.percentage}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.clientAmount}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                          ],
                                        ),
                                      )
                                          .toList()),
                                ),

                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),




                Positioned(
                  top: 1200,
                  left: 0,
                  child: Container(
                    width: 900,
                    height: 500,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Top 10 clients by revenue", style: TextStyle(
                                  fontSize: 18,
                                ),),

                                Container(
                                  width: 600,
                                  child: DataTable(
                                      onSelectAll: (b) {},
                                      sortColumnIndex: 1,
                                      sortAscending: true,
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Text("Client", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          //tooltip: "To display first name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Appointments",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Revenue",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                      ],
                                      rows: clientList
                                          .map(
                                            (current) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(current.clientName),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.appointmentAmount}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.amountPaid}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                          ],
                                        ),
                                      )
                                          .toList()),
                                ),

                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      );
    }
    else if(selectedType == "Staff"){
      return Positioned(
        top: 82,
        left: 50,
        child: Container(
          width: 1210,
          height: 1000,
          child: Card(
            elevation: 3.0,
            child: Stack(
              children: [
                Positioned(
                  top: 100,
                  left: 20,
                  child: Container(
                    width: 1100,
                    height: 400,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){



                            if(!filled){

                              appointmentStats = [];
                              revenueStats = [];
                              staffMemberStats = [];



                              Map<String,int> clientList = {};

                              int staffMemberIndex = 0;
                              int staffRevenue = 0;
                              int staffAppointmentAmount = 0;
                              int revenueFromServices = 0;
                              int revenueFromProducts = 0;
                              int revenueFromGiftCards = 0;
                              int revenueFromPackages = 0;
                              int revenueFromMemberShips = 0;
                              int serviceDuration = 0;
                              String serviceDurationString = '';
                              int returningClientsPercentage = 0;
                              int netRevenue = 0;
                              int tax = 0;
                              while(staffMemberIndex < snapshot.data['$currentShopIndex']['staff-members-amount']){
                                if(snapshot.data['$currentShopIndex']['staff-members']['$staffMemberIndex']['member-name'] != "Me"){
                                  int appointmentIndex = 0;
                                  staffRevenue = 0;
                                  staffAppointmentAmount = 0;
                                  revenueFromServices = 0;
                                  revenueFromProducts = 0;
                                  revenueFromGiftCards = 0;
                                  revenueFromPackages = 0;
                                  revenueFromMemberShips = 0;
                                  serviceDuration = 0;
                                  serviceDurationString = '';

                                  int clientIndex = 0;
                                  while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                                    clientList[snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']] = 0;
                                    clientIndex++;
                                  }

                                  while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                    if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['member-name']
                                        == snapshot.data['$currentShopIndex']['staff-members']['$staffMemberIndex']['member-name']
                                        && snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] == 'complete'
                                    ){
                                      print("MEMBER NAME: ${snapshot.data['$currentShopIndex']['staff-members']['$staffMemberIndex']['member-name']}");
                                      int currentServicePrice = int.parse(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-price']);
                                      staffRevenue += currentServicePrice;
                                      staffAppointmentAmount++;
                                      int clientAppointmentAmount = clientList[snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['client-name']]! + 1;
                                      clientList[snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['client-name']] = clientAppointmentAmount;
                                      print("BEFORE TYPE");

                                      String type = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-type'];
                                      print("AFTER TYPE");
                                      if(type == 'Services'){
                                        revenueFromServices += currentServicePrice;
                                      }
                                      else if(type == 'Products'){
                                        revenueFromProducts += currentServicePrice;
                                      }
                                      else if(type == 'Gift Cards'){
                                        revenueFromGiftCards += currentServicePrice;
                                      }
                                      else if(type == 'Packages'){
                                        revenueFromGiftCards += currentServicePrice;
                                      }
                                      else if(type == 'Memberships'){
                                        revenueFromMemberShips += currentServicePrice;
                                      }
                                      print("BEFORE SERVICE DURATION");

                                      String serviceDurationString = snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-duration'];
                                      print("AFTER SERVICE DURATION");
                                      int currentLetterIndex = 0;
                                      String hour = '';
                                      String minute = '';
                                      int hourInt = 0;
                                      int minuteInt = 0;
                                      while(currentLetterIndex < serviceDurationString.length){
                                        if(serviceDurationString[currentLetterIndex] == 'h'){
                                          currentLetterIndex++;
                                          while(serviceDurationString[currentLetterIndex] != 'm'){
                                            minute += serviceDurationString[currentLetterIndex];
                                            currentLetterIndex++;
                                          }
                                          break;
                                        }
                                        else{
                                          hour += serviceDurationString[currentLetterIndex];
                                        }
                                        currentLetterIndex++;
                                      }

                                      print("HOUR GOT: ${hour}");
                                      print("MINUTE GOT: ${minute}");
                                      hourInt = int.parse(hour);
                                      minuteInt = int.parse(minute);
                                      serviceDuration += (hourInt * 60) + minuteInt;

                                    }
                                    appointmentIndex++;
                                  }

                                  print("I FINISHSHSHSHSHSHS");

                                  clientIndex = 0;
                                  while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                                    print(clientList[snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']]);
                                    clientIndex++;
                                  }



                                  int currentStaffClientAmount = 0;
                                  clientIndex = 0;
                                  while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                                    if(clientList[snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']]! > 0){
                                      currentStaffClientAmount++;
                                    }
                                    clientIndex++;
                                  }

                                  int returningAmount = 0;
                                  clientIndex = 0;
                                  while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                                    if(clientList[snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']]! > 1){
                                      returningAmount++;
                                    }
                                    clientIndex++;
                                  }


                                  double returningPercentageDouble;
                                  returningClientsPercentage;

                                  if(currentStaffClientAmount == 0 || returningAmount == 0){
                                    returningClientsPercentage = 0;
                                  }
                                  else{
                                    returningPercentageDouble = (returningAmount/currentStaffClientAmount) * 100;
                                    returningClientsPercentage = returningPercentageDouble.round();
                                  }

                                  int newClientsAmount = currentStaffClientAmount - returningAmount;
                                  int newClientsPercentage = 100 - returningClientsPercentage;



                                  print("SERVICE DURATION: $serviceDuration");
                                  double hourAmountDouble = double.parse('${serviceDuration / 60}');
                                  int hourAmountFromTotal = hourAmountDouble.floor();
                                  print("AFTER CONVERSION : $hourAmountFromTotal");
                                  int minutesLeft = int.parse('${serviceDuration - (hourAmountFromTotal*60)}');
                                  print("AFTER INT CONVERSION: ${minutesLeft}");

                                  serviceDurationString += '${hourAmountFromTotal}h ${minutesLeft}mins';


                                  netRevenue = staffRevenue - (staffRevenue * tax);

                                  StaffMemberStats currentStaffStats = StaffMemberStats(
                                    staffName: snapshot.data['$currentShopIndex']['staff-members']['$staffMemberIndex']['member-name'],
                                    appointmentAmount: staffAppointmentAmount,
                                    revenue: staffRevenue,
                                    revenueFromServices: revenueFromServices,
                                    revenueFromProducts: revenueFromProducts,
                                    revenueFromGiftCards: revenueFromGiftCards,
                                    revenueFromMemberShips: revenueFromMemberShips,
                                    revenueFromPackages: revenueFromPackages,
                                    tax: tax,
                                    totalDuration: serviceDurationString,
                                    returningPercentage: returningClientsPercentage,
                                    netRevenue: netRevenue,
                                    newPercentage: newClientsPercentage,
                                    totalClients: currentStaffClientAmount,

                                  );
                                  staffMemberStats.add(currentStaffStats);
                                }
                                staffMemberIndex++;
                              }

                              int x = 0;
                              while(x < staffMemberStats.length){
                                int y = x+1;
                                while(y < staffMemberStats.length){
                                  if(staffMemberStats[x].revenue < staffMemberStats[y].revenue){
                                    StaffMemberStats temp = staffMemberStats[x];
                                    staffMemberStats[x] = staffMemberStats[y];
                                    staffMemberStats[y] = temp;
                                  }
                                  y++;
                                }
                                x++;
                              }
                              filled = true;
                            }




                            return Container(
                              width: 1300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total staff members by revenue", style: TextStyle(
                                    fontSize: 18,
                                  ),),

                                  Container(
                                    width: 1300,
                                    child: DataTable(
                                        onSelectAll: (b) {},
                                        sortColumnIndex: 1,
                                        sortAscending: true,
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: Text("Staff Member", style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),
                                            numeric: false,
                                            //tooltip: "To display first name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Appointments",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Services",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Products",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Gift Cards",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Packages",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Memberships",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Revenue",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                        ],
                                        rows: staffMemberStats
                                            .map(
                                              (current) => DataRow(
                                            cells: [
                                              DataCell(
                                                Text(current.staffName,style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.appointmentAmount}',style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.revenueFromServices}',style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.revenueFromProducts}',style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.revenueFromGiftCards}',style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.revenueFromPackages}',style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.revenueFromMemberShips}',style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.revenue}',style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                            ],
                                          ),
                                        )
                                            .toList()),
                                  ),

                                ],
                              ),
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),

                Positioned(
                  top: 400,
                  left: 10,
                  child: Container(
                    width: 1200,
                    height: 400,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            return Container(
                              width: 1100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Staff performance summary", style: TextStyle(
                                    fontSize: 18,
                                  ),),

                                  Container(
                                    width: 1200,
                                    child: DataTable(
                                        onSelectAll: (b) {},
                                        sortColumnIndex: 1,
                                        sortAscending: true,
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: Text("Staff Member", style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),),
                                            numeric: false,
                                            //tooltip: "To display first name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Appointments",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Service duration",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Total Clients",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("% of returning clients",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("% of new clients",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Revenue net",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Total Revenue",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),),
                                            numeric: false,
                                            // tooltip: "To display last name of the Name",
                                          ),
                                        ],
                                        rows: staffMemberStats
                                            .map(
                                              (current) => DataRow(
                                            cells: [
                                              DataCell(
                                                Text(current.staffName, style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.appointmentAmount}', style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.totalDuration}', style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.totalClients}', style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.returningPercentage}', style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.newPercentage}', style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.netRevenue}', style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text('${current.revenue}', style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                            ],
                                          ),
                                        )
                                            .toList()),
                                  ),

                                ],
                              ),
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    }
    else if(selectedType == "Revenue"){
      return Positioned(
        top: 82,
        left: 102,
        child: Container(
          width: 1095,
          height: 1000,
          child: Card(
            elevation: 3.0,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(
                    width: 800,
                    height: 350,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            if(!filled){

                              appointmentStats = [];
                              revenueStats = [];

                              int monthIndex = 0;
                              while(monthIndex < months.length){
                                AppointmentStats currentMonthStats = AppointmentStats(
                                  month: double.parse('$monthIndex'),
                                  appointmentAmount: double.parse('${snapshot.data['$currentShopIndex']['appointment-stats'][months[monthIndex]]['appointment-amount']}'),
                                  revenue: double.parse('${snapshot.data['$currentShopIndex']['appointment-stats'][months[monthIndex]]['appointment-revenue']}'),
                                );

                                appointmentStats.add(currentMonthStats);
                                monthIndex++;
                              }

                              int typeIndex = 0;
                              List<String> appointmentTypes = ['Services','Products','Packages','Memberships','Gift Cards', 'Cancellation fees'];
                              while(typeIndex < appointmentTypes.length){
                                int appointmentIndex = 0;
                                int currentAmount = 0;
                                int currentValue = 0;
                                while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){
                                  if(appointmentTypes[typeIndex] == snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-type']){
                                    if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] != 'incomplete'){
                                      currentValue += int.parse(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-price']);
                                      currentAmount++;
                                    }
                                  }
                                  appointmentIndex++;
                                }

                                //cur   print("CURRENT AMOUNT: $currentAmount");

                                AppointmentRevenueStats currentRevenueStats = AppointmentRevenueStats(
                                    type: appointmentTypes[typeIndex],
                                    quantity: currentAmount,
                                    percent: (currentAmount != 0)?'${(currentAmount /(snapshot.data['$currentShopIndex']['appointments']['appointment-amount'] + 1))*100}%':'0%',
                                    value: '$currentValue'
                                );

                                revenueStats.add(currentRevenueStats);
                                typeIndex++;
                              }
                              filled = true;
                            }

                            return SfCartesianChart(
                              title: ChartTitle(
                                text: "Revenue this year",
                              ),
                              primaryXAxis: CategoryAxis(),
                              tooltipBehavior: _tooltipBehavior3,
                              series: <ChartSeries>[
                                LineSeries<AppointmentStats,String>(
                                  name: "Revenue",
                                  markerSettings: MarkerSettings(
                                      isVisible: true
                                  ),
                                  xAxisName: "Month",
                                  yAxisName: "Amount",
                                  dataSource: appointmentStats,
                                  xValueMapper: (AppointmentStats current, _)=>months[int.parse('${current.month}')], //
                                  yValueMapper: (AppointmentStats current, _)=>current.revenue,
                                  enableTooltip: true,
                                ),
                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),

                Positioned(
                  top: 550,
                  left: 0,
                  child: Container(
                    width: 900,
                    height: 400,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total revenue by type", style: TextStyle(
                                  fontSize: 18,
                                ),),

                                Container(
                                  width: 600,
                                  child: DataTable(
                                      onSelectAll: (b) {},
                                      sortColumnIndex: 1,
                                      sortAscending: true,
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Text("Item Type", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          //tooltip: "To display first name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Percent",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Revenue",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                      ],
                                      rows: revenueStats
                                          .map(
                                            (current) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(current.type),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.percent}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.value}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                          ],
                                        ),
                                      )
                                          .toList()),
                                ),

                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if(selectedType == "Inventory"){
      return Positioned(
        top: 82,
        left: 102,
        child: Container(
          width: 1100,
          height: 1000,
          child: Card(
            elevation: 3.0,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(
                    width: 700,
                    height: 130,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){

                            int productsInStock = 0;
                            int productsInStockValue = 0;

                            int productIndex = 0;
                            while(productIndex <= snapshot.data['$currentShopIndex']['products-amount']){
                              int currentProductStock = snapshot.data['$currentShopIndex']['products']['$productIndex']['product-stock']!;
                              int currentProductValue = snapshot.data['$currentShopIndex']['products']['$productIndex']['product-price']!;
                              productsInStock += currentProductStock;
                              productsInStockValue += (currentProductValue * currentProductStock);
                              productIndex++;
                            }


                            return Card(
                              elevation: 2.0,
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Column(
                                    children: [
                                      SizedBox(height: 30,),
                                      Text("Products in stock", style: TextStyle(
                                        fontSize: 20,
                                      ),),
                                      SizedBox(height: 10,),
                                      Text("$productsInStock",style: TextStyle(
                                        fontSize: 20,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(width: 250,),
                                  Column(
                                    children: [
                                      SizedBox(height: 30,),
                                      Text("Stock Value",style: TextStyle(
                                        fontSize: 20,
                                      ),),
                                      SizedBox(height: 10,),
                                      Text("$productsInStockValue EGP",style: TextStyle(
                                        fontSize: 20,
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                        return const Text("Please wait");
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  left: 50,
                  child: Container(
                    width: 1000,
                    height: 250,
                    child: FutureBuilder(
                      future: categoryData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return const Text("There is an error");
                          }
                          else if(snapshot.hasData){

                            int currentProductsInStock = 0;
                            int productRevenueFromPurchases = 0;
                            int productsInStockValue = 0;
                            Map<String, int> productsAmount = {};
                            Map<String,bool> clientPurchased = {};
                            int clientAmount = 0;
                            List<ProductData> productsData = [];
                            int amountPurchased = 0;

                            int productIndex = 0;
                            while(productIndex <= snapshot.data['$currentShopIndex']['products-amount']){


                              clientAmount = 0;

                              int clientIndex = 0;
                              while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                                clientPurchased[snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']] = false;
                                clientIndex++;
                              }


                              currentProductsInStock = 0;
                              amountPurchased = 0;
                              int currentProductStock = snapshot.data['$currentShopIndex']['products']['$productIndex']['product-stock']!;
                              int currentProductValue = snapshot.data['$currentShopIndex']['products']['$productIndex']['product-price']!;
                              currentProductsInStock += currentProductStock;
                              productsInStockValue += (currentProductValue) * currentProductsInStock;
                              productsAmount[snapshot.data['$currentShopIndex']['products']['$productIndex']['product-name']] = currentProductsInStock;

                              productRevenueFromPurchases = 0;
                              int appointmentIndex = 0;

                              while(appointmentIndex <= snapshot.data['$currentShopIndex']['appointments']['appointment-amount']){

                                if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-type'] == "Products"){
                                  if(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-name'] ==
                                      snapshot.data['$currentShopIndex']['products']['$productIndex']['product-name']){


                                    clientPurchased[snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['client-name']] = true;


                                    amountPurchased++;
                                    productRevenueFromPurchases += int.parse(snapshot.data['$currentShopIndex']['appointments']['$appointmentIndex']['service-price']);
                                  }
                                }

                                appointmentIndex++;
                              }

                              clientIndex = 0;
                              while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                                if(clientPurchased[snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']]!){
                                  clientAmount++;
                                }
                                clientIndex++;
                              }



                              ProductData currentProductData = ProductData(
                                  productName: snapshot.data['$currentShopIndex']['products']['$productIndex']['product-name'],
                                  productRevenue: productRevenueFromPurchases,
                                  productAmount: productsAmount[snapshot.data['$currentShopIndex']['products']['$productIndex']['product-name']]!,
                                  amountPurchased: amountPurchased,
                                  clientAmount: clientAmount,
                              );

                              productsData.add(currentProductData);


                              productIndex++;
                            }


                            int x = 0;
                            while(x < productsAmount.length){
                              int y = x+1;
                              while(y < productsAmount.length){
                                if(productsData[x].productRevenue < productsData[y].productRevenue){
                                  ProductData temp = productsData[x];
                                  productsData[x] = productsData[y];
                                  productsData[y] = temp;
                                }
                               y++;
                              }
                              x++;
                            }


                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total revenue by product", style: TextStyle(
                                  fontSize: 18,
                                ),),

                                Container(
                                  width: 800,
                                  child: DataTable(
                                      onSelectAll: (b) {},
                                      sortColumnIndex: 1,
                                      sortAscending: true,
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Text("Name", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          //tooltip: "To display first name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Amount in stock",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Amount purchased",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Clients",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                        DataColumn(
                                          label: Text("Revenue",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          numeric: false,
                                          // tooltip: "To display last name of the Name",
                                        ),
                                      ],
                                      rows: productsData
                                          .map(
                                            (current) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(current.productName),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.productAmount}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.amountPurchased}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.clientAmount}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              Text('${current.productRevenue}'),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                          ],
                                        ),
                                      )
                                          .toList()),
                                ),

                              ],
                            );
                          }
                        }
                        return const Text("Please wait");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if(selectedType == "Cash Flow"){

    }
    else if(selectedType == "Marketing"){


      // MARKETING FUNCTIONALITY

    }
    return Container();
  }
}
