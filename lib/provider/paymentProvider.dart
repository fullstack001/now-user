import 'package:flutter/cupertino.dart';

class Paymentprovider extends ChangeNotifier {
  bool _selected = false;
  bool _selected1 = false;
  bool get selected => _selected;
  bool get selected1 => _selected1;
  setSeletion(bool val) {
    _selected = val;
    notifyListeners();
  }

  setSeletion1(bool val) {
    _selected1 = val;
    notifyListeners();
  }

  bool _callOrderTrack = false;
  bool get callOrderTrack => _callOrderTrack;
  setOrderTrack(bool val) {
    _callOrderTrack = val;
    notifyListeners();
  }

  @override
  bool operator ==(Object other) {
    return super == other;
  }

  @override
  bool get hasListeners => super.hasListeners;
}
