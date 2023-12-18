import 'package:application_1/remote_model/provider_list/port_folio_model.dart';

class Portfolio {
  Portfolio({
    this.id,
    this.providerId,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.portfolioImages,
  });

  Portfolio.fromJson(dynamic json) {
    if (json != null) {
      portfolioImages = [];
      json.forEach((v) {
        portfolioImages.add(PortFolioModel.fromJson(v));
      });
    }
  }

  var id;
  var providerId;
  var description;
  var createdAt;
  var updatedAt;
  var portfolioImages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['provider_id'] = providerId;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (portfolioImages != null) {
      map['portfolio_images'] = portfolioImages.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
