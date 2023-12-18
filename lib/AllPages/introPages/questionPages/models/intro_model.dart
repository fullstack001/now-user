import 'package:application_1/AllPages/introPages/questionPages/models/button_selection_model.dart';

class IntroModel {
  var buttonModel;
  var homeType;
  var whatBest;
  var address;

  IntroModel({
    this.address,
    this.whatBest,
    this.homeType,
    this.buttonModel,
  });

  IntroModel.fromJson(dynamic json) {
    homeType = json['homeType'];
    whatBest = json['whatBest'];
    address = json['address'];
    var list = json['buttonModel']
        .map((v) => ButtonSelectionModel.fromJson(v))
        .toList();
    list = list.cast<ButtonSelectionModel>().toList();
    buttonModel = list;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['buttonModel'] = buttonModel.map((e) => e.toJson()).toList();
    map['homeType'] = homeType;
    map['whatBest'] = whatBest;
    map['address'] = address;
    return map;
  }
}
