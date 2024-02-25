class ImageConstants {
  static ImageConstants? _instance;
  static ImageConstants get instance {
    return _instance ??= ImageConstants._init();
  }
  ImageConstants._init();

  String get emptyBook => toJpeg('img_empty_book');

  String toJpeg(String name) => 'assets/images/$name.png';
}
