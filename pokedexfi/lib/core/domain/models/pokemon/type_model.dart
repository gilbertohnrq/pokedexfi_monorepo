class Type {
  final String? name;

  const Type({
    this.name,
  });

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      name: map['name'] as String? ?? '',
    );
  }
}
