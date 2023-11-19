class CustomerModel {
  String? cid, password, address;
  String name, email, phone, city;
  CustomerModel(
      {this.cid,
      this.password,
      this.address,
      required this.name,
      required this.email,
      required this.phone,
      required this.city});

  factory CustomerModel.fromFirebase(Map<String, dynamic> json) {
    return CustomerModel(
        cid: json['cid'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        city: json['city'],
        address: json['address']);
  }

  Map<String, dynamic> toFirebase() {
    return {
      'cid': cid,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
    };
  }
}
