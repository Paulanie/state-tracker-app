import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/scheduler.dart';


class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(SchedulerBinding.instance.platformDispatcher.platformBrightness != Brightness.dark);

  void toggle(bool value) => emit(value);
}
