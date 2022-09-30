import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';


class AddStaffMembers extends StatefulWidget {
  const AddStaffMembers({Key? key}) : super(key: key);

  @override
  _AddStaffMembersState createState() => _AddStaffMembersState();
}

class _AddStaffMembersState extends State<AddStaffMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Staff Members"),
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
          child: Column(
            children: [
              SizedBox(height: 50,),
              Card(
                elevation: 5.0,
                child: Container(
                  width: 400,
                  height: 400,
                  child: ListView.builder(
                      itemCount: staffMembers.length,
                      itemBuilder: (context,index){
                        return Container(
                          width: 200,
                          height: 70,
                          margin: EdgeInsets.all(5),
                          child: Card(
                            elevation: 1.0,
                            child: ListTile(
                              title: Text(staffMembers[index].name),
                              subtitle: Text(staffMembers[index].role),
                            ),
                          ),
                        );
                      }),
                ),
              ),

              Container(
                width: 400,
                height: 70,
                child: Center(
                  child: Card(
                    elevation: 1.0,
                    child: ListTile(
                      onTap: (){
                        Navigator.pushNamed(context, '/add-staff-members-details');
                      },
                      leading: Icon(Icons.add),
                      title: Text("Add staff member"),

                    ),
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



                    int staffIndex = 0;
                    while(staffIndex < staffMembers.length - 1){
                      print("$staffIndex: ${serviceStaffMembers[staffIndex]}");
                      staffIndex++;
                    }


                    Navigator.pushNamed(context, '/profile-ready');
                  },
                  child: Text("Continue", style: TextStyle(
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
