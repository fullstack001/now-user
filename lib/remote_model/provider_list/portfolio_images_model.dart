class PortfolioImages {
  PortfolioImages({
    this.id,
    this.userId,
    this.type,
    this.name,
    this.url,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.quotationInfoId,
    this.portfolioId,
  });

  PortfolioImages.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
    verified = json['verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    quotationInfoId = json['quotation_info_id'];
    portfolioId = json['portfolio_id'];
  }
  var id;
  dynamic userId;
  var type;
  dynamic name;
  var url;
  var verified;
  var createdAt;
  var updatedAt;
  dynamic quotationInfoId;
  var portfolioId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['type'] = type;
    map['name'] = name;
    map['url'] = url;
    map['verified'] = verified;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['quotation_info_id'] = quotationInfoId;
    map['portfolio_id'] = portfolioId;
    return map;
  }
}
