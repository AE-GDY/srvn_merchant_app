
import 'package:servnn_client_side/models/staff_member.dart';

class Shop{
  String name;
  int employeeAmount;
  List<StaffMember> staffMembers;
  Map<String,String> businessHours;

  Shop({required this.name, required this.employeeAmount, required this.staffMembers, required this.businessHours});

}