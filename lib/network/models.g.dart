// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchModel _$LaunchModelFromJson(Map<String, dynamic> json) => LaunchModel(
      json['date_unix'] as int,
      json['name'] as String?,
      LinksModel.fromJson(json['links'] as Map<String, dynamic>),
      json['rocket'] as String?,
      json['rocketData'] == null
          ? null
          : RocketModel.fromJson(json['rocketData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LaunchModelToJson(LaunchModel instance) =>
    <String, dynamic>{
      'date_unix': instance.unixDate,
      'name': instance.name,
      'links': instance.links,
      'rocket': instance.rocket,
      'rocketData': instance.rocketData,
    };

LinksModel _$LinksModelFromJson(Map<String, dynamic> json) => LinksModel(
      json['patch'] == null
          ? null
          : PatchModel.fromJson(json['patch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinksModelToJson(LinksModel instance) =>
    <String, dynamic>{
      'patch': instance.patch,
    };

PatchModel _$PatchModelFromJson(Map<String, dynamic> json) => PatchModel(
      json['small'] as String?,
      json['large'] as String?,
    );

Map<String, dynamic> _$PatchModelToJson(PatchModel instance) =>
    <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
    };

RocketModel _$RocketModelFromJson(Map<String, dynamic> json) => RocketModel(
      json['name'] as String,
    );

Map<String, dynamic> _$RocketModelToJson(RocketModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
