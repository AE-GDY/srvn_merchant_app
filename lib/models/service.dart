import 'package:flutter/material.dart';


class Service{
  String title;
  String hours;
  String minutes;
  String price;
  int maxBookings;
  int gap;
  bool credit;
  bool cash;
  bool both;
  bool membersOnly;
  bool requiresConfirmation;

  Service({
    required this.title,
    required this.hours,
    required this.minutes,
    required this.price,
    required this.maxBookings,
    required this.gap,
    required this.credit,
    required this.cash,
    required this.both,
    required this.membersOnly,
    required this.requiresConfirmation,
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