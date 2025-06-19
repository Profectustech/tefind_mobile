class CategoryGender {
  final String id;
  final String name;
  final List<Category> categories;

  CategoryGender({
    required this.id,
    required this.name,
    required this.categories,
  });

  factory CategoryGender.fromJson(Map<String, dynamic> json) {
    return CategoryGender(
      id: json["_id"],
      name: json["name"],
      categories: (json["categories"] as List)
          .map((e) => Category.fromJson(e))
          .toList(),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String description;
  final String icon;
  final List<SubCategory> subcategories;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.subcategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"],
      name: json["name"],
      description: json["description"] ?? '',
      icon: json["icon"] ?? '',
      subcategories: (json["subcategories"] as List)
          .map((e) => SubCategory.fromJson(e))
          .toList(),
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String description;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json["_id"],
      name: json["name"],
      description: json["description"] ?? '',
    );
  }
}
