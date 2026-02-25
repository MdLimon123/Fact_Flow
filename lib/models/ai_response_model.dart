class AiResponseModel {
  final String? verdict;
  final double? confidence;
  final String? claim;
  final String? conclusion;
  final Evidence? evidence;
  final List<Source>? sources;
  final String? timestamp;
  final String? uid;
  final String? userId;

  AiResponseModel({
    this.verdict,
    this.confidence,
    this.claim,
    this.conclusion,
    this.evidence,
    this.sources,
    this.timestamp,
    this.uid,
    this.userId,
  });

  factory AiResponseModel.fromJson(Map<String, dynamic> json) {
    return AiResponseModel(
      verdict: json['verdict'],
      confidence: (json['confidence'] as num?)?.toDouble(),
      claim: json['claim'],
      conclusion: json['conclusion'],
      evidence: json['evidence'] != null
          ? Evidence.fromJson(json['evidence'])
          : null,
      sources: json['sources'] != null
          ? List<Source>.from(
              json['sources'].map((x) => Source.fromJson(x)),
            )
          : null,
      timestamp: json['timestamp'],
      uid: json['uid'] ?? "",
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verdict': verdict,
      'confidence': confidence,
      'claim': claim,
      'conclusion': conclusion,
      'evidence': evidence?.toJson(),
      'sources': sources?.map((x) => x.toJson()).toList(),
      'timestamp': timestamp,
      'uid': uid,
      'user_id': userId,
    };
  }
}
class Evidence {
  final List<String>? supporting;
  final List<String>? counter;

  Evidence({this.supporting, this.counter});

  factory Evidence.fromJson(Map<String, dynamic> json) {
    return Evidence(
      supporting: json['supporting'] != null
          ? List<String>.from(json['supporting'])
          : null,
      counter: json['counter'] != null
          ? List<String>.from(json['counter'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'supporting': supporting,
      'counter': counter,
    };
  }
}
class Source {
  final String? title;
  final String? url;

  Source({this.title, this.url});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      title: json['title'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
    };
  }
}
