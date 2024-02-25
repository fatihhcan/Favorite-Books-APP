import 'package:favorite_books_app/core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'books_image_links_response_model.g.dart';

@JsonSerializable()
class ImageLinks extends BaseModel<ImageLinks>{
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

 factory ImageLinks.fromJson(Map<String, dynamic> json) => _$ImageLinksFromJson(json);

Map<String, dynamic> toJson() =>  _$ImageLinksToJson(this);

  @override
  ImageLinks fromJson(Map<String, dynamic> json) {
    return _$ImageLinksFromJson(json);
  }
}
