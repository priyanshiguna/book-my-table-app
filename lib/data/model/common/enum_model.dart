import 'package:flutter/material.dart';

class DropdownEnumData {
  final int id;
  final String Function() label;
  final String slug;
  final String selectedImage;
  final String unselectImage;

  const DropdownEnumData({
    required this.id,
    required this.label,
    required this.slug,
    required this.selectedImage,
    required this.unselectImage,
  });
}

class IPOHistoryStatusData {
  final int id;
  final String Function() label;
  final String slug;
  final IconData icon;

  const IPOHistoryStatusData({
    required this.id,
    required this.label,
    required this.slug,
    required this.icon,
  });
}
