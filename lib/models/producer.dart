// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Producer {
  String id;
  String name;
  String email;
  bool visible_producer;
  String short_description;
  String? address;
  String? contact;
  String? opening_hours;
  List<String>? tags;
  double? lat;
  double? lng;
  Producer({
    required this.id,
    required this.name,
    required this.email,
    required this.visible_producer,
    required this.short_description,
    this.address,
    this.contact,
    this.opening_hours,
    this.tags,
    this.lat,
    this.lng,
  });

  Producer copyWith({
    String? id,
    String? name,
    String? email,
    bool? visible_producer,
    String? short_description,
    String? address,
    String? contact,
    String? opening_hours,
    List<String>? tags,
    double? lat,
    double? lng,
  }) {
    return Producer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      visible_producer: visible_producer ?? this.visible_producer,
      short_description: short_description ?? this.short_description,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      opening_hours: opening_hours ?? this.opening_hours,
      tags: tags ?? this.tags,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'visible_producer': visible_producer,
      'short_description': short_description,
      'address': address,
      'contact': contact,
      'opening_hours': opening_hours,
      'tags': tags,
      'lat': lat,
      'lng': lng,
    };
  }

  factory Producer.fromMap(Map<String, dynamic> map) {
    return Producer(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      visible_producer: map['visible_producer'] as bool,
      short_description: map['short_description'] as String,
      address: map['address'] != null ? map['address'] as String : null,
      contact: map['contact'] != null ? map['contact'] as String : null,
      opening_hours: map['opening_hours'] != null ? map['opening_hours'] as String : null,
      tags: map['tags'] != null ? List<String>.from((map['tags'] )) : null,
      lat: map['lat'] != null ? map['lat'] as double : null,
      lng: map['lng'] != null ? map['lng'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Producer.fromJson(String source) =>
      Producer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Producer(id: $id, name: $name, email: $email, visible_producer: $visible_producer, short_description: $short_description, address: $address, contact: $contact, opening_hours: $opening_hours, tags: $tags, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(covariant Producer other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.visible_producer == visible_producer &&
      other.short_description == short_description &&
      other.address == address &&
      other.contact == contact &&
      other.opening_hours == opening_hours &&
      listEquals(other.tags, tags) &&
      other.lat == lat &&
      other.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      visible_producer.hashCode ^
      short_description.hashCode ^
      address.hashCode ^
      contact.hashCode ^
      opening_hours.hashCode ^
      tags.hashCode ^
      lat.hashCode ^
      lng.hashCode;
  }
}
