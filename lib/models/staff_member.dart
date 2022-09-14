

import 'package:servnn_client_side/models/service.dart';

class StaffMember{
  String name;
  String role;
  List<Service> services;
  Map<String, Map<String, String>> availability;


  StaffMember({required this.name,
    required this.role,
    required this.services,
    required this.availability,
  });
}