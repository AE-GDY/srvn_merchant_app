import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servnn_client_side/pages/add_staff_member_details.dart';
import 'package:servnn_client_side/pages/addingservices.dart';
import 'package:servnn_client_side/pages/business_category.dart';
import 'package:servnn_client_side/pages/business_hours.dart';
import 'package:servnn_client_side/pages/business_hours_details.dart';
import 'package:servnn_client_side/pages/dashboard.dart';
import 'package:servnn_client_side/pages/login.dart';
import 'package:servnn_client_side/pages/profile_ready.dart';
import 'package:servnn_client_side/pages/service_details.dart';
import 'package:servnn_client_side/pages/services.dart';
import 'package:servnn_client_side/pages/shop_name.dart';
import 'package:servnn_client_side/pages/staff_members.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:servnn_client_side/pages_logged_in/active-promotions.dart';
import 'package:servnn_client_side/pages_logged_in/add_membership.dart';
import 'package:servnn_client_side/pages_logged_in/add_new_client.dart';
import 'package:servnn_client_side/pages_logged_in/add_package.dart';
import 'package:servnn_client_side/pages_logged_in/add_product.dart';
import 'package:servnn_client_side/pages_logged_in/add_service.dart';
import 'package:servnn_client_side/pages_logged_in/add_staff.dart';
import 'package:servnn_client_side/pages_logged_in/block_hours.dart';
import 'package:servnn_client_side/pages_logged_in/bookingscreen.dart';
import 'package:servnn_client_side/pages_logged_in/business_hours_logged_in.dart';
import 'package:servnn_client_side/pages_logged_in/confirm_cancelation.dart';
import 'package:servnn_client_side/pages_logged_in/confirm_purchase.dart';
import 'package:servnn_client_side/pages_logged_in/delete_promotion.dart';
import 'package:servnn_client_side/pages_logged_in/delete_service.dart';
import 'package:servnn_client_side/pages_logged_in/delete_staff_member.dart';
import 'package:servnn_client_side/pages_logged_in/edit_business_hours.dart';
import 'package:servnn_client_side/pages_logged_in/edit_promotion.dart';
import 'package:servnn_client_side/pages_logged_in/edit_service.dart';
import 'package:servnn_client_side/pages_logged_in/edit_staff_member.dart';
import 'package:servnn_client_side/pages_logged_in/image_upload.dart';
import 'package:servnn_client_side/pages_logged_in/marketing.dart';
import 'package:servnn_client_side/pages_logged_in/pos.dart';
import 'package:servnn_client_side/pages_logged_in/promotions.dart';
import 'package:servnn_client_side/pages_logged_in/services_page.dart';
import 'package:servnn_client_side/pages_logged_in/staff_members_page.dart';
import 'package:flutter/gestures.dart';
import 'package:servnn_client_side/pages_logged_in/stats_and_reports.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBHir7HYBFXHpy2VFaP7pjmtvOZ5bDaMhM",
      //authDomain: "servnn.firebaseapp.com",// Your apiKey
      appId: "1:595600611199:web:8d36c71470591ce54dac4a", // Your appId
      messagingSenderId: "595600611199", // Your messagingSenderId
      projectId: "servnn", // Your projectId
      storageBucket: "servnn.appspot.com",
    ),
  );

  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.deepPurple),
          ),

        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login':(context) => Login(),
        '/shop-name':(context) => ShopName(),
        '/business-category':(context) => BusinessCategory(),
        '/adding-services':(context) => AddingServices(),
        '/service-details': (context) => ServiceDetails(),
        '/business-hours': (context) => BusinessHours(),
        '/busines-hours-details':(context) => BusinessHoursDetails(),
        '/add-staff-members':(context) => AddStaffMembers(),
        '/add-staff-members-details':(context) => AddStaffMemberDetails(),
        '/profile-ready':(context) => ProfileReady(),
        '/dashboard':(context) => DashBoard(),
        '/services':(context) => Services(),
        '/services-page':(context) => ServicesPage(),
        '/edit-service':(context) => EditService(),
        '/add-service':(context) => addService(),
        '/add-staff':(context) => AddStaffMember(),
        '/staff-members-page':(context) => StaffMembersPage(),
        '/POS': (context) => Pos(),
        '/booking-screen':(context) => BookingScreen(),
        '/complete-transaction': (context) => ConfirmPurchase(),
        '/complete-cancellation': (context) => ConfirmCancellation(),
        '/stats-and-reports': (context) => StatsAndReports(),
        '/add-client': (context) => AddClient(),
        '/add-product': (context) => AddProduct(),
        '/add-package': (context) => AddPackage(),
        '/marketing': (context) => Marketing(),
        '/add-promotion': (context) => AddPromotion(),
        '/active-promotions': (context) => ActivePromotions(),
        '/edit-promotion': (context) => EditPromotion(),
        '/delete-promotion': (context) => DeletePromotion(),
        '/delete-service': (context) => DeleteService(),
        '/edit-member': (context) => EditStaffMember(),
        '/delete-member': (context) => DeleteStaffMember(),
        '/business-hours-logged-in': (context) => BusinessHoursLoggedIn(),
        '/edit-business-hours': (context) => EditBusinessHours(),
        '/block-hours': (context) => BlockHours(),
        '/image-upload': (context) => ImageUpload(),
        '/add-membership': (context) => AddMembership(),
      },
    );
  }
}