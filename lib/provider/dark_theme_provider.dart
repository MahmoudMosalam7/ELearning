import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/local/cache_helper.dart';

enum ThemeModeEnum { light, dark }

class ThemeDarkModeNotifier extends StateNotifier<ThemeModeEnum> {
  ThemeDarkModeNotifier() : super(ThemeModeEnum.light);

  static const String _themeKey = 'theme_mode';

  void selectMode() async {
    state = state == ThemeModeEnum.light ? ThemeModeEnum.dark : ThemeModeEnum.light;
    await CacheHelper.saveData(key: _themeKey, value: state.toString());
  }

  Future<void> loadSavedThemeMode() async {
    final savedThemeMode = await CacheHelper.getString(key: _themeKey);

    if (savedThemeMode != null) {
      state = ThemeModeEnum.values.firstWhere(
            (mode) => mode.toString() == savedThemeMode,
        orElse: () => ThemeModeEnum.light,
      );
    }
  }
}

final themeDarkMode = StateNotifierProvider<ThemeDarkModeNotifier, ThemeModeEnum>((ref) {
  final notifier = ThemeDarkModeNotifier();
  notifier.loadSavedThemeMode();
  return notifier;
});
