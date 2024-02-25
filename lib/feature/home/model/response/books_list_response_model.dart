import 'package:favorite_books_app/core/base/model/base_model.dart';
import 'package:favorite_books_app/feature/home/model/response/books_item_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'books_list_response_model.g.dart';

@JsonSerializable()
class BooksListResponseModel extends BaseModel<BooksListResponseModel>{
  List<Items>? items;

  BooksListResponseModel({this.items});

 factory BooksListResponseModel.fromJson(Map<String, dynamic> json) => _$BooksListResponseModelFromJson(json);

Map<String, dynamic> toJson() =>  _$BooksListResponseModelToJson(this);

  @override
  BooksListResponseModel fromJson(Map<String, dynamic> json) {
    return _$BooksListResponseModelFromJson(json);
  }
}




