import './external_url.dart';
import './artist.dart';

class Track {
  List<Artist> artists;
  int discNumber;
  int durationMs;
  bool explicit;
  ExternalUrl externalUrls;
  String href;
  String id;
  bool isPlayable;
  String name;
  String previewUrl;
  int trackNumber;
  String type;
  String uri;

  Track(
      {this.artists,
      this.discNumber,
      this.durationMs,
      this.explicit,
      this.externalUrls,
      this.href,
      this.id,
      this.isPlayable,
      this.name,
      this.previewUrl,
      this.trackNumber,
      this.type,
      this.uri});

  Track.fromJson(Map<String, dynamic> json) {
    if (json['artists'] != null) {
      artists = new List<Artist>();
      json['artists'].forEach((v) {
        artists.add(new Artist.fromJson(v));
      });
    }
    discNumber = json['disc_number'];
    durationMs = json['duration_ms'];
    explicit = json['explicit'];
    externalUrls = json['external_urls'] != null
        ? new ExternalUrl.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    isPlayable = json['is_playable'];
    name = json['name'];
    previewUrl = json['preview_url'];
    trackNumber = json['track_number'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    data['disc_number'] = this.discNumber;
    data['duration_ms'] = this.durationMs;
    data['explicit'] = this.explicit;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['is_playable'] = this.isPlayable;
    data['name'] = this.name;
    data['preview_url'] = this.previewUrl;
    data['track_number'] = this.trackNumber;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}
