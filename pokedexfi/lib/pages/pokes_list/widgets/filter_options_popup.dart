import 'package:flutter/material.dart';
import 'package:pokedexfi/core/domain/enums/filter_options.dart';

class FilterOptionsPopup extends StatefulWidget {
  const FilterOptionsPopup({
    Key? key,
    required this.onOptionSelected,
  }) : super(key: key);

  final Function(FilterOptions) onOptionSelected;

  @override
  State<FilterOptionsPopup> createState() => _FilterOptionsPopupState();
}

class _FilterOptionsPopupState extends State<FilterOptionsPopup> {
  FilterOptions _groupValue = FilterOptions.byNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: FilterOptions.values.map((option) {
        return RadioListTile<FilterOptions>(
          title: Text(option.toString()),
          value: option,
          groupValue: _groupValue,
          onChanged: (FilterOptions? value) {
            setState(() {
              _groupValue = value!;
              widget.onOptionSelected(value);
            });
          },
        );
      }).toList(),
    );
  }
}
