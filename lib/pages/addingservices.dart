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
              SizedBox(height: 100,),
              Card(
                elevation: 2.0,
                child: Container(
                  width: 500,
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
                                height: 60,
                                child: Card(
                                  elevation: 1.0,
                                  child: ListTile(
                                    dense: true,
                                    title: Text(services[index].title),
                                    trailing: Text('${services[index].hours} ${services[index].minutes}   ${services[index].price} EGP'),
                                  ),
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
                        width: 250,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
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
