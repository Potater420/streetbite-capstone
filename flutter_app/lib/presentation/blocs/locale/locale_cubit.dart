import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  void toggle() {
    emit(state.languageCode == 'en' ? const Locale('ar') : const Locale('en'));
  }
}
