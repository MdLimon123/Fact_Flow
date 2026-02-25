class AiHistoryResponseModel {
  final List<AiHistoryItem> items;

  AiHistoryResponseModel({required this.items});

  factory AiHistoryResponseModel.fromJson(List<dynamic> jsonList) {
    return AiHistoryResponseModel(
      items: jsonList.map((e) => AiHistoryItem.fromJson(e)).toList(),
    );
  }
}

class AiHistoryItem {
  final String verdict;
  final double confidence;
  final String claim;
  final String conclusion;
  final Evidence evidence;
  final List<SourceItem> sources;
  final String timestamp;
  final String userId;
  final String uid;

  AiHistoryItem({
    required this.verdict,
    required this.confidence,
    required this.claim,
    required this.conclusion,
    required this.evidence,
    required this.sources,
    required this.timestamp,
    required this.userId,
    required this.uid,
  });

  factory AiHistoryItem.fromJson(Map<String, dynamic> json) {
    return AiHistoryItem(
      verdict: json['verdict'] ?? '',
      confidence: (json['confidence'] ?? 0).toDouble(),
      claim: json['claim'] ?? '',
      conclusion: json['conclusion'] ?? '',
      evidence: Evidence.fromJson(json['evidence'] ?? {}),
      sources: (json['sources'] as List<dynamic>? ?? [])
          .map((e) => SourceItem.fromJson(e))
          .toList(),
      timestamp: json['timestamp'] ?? '',
      userId: json['user_id'] ?? '',
      uid: json['uid'] ?? '',
    );
  }
}

class Evidence {
  final List<String> supporting;
  final List<String> counter;

  Evidence({required this.supporting, required this.counter});

  factory Evidence.fromJson(Map<String, dynamic> json) {
    return Evidence(
      supporting: (json['supporting'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      counter: (json['counter'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

class SourceItem {
  final String title;
  final String url;

  SourceItem({required this.title, required this.url});

  factory SourceItem.fromJson(Map<String, dynamic> json) {
    return SourceItem(
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
