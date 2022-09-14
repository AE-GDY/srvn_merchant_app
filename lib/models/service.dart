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
  String duration;
  String price;
  String type;
  bool serviceLinked;

  ServiceToBook({
    required this.title,
    required this.duration,
    required this.price,
    required this.type,
    required this.serviceLinked,
  });
}