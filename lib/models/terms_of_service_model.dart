class TermsOfServiceModel {
  final String? pageName;
  final String? content;

  TermsOfServiceModel({
     this.pageName,
     this.content,
  });

  factory TermsOfServiceModel.fromJson(Map<String, dynamic> json) {
    return TermsOfServiceModel(
      pageName: json['page_name'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page_name': pageName,
      'content': content,
    };
  }
}
