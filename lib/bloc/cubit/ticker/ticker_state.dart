part of 'ticker_cubit.dart';

class TickerState extends Equatable {
  const TickerState._(
      {this.currentUnixTime = 0});

  const TickerState.tick({required int currentUnixTime}) : this._(currentUnixTime: currentUnixTime);

  final int currentUnixTime;

  @override
  List<Object> get props => [currentUnixTime];
}
