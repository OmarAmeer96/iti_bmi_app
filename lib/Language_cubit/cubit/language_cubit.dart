import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  var local = Locale(Platform.localeName.substring(0, 2));

  void changeLanguage() {
    if (local == const Locale("ar")) {
      local = const Locale("en");
    } else {
      local = const Locale("ar");
    }
    emit(LanguageChangeState());
    print(Platform.localeName);
  }
}
