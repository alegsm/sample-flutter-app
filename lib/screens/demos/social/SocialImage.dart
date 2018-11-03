class SocialImage
{
  String url;
  double height;
  double width;

  double get aspectRatio
  {
    return height / width;
  }

  calculateHeight(double width)
  {
    return aspectRatio * width;
  }

  SocialImage({this.url, this.height, this.width});
}