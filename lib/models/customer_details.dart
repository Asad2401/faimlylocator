class LoginModel {
  int isSuccess;
  String exception;
  Response response;

  LoginModel({this.isSuccess, this.exception, this.response});

  LoginModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['is_success'];
    exception = json['exception'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_success'] = this.isSuccess;
    data['exception'] = this.exception;
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class Response {
  Me me;
  List<Child> child;
  List<Null> request;

  Response({this.me, this.child, this.request});

  Response.fromJson(Map<String, dynamic> json) {
    me = json['me'] != null ? new Me.fromJson(json['me']) : null;
    if (json['child'] != null) {
      child = new List<Child>();
      json['child'].forEach((v) {
        child.add(new Child.fromJson(v));
      });
    }
    // if (json['request'] != null) {
    //   request = new List<Null>();
    //   json['request'].forEach((v) {
    //     request.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.me != null) {
      data['me'] = this.me.toJson();
    }
    if (this.child != null) {
      data['child'] = this.child.map((v) => v.toJson()).toList();
    }
    // if (this.request != null) {
    //   data['request'] = this.request.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Me {
  String uid;
  String firstName;
  String lastName;
  String email;
  Null parentId;
  String role;
  String profilePic;
  String contact;

  Me(
      {this.uid,
        this.firstName,
        this.lastName,
        this.email,
        this.parentId,
        this.role,
        this.profilePic,
        this.contact});

  Me.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    parentId = json['parentId'];
    role = json['role'];
    profilePic = json['profilePic'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['parentId'] = this.parentId;
    data['role'] = this.role;
    data['profilePic'] = this.profilePic;
    data['contact'] = this.contact;
    return data;
  }
}

class Child {
  String uid;
  String firstName;
  String lastName;
  String email;
  String parentId;
  String request;
  String role;
  String profilePic;
  String contact;

  Child(
      {this.uid,
        this.firstName,
        this.lastName,
        this.email,
        this.parentId,
        this.request,
        this.role,
        this.profilePic,
        this.contact});

  Child.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    parentId = json['parentId'];
    request = json['request'];
    role = json['role'];
    profilePic = json['profilePic'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['parentId'] = this.parentId;
    data['request'] = this.request;
    data['role'] = this.role;
    data['profilePic'] = this.profilePic;
    data['contact'] = this.contact;
    return data;
  }
}

