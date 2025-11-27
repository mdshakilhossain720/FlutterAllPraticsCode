import 'package:flutter/widgets.dart';
import 'package:rentalmanagement/generated/l10n.dart';

extension LocalizationExtension on BuildContext {
  S get l10n => S.of(this);
}
