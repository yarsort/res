import 'dart:convert';

class Bonus {
  String name;
  double sum;
  String type;
  String activation;

  Bonus({this.name, this.sum, this.type, this.activation});

  Bonus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sum = double.parse(json['sum']);
    type = json['type'];
    activation = json['activation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sum'] = this.sum;
    data['type'] = this.type;
    data['activation'] = this.activation;
    return data;
  }
}

class OrderFromBase {
  String docUIDClient;
  String docNameClient;
  DateTime docDate;
  String docStatus;
  String docUID;
  String docNumber;
  String docUser;
  double docSum;
  double docSumBonusPlus;
  double docSumBonusMinus;
  String docStore;
  int docItemsCount;

  OrderFromBase(
      { this.docUIDClient,
        this.docNameClient,
        this.docDate,
        this.docStatus,
        this.docUID,
        this.docNumber,
        this.docUser,
        this.docSum,
        this.docSumBonusPlus,
        this.docSumBonusMinus,
        this.docStore,
        this.docItemsCount});

  OrderFromBase.fromJson(Map<String, dynamic> json) {
    docUIDClient = json['docUIDClient'];
    docNameClient = json['docNameClient'];
    docDate = DateTime.parse(json['docDate']);
    docStatus = json['docStatus'];
    docUID = json['docUID'];
    docNumber = json['docNumber'];
    docUser = json['docUser'];
    docSum = double.parse(json['docSum']);
    docSumBonusPlus = double.parse(json['docSumBonusPlus']);
    docSumBonusMinus = double.parse(json['docSumBonusMinus']);
    docStore = json['docStore'];
    docItemsCount = int.parse(json['docItemsCount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docUIDClient'] = this.docUIDClient;
    data['docNameClient'] = this.docNameClient;
    data['docDate'] = this.docDate;
    data['docStatus'] = this.docStatus;
    data['docUID'] = this.docUID;
    data['docNumber'] = this.docNumber;
    data['docUser'] = this.docUser;
    data['docSum'] = this.docSum;
    data['docSumBonusPlus'] = this.docSumBonusPlus;
    data['docSumBonusMinus'] = this.docSumBonusMinus;
    data['docStore'] = this.docStore;
    data['docItemsCount'] = this.docItemsCount;
    return data;
  }

  static Map<String, dynamic> toMap(OrderFromBase order) => {
    'docUIDClient': order.docUIDClient,
    'docNameClient': order.docNameClient,
    'docDate': order.docDate,
    'docStatus': order.docStatus,
    'docUID': order.docUID,
    'docNumber': order.docNumber,
    'docUser': order.docUser,
    'docSum': order.docSum,
    'docSumBonusPlus': order.docSumBonusPlus,
    'docSumBonusMinus': order.docSumBonusMinus,
    'docStore': order.docStore,
    'docItemsCount': order.docItemsCount,
  };

  static String encode(List<OrderFromBase> orders) => json.encode(
    orders.map<Map<String, dynamic>>((item) => OrderFromBase.toMap(item)).toList(),
  );
}

class OrderItemFromBase {
  String numberRow;
  String name;
  String unit;
  double count;
  double price;
  double sum;
  double sumBonus;

  OrderItemFromBase(
      { this.numberRow,
        this.name,
        this.unit,
        this.count,
        this.sum,
        this.sumBonus});

  OrderItemFromBase.fromJson(Map<String, dynamic> json) {
    numberRow = json['numberRow'];
    name = json['name'];
    unit = json['unit'];
    count = double.parse(json['count']);
    price = double.parse(json['price']);
    sum = double.parse(json['sum']);
    sumBonus = double.parse(json['sumBonus']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberRow'] = this.numberRow;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['count'] = this.count;
    data['price'] = this.price;
    data['sum'] = this.sum;
    data['sumBonus'] = this.sumBonus;
    return data;
  }
}

class Item {
  String uuid;
  String code;
  String article;
  String name;
  String unit;
  int count;
  double price;
  double sum;
  double sumBonus;
  String image;

  Item(
      { this.uuid,
        this.code,
        this.article,
        this.name,
        this.unit,
        this.count,
        this.price,
        this.sum,
        this.sumBonus,
        this.image});

  Item.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    code = json['code'];
    article = json['article'];
    name = json['name'];
    unit = json['unit'];
    count = int.parse(json['count']);
    price = double.parse(json['price']);
    sum = double.parse(json['sum']);
    sumBonus = double.parse(json['sumBonus']);
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['code'] = this.code;
    data['article'] = this.article;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['count'] = this.count;
    data['price'] = this.price;
    data['sum'] = this.sum;
    data['sumBonus'] = this.sumBonus;
    data['image'] = this.image;
    return data;
  }
}
