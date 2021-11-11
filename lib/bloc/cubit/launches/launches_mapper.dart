part of 'launches_cubit.dart';

List<LaunchItemViewState> _mapLaunchesToView(
    {required Map<LaunchModel, RocketModel> rockets,
    required List<LaunchModel> launches,
    required DateTime now}) {
  return launches
      .map((element) => LaunchItemViewState(
            timeLabel: "",
            title: element.name!,
            rocketName: rockets[element]?.name ?? "None",
            launchId: element.id,
            timeValue: DateTime.parse(element.utcDate),
          ))
      .toList()
    ..forEach((element) => element.timeLabel =
        _mapTimeToString(now: now, launchTime: element.timeValue));
}

List<LaunchItemViewState> _mapViewToViewWithTime(
    {required List<LaunchItemViewState> views, required DateTime now}) {
  return views
      .map((element) => LaunchItemViewState(
          timeValue: element.timeValue,
          timeLabel: _mapTimeToString(now: now, launchTime: element.timeValue),
          rocketName: element.rocketName,
          launchId: element.launchId,
          title: element.title))
      .toList();
}

String _mapTimeToString({required DateTime now, required DateTime launchTime}) {
  final difference = launchTime.difference(now);

  if (difference.isNegative) return "Lift off!";

  final int daysLeft = difference.inDays;
  final int hoursLeft = difference.inHours - daysLeft * 24;
  final int minutesLeft =
      difference.inMinutes - daysLeft * 24 * 60 - hoursLeft * 60;
  final int secondsLeft = difference.inSeconds -
      daysLeft * 24 * 60 * 60 -
      hoursLeft * 60 * 60 -
      minutesLeft * 60;

  String formatTimeValue(int num) => num < 10 ? "0$num" : num.toString();

  final String daysLabel = daysLeft.toString();
  final String hoursLabel = hoursLeft.toString();
  final String minutesLabel = formatTimeValue(minutesLeft);
  final String secondsLabel = formatTimeValue(secondsLeft);

  if (daysLeft < 1) {
    return "Launch Today in $hoursLabel:$minutesLabel:$secondsLabel";
  }

  if (daysLeft == 1) {
    return "Launch in $daysLabel day $hoursLabel:$minutesLabel:$secondsLabel";
  }

  return "Launch in $daysLabel days $hoursLabel:$minutesLabel:$secondsLabel";
}
