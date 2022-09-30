import 'package:flutter/material.dart';

import '../constants.dart';


class AddingServices extends StatefulWidget {
  const AddingServices({Key? key}) : super(key: key);

  @override
  _AddingServicesState createState() => _AddingServicesState();
}

class _AddingServicesState extends State<AddingServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: true,
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
          height: 1000,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Card(
                elevation: 2.0,
                child: Container(
                  width: 550,
                  height: 500,
                  child: Column(
                    children: [
                      SizedBox(height: 30,),

                      Text("Start Adding Services", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 30,),
                      Expanded(
                        child: ListView.builder(
                            itemCount: services.length,
                            itemBuilder: (context,index){
                              return Container(
                                margin: EdgeInsets.all(5),
                                width: 480,
                                height: 80,
                                child: Row(
                                  children: [
                                    Container(
                                      child: Card(
                                        elevation: 1.0,
                                        child: ListTile(
                                          title: Text(services[index].title, style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          subtitle: Text('${services[index].hours} ${services[index].minutes}'),
                                          trailing:  Text('${services[index].price} EGP'),
                                        ),
                                      ),
                                      width: 450,
                                      height: 80,
                                    ),

                                    SizedBox(width: 30,),
                                   IconButton(iconSize:20,onPressed: (){
                                    setState(() {
                                      services.remove(services[index]);
                                    });
                                   }, icon: Icon(Icons.delete)),

                                  ],
                                ),
                              );


                            }
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/service-details');
                        },
                        child: Card(
                          elevation: 1.0,
                          child: ListTile(
                            leading: Icon(Icons.add),
                            title: Text("Add service"),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/business-hours');
                          },
                          child: Center(
                            child: Text("Continue", style: TextStyle(
                              color: Colors.white,
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
