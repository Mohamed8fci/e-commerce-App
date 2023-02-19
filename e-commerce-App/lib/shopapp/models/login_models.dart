class ShopLoginModel {
  late bool status;
  late String message;
  late UserData data;

  ShopLoginModel({required this.status, required this.message, required this.data});

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    message = json['message'] ?? '';
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data.toJson();
    return data;
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  UserData(
      {required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required  this.image,
        required  this.points,
        required this.credit,
        required this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    image = json['image'] ?? '';
    points = json['points'] ?? '';
    credit = json['credit'] ?? '';
    token = json['token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['points'] = points;
    data['credit'] = credit;
    data['token'] = token;
    return data;
  }
}