import 'dart:math';

// Extension that adds random picking utilities for List<T>.
extension RandomPick<T> on List<T> {
  /// Returns a random index from the list.
  ///
  /// Returns `null` if the list is empty.
  int? get randomIndex {
    if (isEmpty) return null;
    return Random().nextInt(length);
  }

  /// Returns a random element from the list.
  ///
  /// Returns `null` if the list is empty.
  T? get randomElement {
    if (isEmpty) return null;
    return this[Random().nextInt(length)];
  }

  /// Returns [count] random unique elements from the list.
  ///
  /// - If [count] is `<= 0`, returns an empty list.
  /// - If [count] is greater than or equal to [length],
  ///   returns the entire list shuffled.
  List<T> pickMany(int count) {
    if (isEmpty) return [];
    if (count <= 0) return [];
    if (count >= length) return List<T>.from(this);

    final copy = List<T>.from(this)..shuffle();
    return copy.take(count).toList();
  }
}

// Extension with general safe and utility methods for List<T>.
extension ListHelpers<T> on List<T> {
  /// Returns `true` if the list is empty.
  bool get isNullOrEmpty => isEmpty;

  /// Returns the first element, or `null` if the list is empty.
  T? get firstOrNull => isEmpty ? null : first;

  /// Returns the last element, or `null` if the list is empty.
  T? get lastOrNull => isEmpty ? null : last;

  /// Adds [element] to the list only if it does not already exist.
  void addIfNotExists(T element) {
    if (!contains(element)) add(element);
  }

  /// Returns a new list with duplicate elements removed.
  List<T> get unique => isEmpty ? [] : toSet().toList();

  /// Remove null elements from the list.
  List<T> get removeNulls => isEmpty ? [] : where((element) => element != null).toList();

  /// Splits the list into chunks of size [size].
  ///
  /// If [size] <= 0, returns a single chunk containing the full list.
  List<List<T>> chunked(int size) {
    if (isEmpty) return [];
    if (size <= 0) return [this];
    final List<List<T>> chunks = [];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// Returns a reversed copy of the list.
  List<T> get reversedCopy => isEmpty ? [] : List<T>.from(reversed);
}

extension PetNameDisplay on List<String?>? {
  // Local helper (clone of your isValEmpty)
  bool _isValEmptyLocal(dynamic val) {
    final String value = val?.toString() ?? "";
    return (val == null || value.isEmpty || value == "null" || value == "" || value == "NULL");
  }

  /// Returns a display string for pet names.
  ///
  /// - 1 pet   → "Max"
  /// - 2 pets  → "Max & Sam"
  /// - 3+ pets → customWord (default: "Pets")
  ///
  /// Ignores invalid values: null, "", "null", "NULL".
  String displayPetNames({String customWord = "Pets"}) {
    final List<String?> items = this ?? [];

    final List<String> filtered = <String>[];
    for (final String? e in items) {
      if (_isValEmptyLocal(e)) continue; // skip invalid
      final String s = e!.trim();
      if (s.isNotEmpty) filtered.add(s);
    }

    if (filtered.isEmpty) return customWord;
    if (filtered.length == 1) return filtered.first;
    if (filtered.length == 2) return "${filtered[0]} & ${filtered[1]}";
    return customWord;
  }
}
