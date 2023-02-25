import 'dart:convert';

class UserModel {
  String id;
  String fullName;
  String phoneNumber;
  String? userProfile;
  String? address;
  UserModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.userProfile,
    this.address,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? userProfile,
    String? address,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userProfile: userProfile ?? this.userProfile,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'fullName': fullName});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'userProfile': userProfile});
    result.addAll({'address': address});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      userProfile: map['userProfile'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, userProfile: $userProfile, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.userProfile == userProfile &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        phoneNumber.hashCode ^
        userProfile.hashCode ^
        address.hashCode;
  }
}
