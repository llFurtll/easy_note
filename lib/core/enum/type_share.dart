enum TypeShare {
  image,
  pdf;

  static bool isImage(TypeShare type) {
    return type == image;
  }

  static bool isPdf(TypeShare type) {
    return type == pdf;
  }
}