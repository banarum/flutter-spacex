import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class LaunchModel {

  @JsonKey(name: 'date_unix')
  int unixDate;

  String? name;

  LinksModel links;

  String? rocket;

  // Not present in Json but we will add it later
  RocketModel? rocketData;

  LaunchModel(this.unixDate, this.name, this.links, this.rocket, this.rocketData);

  factory LaunchModel.fromJson(Map<String, dynamic> json) => _$LaunchModelFromJson(json);
}

@JsonSerializable()
class LinksModel {
  PatchModel? patch;

  LinksModel(this.patch);

  factory LinksModel.fromJson(Map<String, dynamic> json) => _$LinksModelFromJson(json);
}

@JsonSerializable()
class PatchModel {
  String? small;
  String? large;

  PatchModel(this.small, this.large);

  factory PatchModel.fromJson(Map<String, dynamic> json) => _$PatchModelFromJson(json);
}

@JsonSerializable()
class RocketModel {
  String name;

  RocketModel(this.name);

  factory RocketModel.fromJson(Map<String, dynamic> json) => _$RocketModelFromJson(json);
}