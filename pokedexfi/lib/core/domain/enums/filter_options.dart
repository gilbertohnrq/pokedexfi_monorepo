enum FilterOptions {
  byName('Number', 0),
  byNumber('Name', 1);

  const FilterOptions(this.text, this.value);

  final String text;
  final int value;
}
