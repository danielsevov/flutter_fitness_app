class Article {
  String author, title, description, url, urlToImage, content;

  Article(this.author, this.title, this.description, this.url, this.urlToImage,
      this.content);

  Article.fromJson(Map<String, dynamic> json)
      : author = json['author']??'',
        title = json['title']??'',
        description = json['description']??'',
        url = json['url']??'',
        urlToImage = json['urlToImage']??'',
        content = json['content']??'';

  Map<String, dynamic> toJson() => {
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'content': content,
  };

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

  @override
  int get hashCode =>
      author.hashCode ^
      title.hashCode ^
      description.hashCode ^
      url.hashCode ^
      urlToImage.hashCode ^
      content.hashCode;
}