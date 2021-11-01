import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class LaunchModel {
  @JsonKey(name: 'date_unix')
  int unixDate;

  @JsonKey(name: "date_utc")
  String utcDate;

  String? name;

  LinksModel links;

  @JsonKey(name: "rocket")
  String? rocketId;

  // Not present in Json but we will add it after processing
  RocketModel? rocketData;

  LaunchModel(this.unixDate, this.name, this.links, this.rocketId,
      this.rocketData, this.utcDate);

  factory LaunchModel.fromJson(Map<String, dynamic> json) =>
      _$LaunchModelFromJson(json);

  String timeLeft(int currentTime) {
    const secToDays = 1 / 60 / 60 / 24;
    const secToHours = 1 / 60 / 60;
    const secToMinutes = 1 / 60;
    const daysToSec = 60 * 60 * 24;
    const hoursToSec = 60 * 60;
    const minutesToSec = 60;

    final timeLeft = unixDate - currentTime;

    if (timeLeft <= 0) return "Lift off!";

    final int daysLeft = (timeLeft * secToDays).floor();
    final int hoursLeft =
        ((timeLeft - daysLeft * daysToSec) * secToHours).floor();
    final int minutesLeft =
        ((timeLeft - daysLeft * daysToSec - hoursLeft * hoursToSec) *
                secToMinutes)
            .floor();
    final int secondsLeft = (timeLeft -
            daysLeft * daysToSec -
            hoursLeft * hoursToSec -
            minutesLeft * minutesToSec)
        .floor();

    String formatTimeValue(int num) => num < 10 ? "0$num" : num.toString();

    final String daysLabel = daysLeft.toString();
    final String hoursLabel = hoursLeft.toString();
    final String minutesLabel = formatTimeValue(minutesLeft);
    final String secondsLabel = formatTimeValue(secondsLeft);

    return "Launch in $daysLabel days $hoursLabel:$minutesLabel:$secondsLabel";
  }
}

@JsonSerializable()
class LinksModel {
  PatchModel? patch;

  LinksModel(this.patch);

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      _$LinksModelFromJson(json);
}

@JsonSerializable()
class PatchModel {
  String? small;
  String? large;

  PatchModel(this.small, this.large);

  factory PatchModel.fromJson(Map<String, dynamic> json) =>
      _$PatchModelFromJson(json);
}

@JsonSerializable()
class RocketModel {
  String name;

  RocketModel(this.name);

  factory RocketModel.fromJson(Map<String, dynamic> json) =>
      _$RocketModelFromJson(json);
}
