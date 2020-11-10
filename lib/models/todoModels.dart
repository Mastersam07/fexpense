class Todo {
  Resource resource;

  Todo({this.resource});

  Todo.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] != null
        ? new Resource.fromJson(json['resource'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resource != null) {
      data['resource'] = this.resource.toJson();
    }
    return data;
  }
}

class Resource {
  List<Data> data;

  Resource({this.data});

  Resource.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Reff ref;

  Data({this.ref});

  Data.fromJson(Map<String, dynamic> json) {
    ref = json['@ref'] != null ? new Reff.fromJson(json['@ref']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ref != null) {
      data['@ref'] = this.ref.toJson();
    }
    return data;
  }
}

class Reff {
  String id;
  Data collection;

  Reff({this.id, this.collection});

  Reff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collection = json['collection'] != null
        ? new Data.fromJson(json['collection'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.collection != null) {
      data['collection'] = this.collection.toJson();
    }
    return data;
  }
}

class Refff {
  String id;

  Refff({this.id});

  Refff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
