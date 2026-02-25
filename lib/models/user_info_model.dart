class UserInfoModel {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? role;
  final String? email;
  final String? phone;
  final bool? isVerified;
  final bool? isActive;
  final bool? isAdmin;
  final String? avatar;
  final String? name;
  final String? gender;
  final int? balance;
  final bool? isStripeConnected;
  final String? subscriptionName;

  UserInfoModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.email,
    this.phone,
    this.isVerified,
    this.isActive,
    this.isAdmin,
    this.avatar,
    this.name,
    this.gender,
    this.balance,
    this.isStripeConnected,
    this.subscriptionName,
  });

  
  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      role: json['role'],
      email: json['email'],
      phone: json['phone'],
      isVerified: json['is_verified'],
      isActive: json['is_active'],
      isAdmin: json['is_admin'],
      avatar: json['avatar'],
      name: json['name'],
      gender: json['gender'],
      balance: json['balance'],
      isStripeConnected: json['is_stripe_connected'],
      subscriptionName: json['subscription_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "role": role,
      "email": email,
      "phone": phone,
      "is_verified": isVerified,
      "is_active": isActive,
      "is_admin": isAdmin,
      "avatar": avatar,
      "name": name,
      "gender": gender,
      "balance": balance,
      "is_stripe_connected": isStripeConnected,
      "subscription_name": subscriptionName,
    };
  }
}
