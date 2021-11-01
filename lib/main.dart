import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/network/repository.dart';
import 'app.dart';
import 'bloc/bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(App(repository: Repository()));
}
