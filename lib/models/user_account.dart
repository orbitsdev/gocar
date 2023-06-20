import 'dart:convert';

class UserAccount {
String? uid;
String? email;
String? first_name;
String? last_name;
String? contact_number;
String? profile_image;
String? role;
String? created_at;
  UserAccount({
    this.uid,
    this.email,
    this.first_name,
    this.last_name,
    this.contact_number,
    this.profile_image,
    this.role,
    this.created_at,
  });
  

  UserAccount copyWith({
    String? uid,
    String? email,
    String? first_name,
    String? last_name,
    String? contact_number,
    String? profile_image,
    String? role,
    String? created_at,
  }) {
    return UserAccount(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      contact_number: contact_number ?? this.contact_number,
      profile_image: profile_image ?? this.profile_image,
      role: role ?? this.role,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'contact_number': contact_number,
      'profile_image': profile_image,
      'role': role,
      'created_at': created_at,
    };
  }

  factory UserAccount.fromMap(Map<String, dynamic> map) {
    return UserAccount(
      uid: map['uid'],
      email: map['email'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      contact_number: map['contact_number'],
      profile_image: map['profile_image'],
      role: map['role'],
      created_at: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAccount.fromJson(String source) => UserAccount.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserAccount(uid: $uid, email: $email, first_name: $first_name, last_name: $last_name, contact_number: $contact_number, profile_image: $profile_image, role: $role, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserAccount &&
      other.uid == uid &&
      other.email == email &&
      other.first_name == first_name &&
      other.last_name == last_name &&
      other.contact_number == contact_number &&
      other.profile_image == profile_image &&
      other.role == role &&
      other.created_at == created_at;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      first_name.hashCode ^
      last_name.hashCode ^
      contact_number.hashCode ^
      profile_image.hashCode ^
      role.hashCode ^
      created_at.hashCode;
  }
}
