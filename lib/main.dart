import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/app.dart';
import 'package:graduation/core/app/bloc_observer.dart';
import 'package:graduation/core/services/service_locator.dart';
import 'package:graduation/core/services/shared_pref/shared_pref.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initServiceLocator();

  await SharedPref().instantiatePreferences();
  SharedPref().clearPreferences();

  Bloc.observer = AppBlocObserver();
  runApp(ExamZone());
}
