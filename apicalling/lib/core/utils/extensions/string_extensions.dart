extension StringCasingExtension on String? {
  String get toCapitalizeFirstLetter {
    final value = this;
    if (value == null || value.isEmpty) return '';
    return value[0].toUpperCase() + value.substring(1);
  }
}

String formatStatus(String status) {
  return status
      .replaceAll('_', ' ') // Replace underscore with space
      .split(' ')
      .map(
        (word) => word.isEmpty
            ? word
            : '${word[0].toUpperCase()}${word.substring(1)}',
      ) // Capitalize first letter
      .join(' ');
}
