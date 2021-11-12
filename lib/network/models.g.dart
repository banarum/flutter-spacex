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
      json['date_utc'] as String,
      json['id'] as String,
      json['launchpad'] as String?,
      (json['payloads'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LaunchModelToJson(LaunchModel instance) =>
    <String, dynamic>{
      'date_unix': instance.unixDate,
      'id': instance.id,
      'launchpad': instance.launchpadId,
      'payloads': instance.payloads,
      'date_utc': instance.utcDate,
      'name': instance.name,
      'links': instance.links,
      'rocket': instance.rocketId,
    };

LinksModel _$LinksModelFromJson(Map<String, dynamic> json) => LinksModel(
      json['patch'] == null
          ? null
          : PatchModel.fromJson(json['patch'] as Map<String, dynamic>),
      json['reddit'] == null
          ? null
          : RedditModel.fromJson(json['reddit'] as Map<String, dynamic>),
      json['wikipedia'] as String?,
      json['youtube_id'] as String?,
      json['webcast'] as String?,
      json['article'] as String?,
    );

Map<String, dynamic> _$LinksModelToJson(LinksModel instance) =>
    <String, dynamic>{
      'patch': instance.patch,
      'reddit': instance.reddit,
      'wikipedia': instance.wikipedia,
      'youtube_id': instance.youtubeId,
      'webcast': instance.webcast,
      'article': instance.article,
    };

RedditModel _$RedditModelFromJson(Map<String, dynamic> json) => RedditModel(
      json['campaign'] as String?,
    );

Map<String, dynamic> _$RedditModelToJson(RedditModel instance) =>
    <String, dynamic>{
      'campaign': instance.campaign,
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
      (json['flickr_images'] as List<dynamic>).map((e) => e as String).toList(),
      json['description'] as String,
    );

Map<String, dynamic> _$RocketModelToJson(RocketModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'flickr_images': instance.images,
    };

LaunchpadModel _$LaunchpadModelFromJson(Map<String, dynamic> json) =>
    LaunchpadModel(
      json['full_name'] as String,
      json['locality'] as String,
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
      ImagesModel.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LaunchpadModelToJson(LaunchpadModel instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'locality': instance.locality,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'images': instance.images,
    };

ImagesModel _$ImagesModelFromJson(Map<String, dynamic> json) => ImagesModel(
      (json['large'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ImagesModelToJson(ImagesModel instance) =>
    <String, dynamic>{
      'large': instance.large,
    };

PayloadModel _$PayloadModelFromJson(Map<String, dynamic> json) => PayloadModel(
      json['name'] as String,
      json['type'] as String,
      json['mass_kg'] as int?,
    );

Map<String, dynamic> _$PayloadModelToJson(PayloadModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'mass_kg': instance.mass,
    };
