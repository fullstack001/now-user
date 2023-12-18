import 'package:application_1/model/zip_search/zip_search_list.dart';

/// current_page : 1
/// zip_search_list : [{"id":5,"code":"4545","created_at":"2021-08-13T06:03:49.000000Z","updated_at":"2021-08-13T06:03:49.000000Z"},{"id":6,"code":"4548","created_at":"2021-08-13T06:07:27.000000Z","updated_at":"2021-08-13T06:07:27.000000Z"}]
/// first_page_url : "https://api.farenow.com/api/user/services/zip-code?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://api.farenow.com/api/user/services/zip-code?page=1"
/// next_page_url : null
/// path : "https://api.farenow.com/api/user/services/zip-code"
/// per_page : 20
/// prev_page_url : null
/// to : 2
/// total : 2

class ZipSearchData {
  var currentPage;
  var zipSearchList;
  var firstPageUrl;
  var from;
  var lastPage;
  var lastPageUrl;
  dynamic nextPageUrl;
  var path;
  var perPage;
  dynamic prevPageUrl;
  var to;
  var total;

  ZipSearchData(
      {this.currentPage,
      this.zipSearchList,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  ZipSearchData.fromJson(dynamic json) {
    currentPage = json["current_page"];
    if (json["data"] != null) {
      zipSearchList = [];
      json["data"].forEach((v) {
        zipSearchList.add(ZipSearchList.fromJson(v));
      });
    }
    firstPageUrl = json["first_page_url"];
    from = json["from"];
    lastPage = json["last_page"];
    lastPageUrl = json["last_page_url"];
    nextPageUrl = json["next_page_url"];
    path = json["path"];
    perPage = json["per_page"];
    prevPageUrl = json["prev_page_url"];
    to = json["to"];
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = currentPage;
    if (zipSearchList != null) {
      map["data"] = zipSearchList.map((v) => v.toJson()).toList();
    }
    map["first_page_url"] = firstPageUrl;
    map["from"] = from;
    map["last_page"] = lastPage;
    map["last_page_url"] = lastPageUrl;
    map["next_page_url"] = nextPageUrl;
    map["path"] = path;
    map["per_page"] = perPage;
    map["prev_page_url"] = prevPageUrl;
    map["to"] = to;
    map["total"] = total;
    return map;
  }
}
