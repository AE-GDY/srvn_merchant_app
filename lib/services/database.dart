import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class DatabaseService{

  final CollectionReference shops = FirebaseFirestore.instance.collection('shops');
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future addShop(String category,String currentShop, int currentShopIdx,int yearBound,
      int monthBound,
      int dayBound,
  ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {

        'members-amount': -1,
        'members':{

        },

        'user-amount': 0,
        'users':{
          '${0}':{
            'email': userName,
            'password': password,
          },
        },
        'packages-amount': -1,
        'packages': {

        },
        'memberships-amount': -1,
        'memberships': {},
        'products-amount': -1,
        'products': {},
        'blocked-hours': {},
        'blocked-hours-amount': 0,
        'contact-number': phoneNumber,
        'shop-name': currentShop,
        'shop-address': shopAddress,
        'shop-description': shopDescription,
        'business-hours': businessHours,
        'year-bound': yearBound,
        'month-bound': monthBound,
        'client-amount': -1,
        'clients': {},

        'day-bound': dayBound,
        'reviews-rating': 0,
        'reviews-amount': -1,
        'reviews': {

        },
        'appointment-stats': {
          'JAN': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'FEB': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'MAR': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'APR': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'MAY': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'JUN': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'JUL': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'AUG': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'SEP': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'OCT': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'NOV': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
          'DEC': {
            'appointment-amount': 0,
            'appointment-revenue': 0,
            'client-amount': 0,
            'clients': {

            },
          },
        },
        'appointments':{
          'appointment-amount': -1,
          'incomplete': 0,
          'complete': 0,
          'no-shows': 0,
          'cancelled': 0,
        },
      },
      'total-shop-amount' : currentShopIdx,
    },SetOptions(merge: true),
    );
  }

  Future updateAppointmentStats(String category,int currentShopIdx, String currentMonth,int appointmentAmount) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'appointment-stats': {
          currentMonth:{
            'appointment-amount': appointmentAmount,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }


  Future updateAppointmentRevenue(String category,int currentShopIdx, String currentMonth,num appointmentRevenue) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'appointment-stats': {
          currentMonth:{
            'appointment-revenue': appointmentRevenue,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }




  Future addAppointment(
      String status,
      String dayOfWeek,
      String category,
      int currentShopIdx,
      int appointmentAmount,
      int complete,
      int incomplete,
      int startYear,
      int startMonth,
      int startDay,
      int startHour,
      int startHourActual,
      int startMinutes,
      int endYear,
      int endMonth,
      int endDay,
      int endHour,
      int endHourActual,
      int endMinutes,
      String clientName,
      String serviceName,
      String servicePrice,
      String memberName,
      String memberRole,
      String appointmentType,
      String serviceDuration,
      String startTime,
      String endTime,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'appointments':{
          '$appointmentAmount':{
            'appointment-status': status,
            'appointment-type': appointmentType,

            'day-words': dayOfWeek,
            'start-year': startYear,
            'start-month': startMonth,
            'start-day': startDay,
            'start-hour': startHour,
            'start-hour-actual': startHourActual,
            'start-minutes': startMinutes,

            'end-year': endYear,
            'end-month': endMonth,
            'end-day': endDay,
            'end-hour': endHour,
            'end-hour-actual': endHourActual,
            'end-minutes': endMinutes,

            'client-name': clientName,
            'service-name': serviceName,
            'service-price': servicePrice,
            'service-duration': serviceDuration,
            'member-name': memberName,
            'member-role': memberRole,

            'start-time': startTime,
            'end-time': endTime,

          },
          'appointment-amount': appointmentAmount,
          'incomplete': incomplete,
          'complete': complete,
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future appointmentComplete(
      String category,
      int currentShopIdx,
      int appointmentIndex,
      int completeAmount,
      int incompleteAmount,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'appointments':{
          '$appointmentIndex':{
            'appointment-status': 'complete',

          },
          'complete': completeAmount,
          'incomplete': incompleteAmount,
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addMembership(
      String category,
      int currentShopIdx,
      int membershipIndex,
      String name,
      String price,
      List<String> selectedServices,
      List<String> selectedDiscountedServices,
      List<int> selectedDiscountedServicesPercentages,
      int duration,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'memberships':{
          '$membershipIndex':{
            'name': name,
            'price': price,
            'selected-services': selectedServices,
            'selected-services-amount': selectedServices.length,
            'selected-discounted-services': selectedDiscountedServices,
            'discounted-amount': selectedDiscountedServices.length,
            'selected-discounted-services-percentages': selectedDiscountedServicesPercentages,
            'duration': duration,

          },
        },
        'memberships-amount':membershipIndex,
      },
    },SetOptions(merge: true),
    );
  }

  Future addMember(
      String category,
      int currentShopIdx,
      int memberIndex,
      String membershipType,
      String memberName,
      String memberEmail,
      int day,
      int month,
      int year,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'members': {
          '$memberIndex': {
            'name': memberName,
            'email': memberEmail,
            'membership-type': membershipType,
            'start-day': day,
            'start-month': month,
            'start-year': year,
          },
        },
        'members-amount': memberIndex,
      },
    },SetOptions(merge: true),
    );
  }

  Future addUserMembership(
      int userIndex,
      int membershipIndex,
      String membershipName,
      String membershipShop,
      int day,
      int month,
      int year,
      ) async {
    return await users.doc("signed-up").set({
      '$userIndex' : {
        'membership-amount': membershipIndex,
        'memberships': {
          '$membershipIndex': {
            'membership-name': membershipName,
            'membership-shop': membershipShop,
            'start-day':day,
            'start-month': month,
            'start-year': year,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }



  Future appointmentNoShow(
      String category,
      int currentShopIdx,
      int appointmentIndex,
      int noShowAmount,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'appointments':{
          '$appointmentIndex':{
            'appointment-status': 'no-show',
          },
          'no-shows': noShowAmount,
        },
      },
    },SetOptions(merge: true),
    );
  }

  // Upload the image to firebase storage
  Future uploadImage(
      String category,
      int currentShopIdx,
      int total_image,
      Uint8List image,
      String downloadURL,
      ) async {

    return await shops.doc(category).set({
      '$currentShopIdx': {
        'images': {'$total_image': downloadURL},
        'total-images': total_image+1
      }
    }, SetOptions(merge: true)).whenComplete(() => const AlertDialog(
        title: Text(
          "Image Uploaded",
        )
    )

    );
  }

  Future sendAppointmentCompleteNotificationToUser(
      int userIndex,
      String currentShop,
      int notificationIndex,
      ) async {
    return await users.doc('signed-up').set({
      '$userIndex' : {
        'notification-amount': notificationIndex,
        'notifications':{
          '$notificationIndex':{
            'notification-type': "Appointment Complete",
            'notification': 'Appointment complete at $currentShop, please leave a review',
            'sender': currentShop,
            'viewed': false,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future updateUserAppointmentStatus(
      int userIndex,
      int appointmentIndex,
      ) async {
    return await users.doc('signed-up').set({
      '$userIndex' : {
        'appointments':{
          '$appointmentIndex': {
            'appointment-status':false,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }




  Future appointmentCancelled(
      String category,
      int currentShopIdx,
      int appointmentIndex,
      int completeAmount,
      int incompleteAmount,
      int cancelledAmount,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'appointments':{
          '$appointmentIndex':{
            'appointment-status': 'cancelled',

          },
          'complete': completeAmount,
          'incomplete': incompleteAmount,
          'cancelled': cancelledAmount,
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addClient(
      String category,
      int clientAmount,
      int currentShopIdx,
      String clientName,
      String clientEmail,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'client-amount': clientAmount,
        'clients': {
          '$clientAmount':{
            'type': 'new',
            'name': clientName,
            'email': clientEmail,
            'month': months[DateTime.now().month - 1],
            'amount-paid': 0,
            'appointments': 0,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }


  Future editClient(
      String category,
      int clientIndex,
      int currentShopIdx,
      String type,
      String clientName,
      String clientEmail,
      int clientAmount,
      String clientMonth,
      int amountPaid,
      int appointments,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'client-amount': clientAmount,
        'clients': {
          '$clientIndex':{
            'type': type,
            'name': clientName,
            'email': clientEmail,
            'month': months[DateTime.now().month - 1],
            'amount-paid': amountPaid,
            'appointments': appointments,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  //updateClientData
  Future updateClientData(
      String type,
      String category,
      int clientIndex,
      int currentShopIdx,
      int amountPaid,
      int appointmentAmount,
      int totalClientAmount,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'client-amount': totalClientAmount,
        'clients': {
          '$clientIndex':{
            'type': type,
            'amount-paid': amountPaid,
            'appointments': appointmentAmount,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future updateAmountPaid(
      String category,
      int clientIndex,
      int currentShopIdx,
      int amountPaid,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'clients': {
          '$clientIndex':{
            'amount-paid': amountPaid,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addPackage(
      String category,
      int currentShopIdx,
      int packageIndex,
      String packageName,
      List<String> packageServices,
      String packageHour,
      String packageMinute,
      String packagePrice,
      int minuteGap,
      int maxPerSlot,
      bool serviceLinked,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'packages-amount': packageIndex,
        'packages': {
          '$packageIndex':{
            'package-name': packageName,
            'package-services': packageServices,
            'package-hours': packageHour,
            'package-minutes': packageMinute,
            'package-price': packagePrice,
            'minute-gap': minuteGap,
            'max-amount-per-timing': maxPerSlot,
            'service-linked': serviceLinked,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future changeBusinessHours(
      String category,
      int currentShopIdx,
      String weekDay,
      String from,
      String to,
      bool dayOff,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'business-hours': {
          weekDay: {
            'from': from,
            'to': to,
            'day-off': dayOff,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addBlockedHours(
      String category,
      int currentShopIdx,
      int blockedHoursIndex,
      String day, int month, String year,
      String from, String to,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'blocked-hours-amount': blockedHoursIndex+1,
        'blocked-hours': {
          '$blockedHoursIndex': {
            'day': day,
            'month': monthsFull[month],
            'year': year,
            'from': from,
            'to': to,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addProduct(
      String category,
      int currentShopIdx,
      String productName,
      int productPrice,
      int stockAmount,
      int productAmount,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'products': {
          '$productAmount': {
            'product-name': productName,
            'product-price': productPrice,
            'product-stock': stockAmount,
          },
        },
        'products-amount': productAmount,
      },
    },SetOptions(merge: true),
    );
  }

  //updateProductData

  Future updateProductData(
      String category,
      int currentShopIdx,
      int stockAmount,
      int productIndex,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'products': {
          '$productIndex': {
            'product-stock': stockAmount,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }



  Future tempDelete(int idx) async {
    return await shops.doc("Barbershop").set({
      '0' : {
        'staff-members':{
          '1':{
            'member-availability-conditions': {
              'Sunday': {
                '$idx': FieldValue.delete(),
              },
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future deleteClients(String category, int shopIndex) async {
    return await shops.doc(category).set({
      '$shopIndex' : {
        'clients': FieldValue.delete(),
      },
    },SetOptions(merge: true),
    );
  }


  Future addServiceTimings(
      String category,
      int currentShopIdx,
      int serviceIndex,
      bool serviceLinked,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services':{
          '$serviceIndex':{
            'minute-gap': serviceLinked? serviceLinkedMinuteGaps[serviceIndex]: 0,
            'max-amount-per-timing': serviceLinked?amountPerTimingControllers[serviceIndex].text:"0",
            'service-linked':serviceLinked,
            'service-timings':serviceLinked?serviceLinkedBusinessHoursAvailability[serviceIndex]:{},
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addPackageTiming(
      String category,
      int currentShopIdx,
      int packageIndex,
      String weekDay,
      int timingIndex,
      String currentTime,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'packages':{
          '$packageIndex': {

            'package-timings':{
              weekDay:{
                '$timingIndex': currentTime,
              },
            },
          },
        }
      },
    },SetOptions(merge: true),
    );
  }


  Future addStaffMembers(
      String category,
      Map<String,String> services,
      int currentShopIdx,
      int staffIndex,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members-amount': staffMembers.length,
        'staff-members': {
          '$staffIndex': {
            'member-services': services,
            'member-services-amount': services.length,
            'member-packages': {},
            'member-packages-amount': 0,
            'member-name': staffMembers[staffIndex].name,
            'member-role': staffMembers[staffIndex].role,
            'member-timings': businessHours,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addStaffMemberPackage(
      String category,
      int currentShopIdx,
      int staffIndex,
      int packageIndex,
      String packageName,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-packages': {
              '$packageIndex':{
                'package-name': packageName,
              },
            },
            'member-packages-amount': packageIndex+1,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addStaffMemberLoggedIn(
      String category,
      Map<String,String> services,
      int currentShopIdx,
      int staffIndex,
      String name,
      String role,
      Map<String, Map<String,String>> memberTiming
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members-amount': staffIndex+1,
        'staff-members': {
          '$staffIndex': {
            'member-services': services,
            'member-services-amount': services.length,
            'member-name': name,
            'member-role': role,
            // 'member-services': staffMembers[staffIndex].services,
            'member-availability': memberTiming,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addServices(String category, int currentShopIdx, int serviceIndex, int gap, int maxAmount, bool serviceLinked) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services-amount': services.length,
        'services': {
          '$serviceIndex': {

            'flash-promotions-amount': 0,
            'last-minute-promotions-amount': 0,
            'happy-hour-promotions-amount': 0,

            'flash-promotions': {},
            'last-minute-promotions': {},
            'happy-hour-promotions': {},

            'service-name': services[serviceIndex].title,
            'service-hours': services[serviceIndex].hours,
            'service-minutes': services[serviceIndex].minutes,
            'service-price': services[serviceIndex].price,

            'minute-gap': gap,
            'max-amount-per-timing': maxAmount,
            'service-linked':serviceLinked,

          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addFlashPromotion(
      String category,
      int currentShopIdx,
      int serviceIndex,
      int promotionIndex,
      String promotionPeriod,
      String promotionDiscount,
      String promotionType,
      String startDay,
      String endDay,
      String startMonth,
      String endMonth,
      String startYear,
      String endYear,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services': {
          '$serviceIndex': {
            'flash-promotions-amount': promotionIndex+1,
            'flash-promotions':{
              '$promotionIndex':{
                'promotion-type': promotionType,
                'promotion-discount': promotionDiscount,
                'promotion-duration':promotionPeriod,
                'promotion-start-day': startDay,
                'promotion-end-day': endDay,
                'promotion-start-month': startMonth,
                'promotion-end-month': endMonth,
                'promotion-start-year': startYear,
                'promotion-end-year': endYear,
              },
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }



  Future editFlashPromotion(
      String category,
      int currentShopIdx,
      int serviceIndex,
      int promotionIndex,
      String promotionPeriod,
      String promotionDiscount,
      String promotionType,
      String startDay,
      String endDay,
      String startMonth,
      String endMonth,
      String startYear,
      String endYear,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services': {
          '$serviceIndex': {
            'flash-promotions':{
              '$promotionIndex':{
                'promotion-type': promotionType,
                'promotion-discount': promotionDiscount,
                'promotion-duration':promotionPeriod,
                'promotion-start-day': startDay,
                'promotion-end-day': endDay,
                'promotion-start-month': startMonth,
                'promotion-end-month': endMonth,
                'promotion-start-year': startYear,
                'promotion-end-year': endYear,
              },
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future deleteFlashPromotion(
      String category,
      int currentShopIdx,
      int serviceIndex,
      int promotionIndex,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services': {
          '$serviceIndex': {
            'flash-promotions-amount': promotionIndex,
            'flash-promotions':{
              '$promotionIndex':FieldValue.delete(),
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }


  Future addLastMinutePromotion(
      String category,
      int currentShopIdx,
      int serviceIndex,
      int promotionIndex,
      String promotionDiscount,
      String promotionType,
      String bookingWindow,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services': {
          '$serviceIndex': {
            'last-minute-promotions-amount': promotionIndex+1,
            'last-minute-promotions':{
              '$promotionIndex':{
                'promotion-type': promotionType,
                'promotion-discount': promotionDiscount,
                'booking-window': bookingWindow,
              },
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }


  Future editLastMinutePromotion(
      String category,
      int currentShopIdx,
      int serviceIndex,
      int promotionIndex,
      String promotionDiscount,
      String promotionType,
      String bookingWindow,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services': {
          '$serviceIndex': {
            'last-minute-promotions':{
              '$promotionIndex':{
                'promotion-type': promotionType,
                'promotion-discount': promotionDiscount,
                'booking-window': bookingWindow,
              },
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }


  Future editService(
      String category,
      int currentShopIdx,
      int serviceIndex,
      String serviceName,
      String serviceHours,
      String serviceMinutes,
      String servicePrice,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services': {
          '$serviceIndex': {
            'service-name': serviceName,
            'service-hours': serviceHours,
            'service-minutes': serviceMinutes,
            'service-price': servicePrice,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future editServiceWhenDeleting(
      String category,
      int currentShopIdx,
      int serviceIndex,
      String serviceName,
      String serviceHours,
      String serviceMinutes,
      String servicePrice,
      int maxAmountPerTiming,
      int minuteGap,
      bool serviceLinked,
      int flashPromotionAmount,
      int lastMinuteAmount,
      int happyHourAmount,
      dynamic flashPromotions,
      dynamic lastMinutePromotions,
      dynamic happyHourPromotions,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services': {
          '$serviceIndex': {
            'service-name': serviceName,
            'service-hours': serviceHours,
            'service-minutes': serviceMinutes,
            'service-price': servicePrice,

            'minute-gap': minuteGap,
            'max-amount-per-timing': maxAmountPerTiming,
            'flash-promotions-amount': flashPromotionAmount,
            'happy-hour-promotions-amount': happyHourAmount,
            'last-minute-promotions-amount': lastMinuteAmount,
            'flash-promotions': flashPromotions,
            'last-minute-promotions': lastMinutePromotions,
            'happy-hour-promotions': happyHourPromotions,

            'service-linked': serviceLinked,

          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future addNewService(
      String category,
      int currentShopIdx,
      int serviceIndex,
      String serviceName,
      String serviceHours,
      String serviceMinutes,
      String servicePrice,
      int minuteGap,
      int maxBookings,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services': {
          '$serviceIndex': {
            'service-name': serviceName,
            'service-hours': serviceHours,
            'service-minutes': serviceMinutes,
            'service-price': servicePrice,
            'service-linked': maxBookings > 1?true:false,
            'minute-gap':minuteGap,
            'max-amount-per-timing': maxBookings,

            'flash-promotions-amount': 0,
            'last-minute-promotions-amount': 0,
            'happy-hour-promotions-amount': 0,

            'flash-promotions': {},
            'last-minute-promotions': {},
            'happy-hour-promotions': {},


          },
        },
        'services-amount': serviceIndex+1,
      },
    },SetOptions(merge: true),
    );
  }

  Future editStaffMember(
      String category,
      int currentShopIdx,
      int staffIndex,
      String day,
      int currentIdx,
      String timing,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-availability': {
              day:{
                '$currentIdx': timing,
              },
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }


  Future editStaffMemberTimings(
      String category,
      int currentShopIdx,
      int staffIndex,
      String day,
      String startTime,
      String endTime,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-timings': {
              day:{
                'from': startTime,
                'to': endTime,
              },
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }


  Future editStaffMemberUserInfo(
      String category,
      int currentShopIdx,
      int staffIndex,
      String memberName,
      String memberRole,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-name': memberName,
            'member-role': memberRole,
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future editStaffMemberServiceInfo(
      String category,
      int currentShopIdx,
      int staffIndex,
      String service,
      int serviceIndex,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-services-amount': serviceIndex+1,
            'member-services':{
              '$serviceIndex': service,
              },
            },
          },
        },
      }, SetOptions(merge: true),
    );
  }

  Future deleteStaffMemberServiceInfo(
      String category,
      int currentShopIdx,
      int staffIndex,
      int serviceIndex,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-services-amount': serviceIndex,
            'member-services':{
              '$serviceIndex': FieldValue.delete(),
            },
          },
        },
      },
    }, SetOptions(merge: true),
    );
  }

  Future editStaffMemberServiceAmount(
      String category,
      int currentShopIdx,
      int staffIndex,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-services-amount': 0,
          },
        },
      },
    }, SetOptions(merge: true),
    );
  }

  Future editStaffMemberWhenDeleting(
      String category,
      int currentShopIdx,
      int staffIndex,
      String name,
      String role,
      int servicesAmount,
      dynamic timingData,
      dynamic services,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-name': name,
            'member-role': role,
            'member-services': services,
            'member-availability': timingData,
            'member-services-amount': servicesAmount,
          },
        },
      },
    }, SetOptions(merge: true),
    );
  }

  Future deleteStaffMember(
      String category,
      int currentShopIdx,
      int staffIndex,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members-amount': staffIndex,
        'staff-members': {
          '$staffIndex': FieldValue.delete(),
        },
      },
    }, SetOptions(merge: true),
    );
  }


  Future removeStaffMemberService(
      String category,
      int currentShopIdx,
      int staffIndex,
      int serviceIndex,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-services-amount': serviceIndex+1,
            'member-services':{
              '$serviceIndex': FieldValue.delete(),
            },
          },
        },
      },
    }, SetOptions(merge: true),
    );
  }

  Future deleteService(
      String category,
      int currentShopIdx,
      int serviceIndex,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'services-amount': serviceIndex,
        'services': {
          '$serviceIndex': FieldValue.delete(),
        },
      },
    }, SetOptions(merge: true),
    );
  }




  Future deleteTiming(
      String category,
      int currentShopIdx,
      int staffIndex,
      String day,
      int currentIdx,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-availability': {
              day:{
                '$currentIdx': FieldValue.delete(),
              },
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }


  //

  Future updateTimingConditions(
      String category,
      int currentShopIdx,
      int staffIndex,
      String day,
      int currentIdx,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-availability-conditions': {
              day:{
                '$currentIdx': true,
              },
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }

  //updateTimingAmount

  Future updateTimingAmount(
      String category,
      int currentShopIdx,
      int staffIndex,
      String day,
      int timingAmount,
      ) async {
    return await shops.doc(category).set({
      '$currentShopIdx' : {
        'staff-members': {
          '$staffIndex': {
            'member-availability': {
              day:{
                '${-1}': '$timingAmount',
              },
            },
          },
        },
      },
    },SetOptions(merge: true),
    );
  }




}