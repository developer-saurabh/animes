class PaginationModel {
  final int currentPage;
  final bool hasNextPage;

  PaginationModel({
    required this.currentPage,
    required this.hasNextPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] ?? 1,
      hasNextPage: json['has_next_page'] ?? false,
    );
  }
}
