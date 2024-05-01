class Blog {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime updatedAt;
  final List<String> topics;

  Blog({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.updatedAt,
    required this.topics,
  });
}
