

class AppointmentStats{
    final double month;
    final double appointmentAmount;
    final double revenue;


    AppointmentStats({required this.month, required this.appointmentAmount, required this.revenue});
}

class AppointmentStatusStats{
    final String status;
    final int quantity;
    final String percent;
    final String value;

    AppointmentStatusStats({required this.status,required this.quantity, required this.percent, required this.value});
}

class AppointmentRevenueStats{
    final String type;
    final int quantity;
    final String percent;
    final String value;

    AppointmentRevenueStats({required this.type,required this.quantity, required this.percent, required this.value});
}

class ClientStats{
    final String month;
    final int quantity;
    final int returningClients;
    final int newClients;


    ClientStats({required this.month, required this.quantity, required this.returningClients, required this.newClients});

}

class ClientData{
    final String clientName;
    final int appointmentAmount;
    final int amountPaid;


    ClientData({required this.clientName, required this.appointmentAmount, required this.amountPaid});

}


class ProductData{
    final String productName;
    final int productRevenue;
    final int productAmount;
    final int amountPurchased;
    final int clientAmount;

    ProductData({required this.productName,
        required this.productRevenue,
        required this.productAmount,
        required this.amountPurchased,
        required this.clientAmount,
    });
}

class ClientTypeData{
    final String itemType;
    final int percentage;
    final int clientAmount;

    ClientTypeData({required this.itemType, required this.percentage, required this.clientAmount});
}



class StaffMemberStats{
    final String staffName;
    final int appointmentAmount;
    final int revenue;
    final int revenueFromServices;
    final int revenueFromProducts;
    final int revenueFromGiftCards;
    final int revenueFromPackages;
    final int revenueFromMemberShips;
    final int totalClients;
    final int newPercentage;
    final String totalDuration;
    final int returningPercentage;
    final int netRevenue;
    final int tax;


    StaffMemberStats({
        required this.staffName,
        required this.appointmentAmount,
        required this.revenue,
        required this.revenueFromServices,
        required this.revenueFromProducts,
        required this.revenueFromGiftCards,
        required this.revenueFromMemberShips,
        required this.revenueFromPackages,
        required this.netRevenue,
        required this.returningPercentage,
        required this.tax,
        required this.totalDuration,
        required this.newPercentage,
        required this.totalClients
    });


}

