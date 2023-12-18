import 'dart:convert';

FeedbackReviewsList feedbackReviewsListFromJson(String str) =>
    FeedbackReviewsList.fromJson(json.decode(str));

String feedbackReviewsListToJson(FeedbackReviewsList data) =>
    json.encode(data.toJson());

class FeedbackReviewsList {
  FeedbackReviewsList({
    this.error,
    this.message,
    this.data,
    this.ratings,
    this.links,
    this.meta,
  });

  var error;
  var message;
  var data;
  var ratings;
  var links;
  var meta;

  factory FeedbackReviewsList.fromJson(Map<String, dynamic> json) =>
      FeedbackReviewsList(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataofFeedback>.from(
                json["data"].map((x) => DataofFeedback.fromJson(x))),
        ratings: json["ratings"] == null
            ? null
            : FeedbackReviewsListRatings.fromJson(json["ratings"]),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "ratings": ratings == null ? null : ratings.toJson(),
        "links": links == null ? null : links.toJson(),
        "meta": meta == null ? null : meta.toJson(),
      };
}

class DataofFeedback {
  DataofFeedback({
    this.id,
    this.userId,
    this.providerId,
    this.forUserId,
    this.serviceRequestId,
    this.comment,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.orderId,
    this.productId,
    this.foodId,
    this.user,
  });

  var id;
  var userId;
  var providerId;
  var forUserId;
  var serviceRequestId;
  var comment;
  var rating;
  var createdAt;
  var updatedAt;
  var orderId;
  var productId;
  var foodId;
  var user;

  factory DataofFeedback.fromJson(Map<String, dynamic> json) => DataofFeedback(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        providerId: json["provider_id"],
        forUserId: json["for_user_id"] == null ? null : json["for_user_id"],
        serviceRequestId: json["service_request_id"] == null
            ? null
            : json["service_request_id"],
        comment: json["comment"] == null ? null : json["comment"],
        rating: json["rating"] == null ? null : json["rating"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        orderId: json["order_id"],
        productId: json["product_id"],
        foodId: json["food_id"],
        user: json["user"] == null ? null : ReviewUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "provider_id": providerId,
        "for_user_id": forUserId == null ? null : forUserId,
        "service_request_id":
            serviceRequestId == null ? null : serviceRequestId,
        "comment": comment == null ? null : comment,
        "rating": rating == null ? null : rating,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "order_id": orderId,
        "product_id": productId,
        "food_id": foodId,
        "user": user == null ? null : user.toJson(),
      };
}

class ReviewUser {
  ReviewUser({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
  });

  var id;
  var firstName;
  var lastName;
  var image;

  factory ReviewUser.fromJson(Map<String, dynamic> json) => ReviewUser(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "image": image,
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  var first;
  var last;
  var prev;
  var next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"] == null ? null : json["first"],
        last: json["last"] == null ? null : json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first == null ? null : first,
        "last": last == null ? null : last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  var currentPage;
  var from;
  var lastPage;
  var path;
  var perPage;
  var to;
  var total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class FeedbackReviewsListRatings {
  FeedbackReviewsListRatings({
    this.total,
    this.average,
    this.ratings,
  });

  var total;
  var average;
  var ratings;

  factory FeedbackReviewsListRatings.fromJson(Map<String, dynamic> json) =>
      FeedbackReviewsListRatings(
        total: json["total"] == null ? null : json["total"],
        average: json["average"] == null ? null : json["average"].toDouble(),
        ratings: json["ratings"] == null
            ? null
            : RatingsRatings.fromJson(json["ratings"]),
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "average": average == null ? null : average,
        "ratings": ratings == null ? null : ratings.toJson(),
      };
}

class RatingsRatings {
  RatingsRatings({
    this.five,
    this.four,
    this.three,
    this.two,
    this.one,
  });

  var five;
  var four;
  var three;
  var two;
  var one;

  factory RatingsRatings.fromJson(Map<String, dynamic> json) => RatingsRatings(
        five: json["five"] == null ? null : json["five"],
        four: json["four"] == null ? null : json["four"],
        three: json["three"] == null ? null : json["three"],
        two: json["two"] == null ? null : json["two"],
        one: json["one"] == null ? null : json["one"],
      );

  Map<String, dynamic> toJson() => {
        "five": five == null ? null : five,
        "four": four == null ? null : four,
        "three": three == null ? null : three,
        "two": two == null ? null : two,
        "one": one == null ? null : one,
      };
}
