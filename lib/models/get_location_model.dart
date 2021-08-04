class LocationModel1 {
  int isSuccess;
  String exception;
  List<Response> response;

  LocationModel1({this.isSuccess, this.exception, this.response});

  LocationModel1.fromJson(Map<String, dynamic> json) {
    isSuccess = json['is_success'];
    exception = json['exception'];
    if (json['response'] != null) {
      response = new List<Response>();
      json['response'].forEach((v) {
        response.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_success'] = this.isSuccess;
    data['exception'] = this.exception;
    if (this.response != null) {
      data['response'] = this.response.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String uid;
  String latlong;
  String parentId;
  String allowChild;

  Response({this.uid, this.latlong, this.parentId, this.allowChild});

  Response.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    latlong = json['latlong'];
    parentId = json['parentId'];
    allowChild = json['allowChild'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['latlong'] = this.latlong;
    data['parentId'] = this.parentId;
    data['allowChild'] = this.allowChild;
    return data;
  }
}

