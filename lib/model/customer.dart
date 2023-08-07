class Customers {
  var customerId;
  var customerName;
  var email;
  var telNum;
  var address;
  var isActive;
  var status;
  Customers({
    this.customerId,
    this.customerName,
    this.email,
    this.telNum,
    this.address,
    this.isActive,
    this.status,
  });
  factory Customers.fromJson(Map<String, dynamic> json) {
    return Customers(
      customerId: json['customer_id'] ?? '',
      customerName: json['customer_name'] ?? '',
      email: json['email'] ?? '',
      telNum: json['tel_num'] ?? '',
      address: json['address'] ?? '',
      isActive: json['is_active'] ?? '',
    );
  }
}
