import 'package:km_app_test/domain/entities/user.dart';

class UserRequestModel {
  UserRequestModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<DataModel> data;

  factory UserRequestModel.fromJson(Map<String, dynamic> json) =>
      UserRequestModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<DataModel>.from(
            json["data"].map((x) => DataModel.fromJson(x))),
      );

  UserRequest toEntity() {
    return UserRequest(
        page: page,
        perPage: perPage,
        total: total,
        totalPages: totalPages,
        data: List<Data>.from(data.map((x) => x.toEntity())));
  }
}

class DataModel {
  DataModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };

  Data toEntity() {
    return Data(
        id: this.id,
        email: this.email,
        firstName: this.firstName,
        lastName: this.lastName,
        avatar: this.avatar);
  }
}
