import 'dart:convert';

class HelpModel {
  int? accountAmount;
  int? helpGiven;
  String? helpGivenYear;
  int? balanceAmount;
  bool? status;
  String? message;
  ListClass? list;

  HelpModel({
    this.accountAmount,
    this.helpGiven,
    this.helpGivenYear,
    this.balanceAmount,
    this.status,
    this.message,
    this.list,
  });

  HelpModel copyWith({
    int? accountAmount,
    int? helpGiven,
    String? helpGivenYear,
    int? balanceAmount,
    bool? status,
    String? message,
    ListClass? list,
  }) =>
      HelpModel(
        accountAmount: accountAmount ?? this.accountAmount,
        helpGiven: helpGiven ?? this.helpGiven,
        helpGivenYear: helpGivenYear ?? this.helpGivenYear,
        balanceAmount: balanceAmount ?? this.balanceAmount,
        status: status ?? this.status,
        message: message ?? this.message,
        list: list ?? this.list,
      );

  factory HelpModel.fromJson(String str) => HelpModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HelpModel.fromMap(Map<String, dynamic> json) => HelpModel(
    accountAmount: json["account_amount"],
    helpGiven: json["help_given"],
    helpGivenYear: json["help_given_year"]?.toString(),
    balanceAmount: json["balance_amount"],
    status: json["status"],
    message: json["message"],
    list: json["list"] == null ? null : ListClass.fromMap(json["list"]),
  );

  Map<String, dynamic> toMap() => {
    "account_amount": accountAmount,
    "help_given": helpGiven,
    "help_given_year": helpGivenYear,
    "balance_amount": balanceAmount,
    "status": status,
    "message": message,
    "list": list?.toMap(),
  };
}

class ListClass {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  String? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  ListClass({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  ListClass copyWith({
    int? currentPage,
    List<Datum>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    dynamic nextPageUrl,
    String? path,
    String? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      ListClass(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        links: links ?? this.links,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory ListClass.fromJson(String str) => ListClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListClass.fromMap(Map<String, dynamic> json) => ListClass(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int? id;
  int? districtId;
  int? meghalaId;
  int? unitId;
  String? districtName;
  String? meghalaName;
  String? unitName;
  String? name;
  String? username;
  String? password;
  String? nomineeName;
  int? akpaId;
  String? mobile;
  String? upiId;
  String? image;
  DateTime? dateOfBirth;
  String? age;
  String? joinYear;
  String? lastRenewedDate;
  int? accountAmount;
  int? balanceAmount;
  int? lastDeathId;
  int? previousDeathId;
  DateTime? dateOfDeath;
  String? chequeNumber;
  DateTime? creditedDate;
  int? creditedAmount;
  String? helpImage;
  int? creditedStatus;
  int? status;
  int? deathStatus;
  dynamic createdAt;
  DateTime? updatedAt;
  String? rememberToken;
  String? cmFirebaseToken;
  String? deviceToken;
  String? temporaryToken;
  List<dynamic>? translations;

  Datum({
    this.id,
    this.districtId,
    this.meghalaId,
    this.unitId,
    this.districtName,
    this.meghalaName,
    this.unitName,
    this.name,
    this.username,
    this.password,
    this.nomineeName,
    this.akpaId,
    this.mobile,
    this.upiId,
    this.image,
    this.dateOfBirth,
    this.age,
    this.joinYear,
    this.lastRenewedDate,
    this.accountAmount,
    this.balanceAmount,
    this.lastDeathId,
    this.previousDeathId,
    this.dateOfDeath,
    this.chequeNumber,
    this.creditedDate,
    this.creditedAmount,
    this.helpImage,
    this.creditedStatus,
    this.status,
    this.deathStatus,
    this.createdAt,
    this.updatedAt,
    this.rememberToken,
    this.cmFirebaseToken,
    this.deviceToken,
    this.temporaryToken,
    this.translations,
  });

  Datum copyWith({
    int? id,
    int? districtId,
    int? meghalaId,
    int? unitId,
    String? districtName,
    String? meghalaName,
    String? unitName,
    String? name,
    String? username,
    String? password,
    String? nomineeName,
    int? akpaId,
    String? mobile,
    String? upiId,
    String? image,
    DateTime? dateOfBirth,
    String? age,
    String? joinYear,
    String? lastRenewedDate,
    int? accountAmount,
    int? balanceAmount,
    int? lastDeathId,
    int? previousDeathId,
    DateTime? dateOfDeath,
    String? chequeNumber,
    DateTime? creditedDate,
    int? creditedAmount,
    String? helpImage,
    int? creditedStatus,
    int? status,
    int? deathStatus,
    dynamic createdAt,
    DateTime? updatedAt,
    String? rememberToken,
    String? cmFirebaseToken,
    String? deviceToken,
    String? temporaryToken,
    List<dynamic>? translations,
  }) =>
      Datum(
        id: id ?? this.id,
        districtId: districtId ?? this.districtId,
        meghalaId: meghalaId ?? this.meghalaId,
        unitId: unitId ?? this.unitId,
        districtName: districtName ?? this.districtName,
        meghalaName: meghalaName ?? this.meghalaName,
        unitName: unitName ?? this.unitName,
        name: name ?? this.name,
        username: username ?? this.username,
        password: password ?? this.password,
        nomineeName: nomineeName ?? this.nomineeName,
        akpaId: akpaId ?? this.akpaId,
        mobile: mobile ?? this.mobile,
        upiId: upiId ?? this.upiId,
        image: image ?? this.image,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        age: age ?? this.age,
        joinYear: joinYear ?? this.joinYear,
        lastRenewedDate: lastRenewedDate ?? this.lastRenewedDate,
        accountAmount: accountAmount ?? this.accountAmount,
        balanceAmount: balanceAmount ?? this.balanceAmount,
        lastDeathId: lastDeathId ?? this.lastDeathId,
        previousDeathId: previousDeathId ?? this.previousDeathId,
        dateOfDeath: dateOfDeath ?? this.dateOfDeath,
        chequeNumber: chequeNumber ?? this.chequeNumber,
        creditedDate: creditedDate ?? this.creditedDate,
        creditedAmount: creditedAmount ?? this.creditedAmount,
        helpImage: helpImage ?? this.helpImage,
        creditedStatus: creditedStatus ?? this.creditedStatus,
        status: status ?? this.status,
        deathStatus: deathStatus ?? this.deathStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        rememberToken: rememberToken ?? this.rememberToken,
        cmFirebaseToken: cmFirebaseToken ?? this.cmFirebaseToken,
        deviceToken: deviceToken ?? this.deviceToken,
        temporaryToken: temporaryToken ?? this.temporaryToken,
        translations: translations ?? this.translations,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    districtId: json["district_id"],
    meghalaId: json["meghala_id"],
    unitId: json["unit_id"],
    districtName: json["district_name"],
    meghalaName: json["meghala_name"],
    unitName: json["unit_name"],
    name: json["name"],
    username: json["username"],
    password: json["password"],
    nomineeName: json["nominee_name"],
    akpaId: json["akpa_id"],
    mobile: json["mobile"],
    upiId: json["upi_id"],
    image: json["image"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    age: json["age"],
    joinYear: json["join_year"],
    lastRenewedDate: json["last_renewed_date"],
    accountAmount: json["account_amount"],
    balanceAmount: json["balance_amount"],
    lastDeathId: json["last_death_id"],
    previousDeathId: json["previous_death_id"],
    dateOfDeath: json["date_of_death"] == null ? null : DateTime.parse(json["date_of_death"]),
    chequeNumber: json["cheque_number"],
    creditedDate: json["credited_date"] == null ? null : DateTime.parse(json["credited_date"]),
    creditedAmount: json["credited_amount"],
    helpImage: json["help_image"],
    creditedStatus: json["credited_status"],
    status: json["status"],
    deathStatus: json["death_status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    rememberToken: json["remember_token"],
    cmFirebaseToken: json["cm_firebase_token"],
    deviceToken: json["device_token"],
    temporaryToken: json["temporary_token"],
    translations: json["translations"] == null ? [] : List<dynamic>.from(json["translations"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "district_id": districtId,
    "meghala_id": meghalaId,
    "unit_id": unitId,
    "district_name": districtName,
    "meghala_name": meghalaName,
    "unit_name": unitName,
    "name": name,
    "username": username,
    "password": password,
    "nominee_name": nomineeName,
    "akpa_id": akpaId,
    "mobile": mobile,
    "upi_id": upiId,
    "image": image,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "age": age,
    "join_year": joinYear,
    "last_renewed_date": lastRenewedDate,
    "account_amount": accountAmount,
    "balance_amount": balanceAmount,
    "last_death_id": lastDeathId,
    "previous_death_id": previousDeathId,
    "date_of_death": "${dateOfDeath!.year.toString().padLeft(4, '0')}-${dateOfDeath!.month.toString().padLeft(2, '0')}-${dateOfDeath!.day.toString().padLeft(2, '0')}",
    "cheque_number": chequeNumber,
    "credited_date": "${creditedDate!.year.toString().padLeft(4, '0')}-${creditedDate!.month.toString().padLeft(2, '0')}-${creditedDate!.day.toString().padLeft(2, '0')}",
    "credited_amount": creditedAmount,
    "help_image": helpImage,
    "credited_status": creditedStatus,
    "status": status,
    "death_status": deathStatus,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
    "remember_token": rememberToken,
    "cm_firebase_token": cmFirebaseToken,
    "device_token": deviceToken,
    "temporary_token": temporaryToken,
    "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x)),
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
