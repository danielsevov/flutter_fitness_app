/// Entity class for holding details of a single article instance.
class Article {
  String author,    // author of the article
      title,        // title of the article
      description,  // short description of the content of the article
      url,          // URL of the article
      urlToImage,   // URL to the image of the article
      content;      // the content of the article

  // Simple constructor for creating an instance of an Article
  Article(this.author, this.title, this.description, this.url, this.urlToImage,
      this.content);

  // Function used for transforming a JSON to an Article object.
  Article.fromJson(Map<String, dynamic> json)
      : author = json['author']??'',
        title = json['title']??'',
        description = json['description']??'',
        url = json['url']??'',
        urlToImage = json['urlToImage']??'',
        content = json['content']??'';

  // Function used for transforming a Article to JSON map.
  Map<String, dynamic> toJson() => {
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'content': content,
  };

  // Equals function
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Article &&
          runtimeType == other.runtimeType &&
          author == other.author &&
          title == other.title &&
          description == other.description &&
          url == other.url &&
          urlToImage == other.urlToImage &&
          content == other.content;

  //Hashcode function
  @override
  int get hashCode =>
      author.hashCode ^
      title.hashCode ^
      description.hashCode ^
      url.hashCode ^
      urlToImage.hashCode ^
      content.hashCode;
}