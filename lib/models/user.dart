import './external_url.dart';

class User {
  String country;
  String displayName;
  String email;
  ExternalUrl externalUrls;
  String href;
  String id;
  String product;
  String type;
  String uri;

  User(
      {this.country,
      this.displayName,
      this.email,
      this.externalUrls,
      this.href,
      this.id,
      this.product,
      this.type,
      this.uri});

  User.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    displayName = json['display_name'];
    email = json['email'];
    externalUrls = json['external_urls'] != null
        ? new ExternalUrl.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    product = json['product'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['product'] = this.product;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}
