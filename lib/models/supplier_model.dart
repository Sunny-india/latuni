class SupplierModel {
  String? sid, password, address;
  String storeName, email, phone, city, storeLogo;
  //
  SupplierModel(
      {this.sid,
      this.password,
      this.address,
      required this.storeName,
      required this.email,
      required this.phone,
      required this.city,
      required this.storeLogo});
  //
  factory SupplierModel.fromFirebase(Map<String, dynamic> json) {
    return SupplierModel(
        sid: json['sid'],
        storeName: json['storeName'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        city: json['city'],
        storeLogo: json['storeLogo']);
  }

  Map<String, dynamic> toFirebase() {
    return {
      'sid': sid,
      'storeName': storeName,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'storeLogo': storeLogo,
    };
  }
}
