class SymptomsListModel {
  final String name;
  final String image;

  SymptomsListModel({required this.name, required this.image});

  factory SymptomsListModel.fromFirestore(Map<String, dynamic> data) {
    return SymptomsListModel(
      name: data['name'] ?? '',
      image: data['image_url'] ?? '',
    );
  }
}