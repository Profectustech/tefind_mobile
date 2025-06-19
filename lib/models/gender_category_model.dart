class CategoryByGender {
  final String id;
  final String name;

  CategoryByGender({
    required this.id,
    required this.name,
  });

  factory CategoryByGender.fromJson(Map<String, dynamic> json) {
    return CategoryByGender(
      id: json['id'] ?? json['_id'], // fallback in case 'id' is missing
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}
