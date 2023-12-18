import 'zip_search_data.dart';

/// error : false
/// message : "success"
/// zip_search_data : {"current_page":1,"zip_search_list":[{"id":5,"code":"4545","created_at":"2021-08-13T06:03:49.000000Z","updated_at":"2021-08-13T06:03:49.000000Z"},{"id":6,"code":"4548","created_at":"2021-08-13T06:07:27.000000Z","updated_at":"2021-08-13T06:07:27.000000Z"}],"first_page_url":"https://api.farenow.com/api/user/services/zip-code?page=1","from":1,"last_page":1,"last_page_url":"https://api.farenow.com/api/user/services/zip-code?page=1","next_page_url":null,"path":"https://api.farenow.com/api/user/services/zip-code","per_page":20,"prev_page_url":null,"to":2,"total":2}

class ZipSearchResponse {
  var error;
  var message;
  var zipSearchData;

  ZipSearchResponse({
      this.error, 
      this.message, 
      this.zipSearchData});

  ZipSearchResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    zipSearchData = json["data"] != null ? ZipSearchData.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    if (zipSearchData != null) {
      map["data"] = zipSearchData.toJson();
    }
    return map;
  }

}