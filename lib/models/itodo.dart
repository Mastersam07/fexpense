class ITodo {
  Resource resource;

  ITodo({this.resource});

  ITodo.fromJson(Map<String, dynamic> json) {
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
  Reff ref;
  int ts;
  Data data;

  Resource({this.ref, this.ts, this.data});

  Resource.fromJson(Map<String, dynamic> json) {
    ref = json['ref'] != null ? new Reff.fromJson(json['ref']) : null;
    ts = json['ts'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ref != null) {
      data['ref'] = this.ref.toJson();
    }
    data['ts'] = this.ts;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Reff {
  Refff ref;

  Reff({this.ref});

  Reff.fromJson(Map<String, dynamic> json) {
    ref = json['@ref'] != null ? new Refff.fromJson(json['@ref']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ref != null) {
      data['@ref'] = this.ref.toJson();
    }
    return data;
  }
}

class Refff {
  String id;
  Reffff collection;

  Refff({this.id, this.collection});

  Refff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collection = json['collection'] != null
        ? new Reffff.fromJson(json['collection'])
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

class Reffff {
  String id;

  Reffff({this.id});

  Reffff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Data {
  String name;
  String amount;

  Data({this.name, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}
