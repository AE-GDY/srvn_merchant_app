import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/database.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  Future<Map<String, dynamic>?> userData() async {
    return (await FirebaseFirestore.instance.collection('users').
    doc("signed-up").get()).data();
  }

  bool showError = false;

  DatabaseService databaseService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: 1500,
          height: 1000,
          child: Stack(
            children: [



              Positioned(
                top: 15,
                left: 15,
                child: Container(
                  width: 90,
                  height: 90,
                  child:  Image.asset('assets/SRVN-logo.png'),
                ),
              ),

              Positioned(
                top: 30,
                left: 1025,
                child: Container(
                  width: 180,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextButton(
                    onPressed: () {

                      setState(() {
                        services.clear();

                        possibleMinutes = [
                          '00',
                          '15',
                          '30',
                          '45',
                        ];

                        staffMembers.clear();
                        minuteGap = 5;

                        businessHoursAvailability.clear();

                      });

                      Navigator.pushNamed(context, '/shop-name');
                    },
                    child: Text("Register", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),),
                  )
                ),
              ),

              Positioned(
                top: 230,
                left: 80,
                child: Container(
                  width: 500,
                  height: 500,
                  child: Column(
                    children: [
                      Text("Welcome to Srvn!", style: TextStyle(
                        color:Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 20,),
                      Text("Looking for complete control over your business?", style: TextStyle(
                          color:Colors.black,
                          fontSize: 20,
                      ),),

                      SizedBox(height: 100,),
                      Container(
                          width: 250,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/shop-name');
                            },
                            child: Text("Register Now", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          )
                      ),

                    ],
                  ),
                ),
              ),


              Positioned(
                top: 150,
                left: 700,
                child: Card(
                  elevation: 1.0,
                  child: Container(
                    width: 500,
                    height: 500,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView(
                          children: <Widget>[
                            SizedBox(height: 30,),
                            /*
                             Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    SizedBox(width: 105,),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: 100,
                                      height: 50,
                                      child: TextButton(
                                        onPressed: (){},
                                        child: Center(
                                          child: Text("Login", style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 40,),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue,
                                      ),
                                      width: 100,
                                      height: 50,

                                      child: TextButton(
                                        onPressed: (){
                                          Navigator.pushNamed(context, '/shop-name');
                                        },
                                        child: Center(
                                          child: Text("Sign up", style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                            */
                            Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                )),
                            SizedBox(height: 20,),
                            Container(
                              decoration: BoxDecoration(
                                //border: Border.all(color: Colors.black, width: 1.0),
                              ),
                              width: 120,
                              child: DropdownButton<String>(
                                value: selectedCategory,
                                //icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                //style: const TextStyle(color: Colors.deepPurple),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCategory = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Barbershop',
                                  'Hair Salon',
                                  'Spa',
                                ]
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              height: 100,
                              padding: const EdgeInsets.all(5),
                              child: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  focusColor: Colors.deepPurple,
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: TextField(
                                obscureText: true,
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                            SizedBox(height: 50,),
                            /*
                            TextButton(
                              onPressed: () {
                                //forgot password screen
                              },
                              child: const Text('Forgot Password',),
                            ),
                            */

                            FutureBuilder(
                              future: Future.wait([categoryData(),userData()]),
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  if(snapshot.hasError){
                                    return const Text("There is an error");
                                  }
                                  else if(snapshot.hasData){
                                    return Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.deepPurple,
                                        ),
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: TextButton(
                                          child: const Text('Log in', style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                          onPressed: () async {

                                            int noShowAmount = snapshot.data[0]['$currentShopIndex']['appointments']['no-shows'];

                                            int appointmentIndex = 0;
                                            while(appointmentIndex <= snapshot.data[0]['$currentShopIndex']['appointments']['appointment-amount']){


                                              if(snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['appointment-status'] == 'incomplete'){


                                                if(snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['start-day'] < DateTime.now().day
                                                && snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['start-month'] <= DateTime.now().month
                                                && snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['start-year'] <= DateTime.now().year){
                                                  noShowAmount++;
                                                  await databaseService.appointmentNoShow(
                                                      selectedCategory,
                                                      currentShopIndex,
                                                      appointmentIndex,
                                                      noShowAmount
                                                  );


                                                  String clientEmail = snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['client-email'];

                                                  int userIndex = 0;
                                                  while(userIndex <= snapshot.data[1]['total-user-amount']){

                                                    if(clientEmail == snapshot.data[1]['$userIndex']['email']){
                                                      await databaseService.updateUserAppointmentStatus(
                                                          userIndex,
                                                          snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['user-appointment-index']
                                                      );
                                                      break;
                                                    }
                                                    userIndex++;
                                                  }
                                                }

                                                else{
                                                  if(snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['start-day'] <= DateTime.now().day){
                                                    if(snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['start-month'] <= DateTime.now().month){
                                                      if(snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['start-year'] <= DateTime.now().year) {

                                                        if(snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['start-hour-actual'] < DateTime.now().hour){

                                                          noShowAmount++;
                                                          await databaseService.appointmentNoShow(
                                                              selectedCategory,
                                                              currentShopIndex,
                                                              appointmentIndex,
                                                              noShowAmount
                                                          );


                                                          String clientEmail = snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['client-email'];

                                                          int userIndex = 0;
                                                          while(userIndex <= snapshot.data[1]['total-user-amount']){

                                                            if(clientEmail == snapshot.data[1]['$userIndex']['email']){
                                                              await databaseService.updateUserAppointmentStatus(
                                                                  userIndex,
                                                                  snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['user-appointment-index']
                                                              );
                                                              break;
                                                            }
                                                            userIndex++;
                                                          }

                                                        }
                                                        else if(snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['start-hour-actual'] == DateTime.now().day){
                                                          if(snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['start-minutes'] < DateTime.now().minute){

                                                            noShowAmount++;
                                                            await databaseService.appointmentNoShow(
                                                                selectedCategory,
                                                                currentShopIndex,
                                                                appointmentIndex,
                                                                noShowAmount
                                                            );

                                                            String clientEmail = snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['client-email'];

                                                            int userIndex = 0;
                                                            while(userIndex <= snapshot.data[1]['total-user-amount']){

                                                              if(clientEmail == snapshot.data[1]['$userIndex']['email']){
                                                                await databaseService.updateUserAppointmentStatus(
                                                                    userIndex,
                                                                    snapshot.data[0]['$currentShopIndex']['appointments']['$appointmentIndex']['user-appointment-index']
                                                                );
                                                                break;
                                                              }
                                                              userIndex++;
                                                            }

                                                          }
                                                        }

                                                      }
                                                    }
                                                  }
                                                }
                                              }

                                              appointmentIndex++;
                                            }







                                            int shopIndex = 0;
                                            bool isAvailable = false;
                                            while(shopIndex < snapshot.data[0]['total-shop-amount']+1){
                                              int userIndex = 0;
                                              while(userIndex <= snapshot.data[0]['$shopIndex']['user-amount']){
                                                if(snapshot.data[0]['$shopIndex']['users']['$userIndex']['email'] == nameController.text){
                                                  if(snapshot.data[0]['$shopIndex']['users']['$userIndex']['password'] == passwordController.text){
                                                    setState(() {
                                                      currentUserIndex = userIndex;
                                                      currentShopIndex = shopIndex;
                                                      shopName = snapshot.data[0]['$shopIndex']['shop-name'];
                                                      shopAddress = snapshot.data[0]['$shopIndex']['shop-address'];
                                                      shopDescription = snapshot.data[0]['$shopIndex']['shop-description'];
                                                      isAvailable = true;
                                                    });
                                                    break;
                                                  }
                                                }
                                                userIndex++;
                                              }
                                              if(isAvailable){
                                                break;
                                              }
                                              shopIndex++;
                                            }

                                            if(!isAvailable){
                                              setState(() {
                                                showError = true;
                                              });
                                            }
                                            else{
                                              Navigator.pushNamed(context, '/dashboard');
                                            }

                                          },
                                        )
                                    );
                                  }
                                }
                                return const Text("Please wait");
                              },
                            ),
                            /*
                            Row(
                              children: <Widget>[
                                const Text('Don\'t have an account?'),
                                TextButton(
                                  child: const Text(
                                    'Register here!',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/shop-name');
                                  },
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            */
                          ],
                        )),
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



/*
 class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          Menu(),
          // MediaQuery.of(context).size.width >= 980
          //     ? Menu()
          //     : SizedBox(), // Responsive
          Body()
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _menuItem(title: 'Home'),
              _menuItem(title: 'About us'),
              _menuItem(title: 'Contact us'),
              _menuItem(title: 'Help'),
            ],
          ),
          Row(
            children: [
              _menuItem(title: 'Sign In', isActive: true),
              _registerButton()
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.deepPurple : Colors.grey,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            isActive
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            spreadRadius: 10,
            blurRadius: 12,
          ),
        ],
      ),
      child: Text(
        'Register',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In to \nMy Application',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "If you don't have an account",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "You can",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      print(MediaQuery.of(context).size.width);
                    },
                    child: Text(
                      "Register here!",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'images/illustration-2.png',
                width: 300,
              ),
            ],
          ),
        ),

        Image.asset(
          'images/illustration-1.png',
          width: 300,
        ),
        // MediaQuery.of(context).size.width >= 1300 //Responsive
        //     ? Image.asset(
        //         'images/illustration-1.png',
        //         width: 300,
        //       )
        //     : SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: Container(
            width: 320,
            child: _formLogin(),
          ),
        )
      ],
    );
  }

  Widget _formLogin() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter email or Phone number',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            hintText: 'Password',
            counterText: 'Forgot password?',
            suffixIcon: Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple[100],
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Sign In"))),
            onPressed: () => print("it's pressed"),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        Row(children: [
          Expanded(
            child: Divider(
              color: Colors.grey[300],
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Or continue with"),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              height: 50,
            ),
          ),
        ]),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _loginWithButton(image: 'images/google.png'),
            _loginWithButton(image: 'images/github.png', isActive: true),
            _loginWithButton(image: 'images/facebook.png'),
          ],
        ),
      ],
    );
  }

  Widget _loginWithButton({String image, bool isActive = false}) {
    return Container(
      width: 90,
      height: 70,
      decoration: isActive
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  spreadRadius: 10,
                  blurRadius: 30,
                )
              ],
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey[400]),
            ),
      child: Center(
          child: Container(
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    spreadRadius: 2,
                    blurRadius: 15,
                  )
                ],
              )
            : BoxDecoration(),
        child: Image.asset(
          '$image',
          width: 35,
        ),
      )),
    );
  }
}
*/
