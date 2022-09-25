import 'package:flutter/material.dart';


class Service{
  String title;
  String hours;
  String minutes;
  String price;
  int maxBookings;
  int gap;

  Service({
    required this.title,
    required this.hours,
    required this.minutes,
    required this.price,
    required this.maxBookings,
    required this.gap,
});
}

class ServiceToBook{
  String title;
  int serviceIndex;
  String duration;
  String price;
  String type;
  bool serviceLinked;
  List<dynamic> membershipServices;
  List<dynamic> membershipDiscountedServices;

  ServiceToBook({
    required this.title,
    required this.serviceIndex,
    required this.duration,
    required this.price,
    required this.type,
    required this.serviceLinked,
    required this.membershipServices,
    required this.membershipDiscountedServices,
  });
}