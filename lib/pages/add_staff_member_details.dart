import 'package:flutter/material.dart';
import 'package:servnn_client_side/constants.dart';
import 'package:servnn_client_side/models/staff_member.dart';


class AddStaffMemberDetails extends StatefulWidget {
  const AddStaffMemberDetails({Key? key}) : super(key: key);

  @override
  _AddStaffMemberDetailsState createState() => _AddStaffMemberDetailsState();
}

class _AddStaffMemberDetailsState extends State<AddStaffMemberDetails> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();
  Map<String, Map<String, bool>> availability = Map();


  // Stores services selected for the staff member to be added
  Map<String, String> currentStaffServices = {};


  // Checks if service has been selected for the staff member to be added
  bool findService(String service){
    int index = 0;

    while(index < currentStaffServices.length){
      if(service == currentStaffServices['$index']){
        return true;
      }
      index++;
    }
    return false;
  }

  bool initialEdit = true;

  List<bool> serviceSelected = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Staff Member Details"),
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
          alignment: Alignment.center,
          width: 1500,
          height: 1500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100,),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 500,
                      height: 600,
                      child: Card(
                        elevation: 5.0,
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Container(
                              margin: EdgeInsets.all(5),
                              width: 400,
                              height: 200,
                              child: Column(
                                children: [

                                  Text('Staff Member Information', style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),),

                                  SizedBox(height: 20,),

                                  TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      labelText: "Staff member name",
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  TextField(
                                    controller: roleController,
                                    decoration: InputDecoration(
                                      labelText: "Staff member role",
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text('Staff Member Services', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),),

                            Container(
                              alignment: Alignment.center,
                              width: 500,
                              height: 250,
                              child: ListView.builder(
                                  itemCount: services.length,
                                  itemBuilder: (context,index){

                                    if(initialEdit){
                                      int serviceIndex = 0;
                                      while(serviceIndex < services.length){
                                        serviceSelected.add(false);
                                        serviceIndex++;
                                      }
                                    }

                                    return ListTile(
                                      leading: Switch(
                                        activeColor: Colors.deepPurple,
                                        value: serviceSelected[index],
                                        onChanged: (bool value) {
                                          setState(() {
                                            serviceSelected[index] = !serviceSelected[index];
                                          });
                                        },

                                      ),
                                      title: Text(services[index].title),
                                      subtitle:   Text("${services[index].hours} ${services[index].minutes}"),
                                      trailing: Text(services[index].price + " EGP",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    );
                                  }
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 30,),

              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 350,
                height: 50,
                child: TextButton(
                  onPressed: (){
                    StaffMember newMember = StaffMember(
                      role: roleController.text,
                      services: [],
                      name: nameController.text,
                      availability: businessHoursAvailability,
                    );


                    int serviceIndex= 0;
                    int mapIndex = 0;

                    while(serviceIndex < services.length){
                      if(serviceSelected[serviceIndex]){
                        currentStaffServices['$mapIndex'] = services[serviceIndex].title;
                        mapIndex++;
                      }

                      serviceIndex++;
                    }

                    serviceStaffMembers.add(currentStaffServices);

                    setState(() {
                      staffMembers.add(newMember);
                    });

                    Navigator.pushNamed(context, '/add-staff-members');

                  },
                  child: Text("Add Staff Member",style: TextStyle(
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