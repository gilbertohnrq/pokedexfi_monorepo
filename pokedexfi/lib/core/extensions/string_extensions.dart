extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String toSnakeCase() {
    return replaceAllMapped(RegExp('([A-Z])'), (match) => '_${match[0]}')
        .toLowerCase();
  }
}
