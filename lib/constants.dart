import 'package:flutter/material.dart';
import 'package:servnn_client_side/models/service.dart';
import 'package:servnn_client_side/models/staff_member.dart';


List<String> months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];


List<String> monthsFull = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];



List<String> shopClients = [];
List<int> clientsDatabaseIndexes = [];
List<String> shopClientsEmails = [];
List<String> shopMemberships = [];
String currentClient = '';
String currentClientEmail = '';
int currentClientIndex = 0;

DateTime timePicked = DateTime.now();

int globalYearBound = 2022;
int globalMonthBound = 1;
int globalDayBound = 1;
String userName = '';
String password = '';
String shopName = '';
String shopAddress = '';
String shopDescription = '';
String phoneNumber = '';
int currentShopIndex = 0;

int currentTransactionIndex = 0;

List<dynamic> serviceBooked = [];
List<dynamic> serviceDuration = [];
List<dynamic> servicePrice = [];
List<int> currentTime = [];

String selectedPage = 'dashboard';
double iconSize = 23.0;
Color? mainColor = Colors.blueGrey[600];


List<String> categories = [
  'Barbershop',
  'Hair Salon',
  'Spa',
];

String selectedCategory = 'Spa';


List<Service> services = [

];


List<ServiceToBook> cart = [];
double currentTotal = 0.00;


List<StaffMember> staffMembers = [
  StaffMember(name: 'Me',role: 'Owner', services: [], availability: {}),
];


List<bool> daySelected = [false,false,false,false,false,false,false];

Map<String,Map<String,dynamic>> businessHours = {
  'Sunday': {
    'from':'10:00 AM',
    'to': '10:00 PM',
    'day-off': false,
  },
  'Monday': {
    'from':'10:00 AM',
    'to': '10:00 PM',
    'day-off': false,
  },
  'Tuesday': {
    'from':'10:00 AM',
    'to': '10:00 PM',
    'day-off': false,
  },
  'Wednesday': {
    'from':'10:00 AM',
    'to': '10:00 PM',
    'day-off': false,
  },
  'Thursday': {
    'from':'10:00 AM',
    'to': '10:00 PM',
    'day-off': false,
  },
  'Friday': {
    'from':'10:00 AM',
    'to': '10:00 PM',
    'day-off': false,
  },
  'Saturday': {
    'from':'10:00 AM',
    'to': '10:00 PM',
    'day-off': false,
  },
};


int minuteGap = 5;

List<String> possibleHours = [
  '10',
  '11',
  '12',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
];


List<List<String>> serviceLinkedPossibleHours = [];

List<List<String>> serviceLinkedPossibleMinutes = [];

List<List<String>> serviceLinkedPossibleTimings = [];



List<TextEditingController> amountPerTimingControllers = [];



List<String> possibleMinutes = [
  '00',
  '15',
  '30',
  '45',
];

List<String> possibleTimings = [];



Map<String,Map<String,String>> businessHoursAvailability = {
  'Sunday': {},
  'Monday': {},
  'Tuesday': {},
  'Wednesday': {},
  'Thursday': {},
  'Friday': {},
  'Saturday': {},
};


List<bool> servicesLinkedStatus = [];

List<Map<String,Map<String,String>>> serviceLinkedBusinessHoursAvailability = [];


List<String> weekDays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

String currentDayWorkingHoursToChange = '';

List<int> serviceLinkedMinuteGaps = [];

// List that stores list of staff members for each service
List<Map<String,String>> serviceStaffMembers = [];


// The index of the promotion that will be edited
int promotionToBeEdited = 0;

// The type of the promotion that will be edited
String promotionType = "";

