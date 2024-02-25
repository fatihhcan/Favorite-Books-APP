import 'package:favorite_books_app/core/base/model/base_model.dart';
import 'package:favorite_books_app/feature/home/model/response/books_image_links_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'books_volume_info_response_model.g.dart';

@JsonSerializable()
class VolumeInfo  extends BaseModel<VolumeInfo>{
  String? title;
  List<String>? authors;
  String? publisher;
  String? publishedDate;
  int? pageCount;
  ImageLinks? imageLinks;
  String? description;
  String? subtitle;

  VolumeInfo(
      {this.title,
      this.authors,
      this.publisher,
      this.publishedDate,
      this.pageCount,
      this.imageLinks,
      this.description,
      this.subtitle});

 factory VolumeInfo.fromJson(Map<String, dynamic> json) => _$VolumeInfoFromJson(json);

Map<String, dynamic> toJson() =>  _$VolumeInfoToJson(this);

  @override
  VolumeInfo fromJson(Map<String, dynamic> json) {
    return  _$VolumeInfoFromJson(json);
  }
}