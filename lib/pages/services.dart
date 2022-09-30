import 'package:flutter/material.dart';

import '../constants.dart';


class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Services"),
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
                top: 0,
                left: 0,
                child: Container(
                  width: 250,
                  height: 1500,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text("Dashboard"),
                        onTap: () => {Navigator.popAndPushNamed(context, '/dashboard')},
                      ),
                      ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text("Upcoming appointments"),
                        onTap: () => {Navigator.popAndPushNamed(context, 'Cal')},
                      ),
                      ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text("Services"),
                        onTap: () => {Navigator.popAndPushNamed(context, '/services')},
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text("Staff Members"),
                        onTap: () => null,
                      ),
                      ListTile(
                        leading: Icon(Icons.insert_chart_outlined),
                        title: Text("Statistics and Reports"),
                        onTap: () => {Navigator.popAndPushNamed(context, 'Rep')},
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text("Settings"),
                        onTap: () => null,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 200,
                child: Container(
                  width: 200,
                  height: 400,
                  child: ListView.builder(
                      itemCount: services.length,
                      itemBuilder: (context, index){
                        return Card(
                          elevation: 1.0,
                          child: ListTile(
                            title: Text(services[index].title),
                            subtitle: Text("${services[index].hours} ${services[index].minutes}"),
                            trailing: Text("${services[index].price} EGP"),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
