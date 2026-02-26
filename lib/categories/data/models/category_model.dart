class CategoryModel {
  String id;
  String name;
  String imageName;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageName,
  });

  static List<CategoryModel> categories = [
    CategoryModel(id: 'general', name: 'General', imageName: 'general'),
    CategoryModel(id: 'business', name: 'Business', imageName: 'business'),
    CategoryModel(id: 'general', name: 'General', imageName: 'general'),
    CategoryModel(id: 'business', name: 'Business', imageName: 'business'),
    CategoryModel(id: 'general', name: 'General', imageName: 'general'),
    CategoryModel(id: 'business', name: 'Business', imageName: 'business'),
    CategoryModel(id: 'general', name: 'General', imageName: 'general'),
    CategoryModel(id: 'business', name: 'Business', imageName: 'business'),
    CategoryModel(id: 'general', name: 'General', imageName: 'general'),
    CategoryModel(id: 'business', name: 'Business', imageName: 'business'),
  ];
}
