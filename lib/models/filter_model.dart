class Category {
  final String name;
  final List<SubCategory> subCategories;

  Category({required this.name, this.subCategories = const []});
}

class SubCategory {
  final String name;
  final int count;
  bool isChecked;

  SubCategory({required this.name, required this.count, this.isChecked = false});
}

final categories = [
  Category(
    name: "Food & Drinks",
    subCategories: [
      SubCategory(name: "Animal Protein", count: 200),
      SubCategory(name: "Fresh Vegetables", count: 200),
      SubCategory(name: "Fresh Fruits", count: 190),
      SubCategory(name: "Local Condiments", count: 300),
      SubCategory(name: "Dry Foods", count: 300),
      SubCategory(name: "Restaurants", count: 1000),
      SubCategory(name: "Soft Drinks", count: 200),
      SubCategory(name: "Alcohol", count: 0),
      SubCategory(name: "Water", count: 0),
      SubCategory(name: "Sweets", count: 0),
      SubCategory(name: "Others", count: 0),
    ],
  ),
  Category(name: "Fashion"),
  Category(name: "Personal Care"),
  Category(name: "Electronics"),
  Category(name: "Household Items"),
  Category(name: "Beauty & Hair"),
  Category(name: "Toys & Games"),
  Category(name: "Perfumes & Fragrances"),
];