  abstract class BaseModel<T> {
  int? localId;
  bool? isFavorite;

  BaseModel({
    this.localId,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
}
