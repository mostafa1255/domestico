import 'dart:convert';

class ProductModel {
  final String? id;
  final String? name;
  final String? slug;
  final String? category;
  final String? animalType;
  final String? createdBy;

  final double? price;
  final int? quantity;
  final String? description;
  final List<String>? productPictures;
  final List<dynamic>? reviews;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ProductModel({
    this.id,
    this.name,
    this.slug,
    this.category,
    this.animalType,
    this.createdBy,
    this.price,
    this.quantity,
    this.description,
    this.productPictures,
    this.reviews,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      category: json['category'] as String?,
      animalType: json['animalType'] as String?,
      createdBy: json['createdBy'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      description: json['description'] as String?,
      productPictures: (json['productPictures'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      reviews: json['reviews'] as List<dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'category': category,
      'animalType': animalType,
      'createdBy': createdBy,
      'price': price,
      'quantity': quantity,
      'description': description,
      'productPictures': productPictures,
      'reviews': reviews,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}
