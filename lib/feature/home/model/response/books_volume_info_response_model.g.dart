// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_volume_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeInfo _$VolumeInfoFromJson(Map<String, dynamic> json) => VolumeInfo(
      title: json['title'] as String?,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      publisher: json['publisher'] as String?,
      publishedDate: json['publishedDate'] as String?,
      pageCount: json['pageCount'] as int?,
      imageLinks: json['imageLinks'] == null
          ? null
          : ImageLinks.fromJson(json['imageLinks'] as Map<String, dynamic>),
      description: json['description'] as String?,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$VolumeInfoToJson(VolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'pageCount': instance.pageCount,
      'imageLinks': instance.imageLinks?.toJson(),
      'description': instance.description,
      'subtitle': instance.subtitle,
    };
