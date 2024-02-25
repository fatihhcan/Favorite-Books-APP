import 'package:favorite_books_app/core/base/model/base_model.dart';
import 'package:favorite_books_app/feature/home/model/response/books_volume_info_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'books_item_response_model.g.dart';

@JsonSerializable()
class Items extends BaseModel<Items>{
  String? id;
  VolumeInfo? volumeInfo;

  Items({
    this.id,
    this.volumeInfo,
  });

 factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

Map<String, dynamic> toJson() =>  _$ItemsToJson(this);

  @override
  Items fromJson(Map<String, dynamic> json) {
    return _$ItemsFromJson(json);
  }
}
