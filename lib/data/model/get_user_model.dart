//TODO: USER MODEL MUST BE CHANGE BASED ON NEW RESPONSE

import 'dart:convert';

GetUserModel getUserModelFromJson(String str) => GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  final bool? success;
  final String? message;
  final UserModelData? data;

  GetUserModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : UserModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserModelData {
  final UserModel? userModel;
  final Tokens? tokens;

  UserModelData({
    this.userModel,
    this.tokens,
  });

  factory UserModelData.fromJson(Map<String, dynamic> json) => UserModelData(
        userModel: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": userModel?.toJson(),
        "tokens": tokens?.toJson(),
      };
}

class Tokens {
  final Access? access;
  final Access? refresh;

  Tokens({
    this.access,
    this.refresh,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: json["access"] == null ? null : Access.fromJson(json["access"]),
        refresh: json["refresh"] == null ? null : Access.fromJson(json["refresh"]),
      );

  Map<String, dynamic> toJson() => {
        "access": access?.toJson(),
        "refresh": refresh?.toJson(),
      };
}

class Access {
  final String? token;
  final DateTime? expires;

  Access({
    this.token,
    this.expires,
  });

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        token: json["token"],
        expires: json["expires"] == null ? null : DateTime.parse(json["expires"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expires": expires?.toIso8601String(),
      };
}

class UserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final RoleModel? role;
  final List<dynamic>? friend;
  final DateTime? dateOfBirth;
  final int? coins;
  final String? image;
  final String? coverImage;
  final dynamic height;
  final dynamic weight;
  final bool? isEmailVerified;
  final bool? isCompleted;
  final String? socialId;
  final String? socialType;
  final bool? isBlock;
  final bool? isActive;
  final bool? recover;
  final DateTime? deletedAt;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.friend,
    this.dateOfBirth,
    this.coins,
    this.image,
    this.coverImage,
    this.height,
    this.weight,
    this.isEmailVerified,
    this.isCompleted,
    this.socialId,
    this.socialType,
    this.isBlock,
    this.isActive,
    this.recover,
    this.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        role: json["role"] == null ? null : RoleModel.fromJson(json["role"]),
        friend: json["friend"] == null ? [] : List<dynamic>.from(json["friend"]!.map((x) => x)),
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        coins: json["coins"],
        image: json["image"],
        coverImage: json["cover_image"],
        height: json["height"],
        weight: json["weight"],
        isEmailVerified: json["is_email_verified"],
        isCompleted: json["is_completed"],
        socialId: json["social_id"],
        socialType: json["social_type"],
        isBlock: json["is_block"],
        isActive: json["is_active"],
        recover: json["recover"],
        deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "role": role,
        "friend": friend == null ? [] : List<dynamic>.from(friend!.map((x) => x)),
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "coins": coins,
        "image": image,
        "cover_image": coverImage,
        "height": height,
        "weight": weight,
        "is_email_verified": isEmailVerified,
        "is_completed": isCompleted,
        "social_id": socialId,
        "social_type": socialType,
        "is_block": isBlock,
        "is_active": isActive,
        "recover": recover,
        "deleted_at": deletedAt?.toIso8601String(),
      };
}

class RoleModel {
  final String? id;
  final String? role;
  final String? slug;
  final bool? isActive;
  final DateTime? deletedAt;

  RoleModel({
    this.id,
    this.role,
    this.slug,
    this.isActive,
    this.deletedAt,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json["_id"],
        role: json["role"],
        slug: json["slug"],
        isActive: json["is_active"],
        deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "role": role,
        "slug": slug,
        "is_active": isActive,
        "deleted_at": deletedAt?.toIso8601String(),
      };
}
