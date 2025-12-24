class ImageModel {
  final String imageUrl;
  final String largeImageUrl;

  ImageModel({
    required this.imageUrl,
    required this.largeImageUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    final jpg = json['jpg'] ?? {};
    return ImageModel(
      imageUrl: jpg['image_url'] ?? '',
      largeImageUrl: jpg['large_image_url'] ?? '',
    );
  }
}
