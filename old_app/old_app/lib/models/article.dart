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
}