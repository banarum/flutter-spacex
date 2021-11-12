import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class LaunchModel {
  @JsonKey(name: 'date_unix')
  int unixDate;

  String id;

  @JsonKey(name: "launchpad")
  String? launchpadId;

  List<String> payloads;

  @JsonKey(name: "date_utc")
  String utcDate;

  String? name;

  LinksModel links;

  @JsonKey(name: "rocket")
  String? rocketId;

  LaunchModel(this.unixDate, this.name, this.links, this.rocketId, this.utcDate,
      this.id, this.launchpadId, this.payloads);

  factory LaunchModel.fromJson(Map<String, dynamic> json) =>
      _$LaunchModelFromJson(json);
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
  String description;

  @JsonKey(name: "flickr_images")
  List<String> images;

  RocketModel(this.name, this.images, this.description);

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

@JsonSerializable()
class PayloadModel {
  String name;
  String type;

  @JsonKey(name: "mass_kg")
  int? mass;

  PayloadModel(this.name, this.type, this.mass);

  factory PayloadModel.fromJson(Map<String, dynamic> json) =>
      _$PayloadModelFromJson(json);
}
