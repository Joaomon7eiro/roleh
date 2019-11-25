import './external_url.dart';

class Artist {
  ExternalUrl externalUrls;
  String href;
  String id;
  String name;
  String image;
  String type;
  String uri;

  Artist(
      {this.externalUrls,
      this.href,
      this.id,
      this.image,
      this.name,
      this.type,
      this.uri});

  Artist.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrl.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    name = json['name'];
    image = json['images'] != null && json['images'].length > 0
        ? json['images'][0]["url"]
        : null;
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['uri'] = this.uri;
    data['image'] = this.uri;
    return data;
  }
}
