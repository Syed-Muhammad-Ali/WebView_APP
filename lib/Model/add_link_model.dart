class AddLinkModel {
  int? id;
  String? url;
 

  AddLinkModel({
    this.id,
    required this.url,
  
  });

  AddLinkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    url = json['url'];
   
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> WebLinkData = <String, dynamic>{};
    WebLinkData['id'] = id;
    WebLinkData['url'] = url;

    return WebLinkData;
  }

  void clear() {}
}
