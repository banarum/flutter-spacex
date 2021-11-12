part of 'launches_cubit.dart';

LaunchItemViewState _mapLaunchToView(
    {required RocketModel? rocket,
    required LaunchModel launch,
    required DateTime now,
    required bool starred}) {
  final timeValue = DateTime.parse(launch.utcDate);
  return LaunchItemViewState(
      timeLabel: _mapTimeToString(now: now, launchTime: timeValue),
      title: launch.name!,
      rocketName: rocket?.name ?? "None",
      launchId: launch.id,
      timeValue: timeValue,
      patchUrl: launch.links.patch?.small,
      starred: starred);
}

List<LaunchItemViewState> _mapViewToViewWithTime(
    {required List<LaunchItemViewState> views, required DateTime now}) {
  return views
      .map((element) => LaunchItemViewState(
          timeValue: element.timeValue,
          timeLabel: _mapTimeToString(now: now, launchTime: element.timeValue),
          rocketName: element.rocketName,
          launchId: element.launchId,
          patchUrl: element.patchUrl,
          title: element.title,
          starred: element.starred
  ))
      .toList();
}

String _mapTimeToString({required DateTime now, required DateTime launchTime}) {
  final difference = launchTime.difference(now);

  String formatTimeValue(int num) => num < 10 ? "0$num" : num.toString();

  if (difference.isNegative)
    return "Launched on ${formatTimeValue(launchTime.day)}.${formatTimeValue(launchTime.month)}.${launchTime.year}";

  final int daysLeft = difference.inDays;
  final int hoursLeft = difference.inHours - daysLeft * 24;
  final int minutesLeft =
      difference.inMinutes - daysLeft * 24 * 60 - hoursLeft * 60;
  final int secondsLeft = difference.inSeconds -
      daysLeft * 24 * 60 * 60 -
      hoursLeft * 60 * 60 -
      minutesLeft * 60;

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
