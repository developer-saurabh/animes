class StudioModel {
  final int malId;
  final String name;

  StudioModel({
    required this.malId,
    required this.name,
  });

  factory StudioModel.fromJson(Map<String, dynamic> json) {
    return StudioModel(
      malId: json['mal_id'],
      name: json['name'],
    );
  }
}
