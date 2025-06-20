class ProductDetailModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final Category category;
  final Category subCategory;
  final String size;
  final Seller seller;
  final Condition condition;
  final String color;
  final CreatedBy createdBy;
  final List<String> images;
  final int stock;
  final bool isActive;
  final bool isApproved;
  final int rating;
  final int totalReviews;
  final Map<String, dynamic> specifications;
  final List<dynamic> tags;
  final LastUpdatedBy lastUpdatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.subCategory,
    required this.size,
    required this.seller,
    required this.condition,
    required this.color,
    required this.createdBy,
    required this.images,
    required this.stock,
    required this.isActive,
    required this.isApproved,
    required this.rating,
    required this.totalReviews,
    required this.specifications,
    required this.tags,
    required this.lastUpdatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      category: Category.fromJson(json['category']),
      subCategory: Category.fromJson(json['subCategory']),
      size: json['size'],
      seller: Seller.fromJson(json['seller']),
      condition: Condition.fromJson(json['condition']),
      color: json['color'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
      images: List<String>.from(json['images']),
      stock: json['stock'],
      isActive: json['isActive'],
      isApproved: json['isApproved'],
      rating: json['rating'],
      totalReviews: json['totalReviews'],
      specifications: Map<String, dynamic>.from(json['specifications']),
      tags: List<dynamic>.from(json['tags']),
      lastUpdatedBy: LastUpdatedBy.fromJson(json['lastUpdatedBy']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class Seller {
  final String id;
  final String email;
  final String role;
  final String bio;
  final String address;
  final String city;
  final String state;
  final bool isVerified;
  final String image;
  final bool hasStore;
  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String username;
  final DateTime createdAt;
  final DateTime updatedAt;

  Seller({
    required this.id,
    required this.email,
    required this.role,
    required this.bio,
    required this.address,
    required this.city,
    required this.state,
    required this.isVerified,
    required this.image,
    required this.hasStore,
    required this.firstname,
    required this.lastname,
    required this.phoneNumber,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['_id'],
      email: json['email'],
      role: json['role'],
      bio: json['bio'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      isVerified: json['isVerified'],
      image: json['image'],
      hasStore: json['hasStore'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phoneNumber: json['phoneNumber'],
      username: json['username'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Condition {
  final String id;
  final String name;
  final String description;

  Condition({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class CreatedBy {
  final String id;
  final String firstname;
  final String lastname;

  CreatedBy({
    required this.id,
    required this.firstname,
    required this.lastname,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }
}

class LastUpdatedBy {
  final String? id;
  final String firstname;
  final String lastname;

  LastUpdatedBy({
    required this.firstname,
    required this.lastname,
    required this.id,
  });

  factory LastUpdatedBy.fromJson(Map<String, dynamic> json) {
    return LastUpdatedBy(
      firstname: json['firstname'],
      lastname: json['lastname'],
      id: json['id'],
    );
  }
}
