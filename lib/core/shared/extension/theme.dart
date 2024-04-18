import 'package:credentials/core/shared/theme/scheme.dart';
import 'package:credentials/core/shared/theme/theme_bloc.dart';

import '../shared.dart';

extension ThemeExtension on ThemeState {
  ThemeState copyWith({
    ThemeType? type,
  }) {
    return ThemeState(
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.index,
    };
  }

  ThemeScheme get scheme {
    return ThemeScheme.find(type: type);
  }
}
