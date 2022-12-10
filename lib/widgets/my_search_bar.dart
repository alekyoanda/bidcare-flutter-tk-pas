import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:input_history_text_field/input_history_text_field.dart';

typedef VoidCallbackParamString = void Function(String);

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    Key? key,
    this.hintText,
    required this.historyKey,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
  }) : super(key: key);
  final String historyKey;
  final String? hintText;
  final VoidCallbackParamString? onSubmitted;
  final VoidCallbackParamString? onChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InputHistoryTextField(
        onTap: onTap,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          filled: true,
          suffixIcon: const Icon(Icons.search),
          hintText: (hintText != null) ? hintText : "Search..",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        historyKey: historyKey,
      ),
    );
  }
}
