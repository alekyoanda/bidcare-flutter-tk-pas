import 'package:flutter/cupertino.dart';

class BidBarangLelang with ChangeNotifier {
  int _bid = 0;

  void changeBid(String bid) {
    print("$bid tes");
    if (bid != null) {
      _bid = int.parse(bid);
      print("BERHASIL PLSS");
    }
    notifyListeners();
  }

  int get curBid {
    return _bid;
  }
}
