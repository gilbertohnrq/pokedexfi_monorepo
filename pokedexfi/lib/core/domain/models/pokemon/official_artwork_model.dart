class OfficialArtwork {
  final String? frontDefault;

  const OfficialArtwork({
    this.frontDefault = '',
  });

  factory OfficialArtwork.empty() {
    return const OfficialArtwork();
  }

  factory OfficialArtwork.fromMap(Map<String, dynamic> map) {
    return OfficialArtwork(
      frontDefault: map['front_default'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'front_default': frontDefault,
    };
  }
}
