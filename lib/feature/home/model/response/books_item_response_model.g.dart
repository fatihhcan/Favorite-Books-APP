// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      id: json['id'] as String?,
      volumeInfo: json['volumeInfo'] == null
          ? null
          : VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
    );


Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'id': instance.id,
      'volumeInfo': instance.volumeInfo,
    };
