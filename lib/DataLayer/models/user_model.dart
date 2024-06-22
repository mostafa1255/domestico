class UserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? hashPassword;
  final String? role;
  final String? userType;
  final String? contactNumber;
  final String? profilePicture;
  final String? address;
  final String? city;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<Animal>? animals;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.hashPassword,
    required this.role,
    required this.userType,
    required this.contactNumber,
    required this.profilePicture,
    required this.address,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.animals,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var animalsList = json['animals'] as List<dynamic>?;
    List<Animal>? animals = animalsList != null
        ? animalsList.map((animalJson) => Animal.fromJson(animalJson)).toList()
        : null;

    return UserModel(
      id: json['_id'] as String?,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      username: json['username'] as String,
      email: json['email'] as String,
      hashPassword: json['hashPassword'] as String,
      role: json['role'] as String,
      userType: json['userType'] as String,
      contactNumber: json['contactNumber'] as String? ?? '',
      profilePicture: json['profilePicture'] as String? ?? '',
      address: json['address'] as String,
      city: json['city'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      v: json['__v'] as int?,
      animals: animals,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'hashPassword': hashPassword,
      'role': role,
      'userType': userType,
      'contactNumber': contactNumber,
      'profilePicture': profilePicture,
      'address': address,
      'city': city,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
      'animals': animals?.map((animal) => animal.toJson()).toList(),
    };
  }
}

class Animal {
  final String? animalType;
  final String? animalName;
  final List<String>? animalPicturesUrl;
  final String? age;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Animal({
    required this.animalType,
    required this.animalName,
    required this.animalPicturesUrl,
    required this.age,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    var picturesList = json['animalPicturesUrl'] as List<dynamic>?;
    List<String>? animalPicturesUrl = picturesList != null
        ? picturesList.map((picture) => picture as String).toList()
        : null;

    return Animal(
      animalType: json['animalType'] as String?,
      animalName: json['animalName'] as String?,
      animalPicturesUrl: animalPicturesUrl,
      age: json['age'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'animalType': animalType,
      'animalName': animalName,
      'animalPicturesUrl': animalPicturesUrl,
      'age': age,
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
