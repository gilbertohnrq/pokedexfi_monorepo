class Common {
  final String name;
  final String url;

  const Common({required this.name, required this.url});

  factory Common.fromMap(Map<String, dynamic> map) {
    return Common(
      name: map['name'] as String? ?? '',
      url: map['url'] as String? ?? '',
    );
  }
}
