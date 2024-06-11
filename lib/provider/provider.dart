import 'package:easy_localization/easy_localization.dart';
import 'package:learning/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  late BuildContext _context;
  late Locale _currentLocale;

  LanguageProvider(BuildContext context){
    _context = context;
    _currentLocale = Locale('en');
    _loadPreferences();
  }
  Locale get currentLocale => _currentLocale;
  Future<void> _loadPreferences()async {
    final savedLanguageCode =  CacheHelper.getData(key: 'language_Code');
    if(savedLanguageCode !=null){
      _currentLocale = Locale(savedLanguageCode);
    }
  }
  Future<void> changeLanguage(Locale newLocale)async {
    if(_currentLocale == newLocale){
      _currentLocale = newLocale;
      final localization = EasyLocalization.of(_context)!;
      await localization.setLocale(newLocale);
      await CacheHelper.saveData(key: 'language_Code', value: newLocale.languageCode);
      notifyListeners();
    }
  }
}