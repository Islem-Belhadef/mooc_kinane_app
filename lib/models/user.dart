class UserModel {
  late int? id;
  late String? first_name;
  late String? last_name;
  late String? phone;
  late String? email;

  UserModel({
    this.id,
    this.first_name,
    this.last_name,
    this.phone,
    this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'phone': phone,
      'email': email,
    };
  }
}
