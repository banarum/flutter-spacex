import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ticker_state.dart';

class TickerCubit extends Cubit<TickerState> {
  TickerCubit()
      : super(TickerState.tick(
            currentUnixTime: DateTime.now().millisecondsSinceEpoch));

  StreamSubscription<void>? _tickerSubscription;

  Stream<void> _tick() {
    return Stream.periodic(const Duration(seconds: 1))
        .takeWhile((element) => true);
  }

  Future<void> startTicker() async {
    _tickerSubscription?.cancel();
    _tickerSubscription = _tick().listen((_) => emit(TickerState.tick(
        currentUnixTime:
            (DateTime.now().millisecondsSinceEpoch / 1000).floor())));
  }

  Future<void> stopTicker() async {
    _tickerSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
