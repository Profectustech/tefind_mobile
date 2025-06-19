class Products {
  final String id;
  final String name;
  final String description;
  final int price;
  final String category;
  final String subCategory;
  final String size;
  final String seller;
  final String condition;
  final String color;
  final String createdBy;
  final List<String> images;
  final int stock;
  final bool isActive;
  final bool isApproved;
  final int rating;
  final int totalReviews;
  final Map<String, dynamic> specifications;
  final List<dynamic> tags;
  final String lastUpdatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Products({
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

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      subCategory: json['subCategory'],
      size: json['size'],
      seller: json['seller'],
      condition: json['condition'],
      color: json['color'],
      createdBy: json['createdBy'],
      images: List<String>.from(json['images']),
      stock: json['stock'],
      isActive: json['isActive'],
      isApproved: json['isApproved'],
      rating: json['rating'],
      totalReviews: json['totalReviews'],
      specifications: Map<String, dynamic>.from(json['specifications']),
      tags: List<dynamic>.from(json['tags']),
      lastUpdatedBy: json['lastUpdatedBy'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
