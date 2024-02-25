// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksListResponseModel _$BooksListResponseModelFromJson(
        Map<String, dynamic> json) =>
    BooksListResponseModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BooksListResponseModelToJson(
        BooksListResponseModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
