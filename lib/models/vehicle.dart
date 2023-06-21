import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Vehicle {
  String? id;
  String? uid;
  String? model_name;
  String? plate_number;
  String? cover_image;
  List<String>? featured_image;
  String? description;
  bool? isSold;
  String? status;
  int? price;
  DateTime? created_at;
  
  Vehicle({
    this.id,
    this.uid,
    this.model_name,
    this.plate_number,
    this.cover_image,
    this.featured_image,
    this.description,
    this.isSold,
    this.status,
    this.price,
    this.created_at,
  });



  Vehicle copyWith({
    String? id,
    String? uid,
    String? model_name,
    String? plate_number,
    String? cover_image,
    List<String>? featured_image,
    String? description,
    bool? isSold,
    String? status,
    int? price,
    DateTime? created_at,
  }) {
    return Vehicle(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      model_name: model_name ?? this.model_name,
      plate_number: plate_number ?? this.plate_number,
      cover_image: cover_image ?? this.cover_image,
      featured_image: featured_image ?? this.featured_image,
      description: description ?? this.description,
      isSold: isSold ?? this.isSold,
      status: status ?? this.status,
      price: price ?? this.price,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'model_name': model_name,
      'plate_number': plate_number,
      'cover_image': cover_image,
      'featured_image': featured_image,
      'description': description,
      'isSold': isSold,
      'status': status,
      'price': price,
      'created_at': created_at?.millisecondsSinceEpoch,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      uid: map['uid'],
      model_name: map['model_name'],
      plate_number: map['plate_number'],
      cover_image: map['cover_image'],
      featured_image: List<String>.from(map['featured_image']),
      description: map['description'],
      isSold: map['isSold'],
      status: map['status'],
      price: map['price']?.toInt(),
      created_at: map['created_at'] != null ? DateTime.fromMillisecondsSinceEpoch(map['created_at']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) => Vehicle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vehicle(id: $id, uid: $uid, model_name: $model_name, plate_number: $plate_number, cover_image: $cover_image, featured_image: $featured_image, description: $description, isSold: $isSold, status: $status, price: $price, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Vehicle &&
      other.id == id &&
      other.uid == uid &&
      other.model_name == model_name &&
      other.plate_number == plate_number &&
      other.cover_image == cover_image &&
      listEquals(other.featured_image, featured_image) &&
      other.description == description &&
      other.isSold == isSold &&
      other.status == status &&
      other.price == price &&
      other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      uid.hashCode ^
      model_name.hashCode ^
      plate_number.hashCode ^
      cover_image.hashCode ^
      featured_image.hashCode ^
      description.hashCode ^
      isSold.hashCode ^
      status.hashCode ^
      price.hashCode ^
      created_at.hashCode;
  }
}
