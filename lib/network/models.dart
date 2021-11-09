import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class LaunchModel {
  @JsonKey(name: 'date_unix')
  int unixDate;

  String id;

  @JsonKey(name: "launchpad")
  String? launchpadId;

  @JsonKey(name: "date_utc")
  String utcDate;

  String? name;

  LinksModel links;

  @JsonKey(name: "rocket")
  String? rocketId;

  // Not present in Json but we will add it after processing
  @JsonKey(ignore: true)
  RocketModel? rocketData;

  @JsonKey(ignore: true)
  LaunchpadModel? launchpadData;

  LaunchModel(this.unixDate, this.name, this.links, this.rocketId, this.utcDate,
      this.id, this.launchpadId);

  factory LaunchModel.fromJson(Map<String, dynamic> json) =>
      _$LaunchModelFromJson(json);

  String timeLeft(DateTime now) {
    final launchTime = DateTime.parse(utcDate);

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
      return "Launch today at $hoursLabel:$minutesLabel:$secondsLabel";
    }

    if (daysLeft == 1) {
      return "Launch in $daysLabel day $hoursLabel:$minutesLabel:$secondsLabel";
    }

    return "Launch in $daysLabel days $hoursLabel:$minutesLabel:$secondsLabel";
  }
}

@JsonSerializable()
class LinksModel {
  PatchModel? patch;
  RedditModel? reddit;
  String? wikipedia;

  @JsonKey(name: "youtube_id")
  String? youtubeId;

  String? webcast;
  String? article;

  LinksModel(this.patch, this.reddit, this.wikipedia, this.youtubeId,
      this.webcast, this.article);

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      _$LinksModelFromJson(json);
}

@JsonSerializable()
class RedditModel {
  String? campaign;

  RedditModel(this.campaign);

  factory RedditModel.fromJson(Map<String, dynamic> json) =>
      _$RedditModelFromJson(json);
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

@JsonSerializable()
class LaunchpadModel {
  @JsonKey(name: "full_name")
  String fullName;

  String locality;

  double latitude;
  double longitude;

  ImagesModel images;

  LaunchpadModel(
      this.fullName, this.locality, this.latitude, this.longitude, this.images);

  factory LaunchpadModel.fromJson(Map<String, dynamic> json) =>
      _$LaunchpadModelFromJson(json);
}

@JsonSerializable()
class ImagesModel {
  List<String>? large;

  ImagesModel(this.large);

  factory ImagesModel.fromJson(Map<String, dynamic> json) =>
      _$ImagesModelFromJson(json);
}
