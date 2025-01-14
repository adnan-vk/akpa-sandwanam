import 'dart:convert';

class LoginModel {
  String? id;
  String? districtId;
  String? meghalaId;
  String? unitId;
  String? districtName;
  String? meghalaName;
  String? unitName;
  String? name;
  String? username;
  String? password;
  String? nomineeName;
  String? akpaId;
  String? mobile;
  String? upiId;
  String? image;
  DateTime? dateOfBirth;
  String? age;
  String? joinYear;
  String? lastRenewedDate;
  String? accountAmount;
  String? balanceAmount;
  String? lastDeathId;
  String? previousDeathId;
  DateTime? dateOfDeath;
  String? chequeNumber;
  DateTime? creditedDate;
  String? creditedAmount;
  String? helpImage;
  String? creditedStatus;
  String? status;
  String? deathStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? rememberToken;
  String? cmFirebaseToken;
  String? deviceToken;
  String? temporaryToken;
  List<dynamic>? translations;

  LoginModel({
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

  LoginModel copyWith({
    String? id,
    String? districtId,
    String? meghalaId,
    String? unitId,
    String? districtName,
    String? meghalaName,
    String? unitName,
    String? name,
    String? username,
    String? password,
    String? nomineeName,
    String? akpaId,
    String? mobile,
    String? upiId,
    String? image,
    DateTime? dateOfBirth,
    String? age,
    String? joinYear,
    String? lastRenewedDate,
    String? accountAmount,
    String? balanceAmount,
    String? lastDeathId,
    String? previousDeathId,
    DateTime? dateOfDeath,
    String? chequeNumber,
    DateTime? creditedDate,
    String? creditedAmount,
    String? helpImage,
    String? creditedStatus,
    String? status,
    String? deathStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rememberToken,
    String? cmFirebaseToken,
    String? deviceToken,
    String? temporaryToken,
    List<dynamic>? translations,
  }) =>
      LoginModel(
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

  factory LoginModel.fromJson(String str) => LoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
    id: json["id"].toString(),
    districtId: json["district_id"].toString(),
    meghalaId: json["meghala_id"].toString(),
    unitId: json["unit_id"].toString(),
    districtName: json["district_name"].toString(),
    meghalaName: json["meghala_name"].toString(),
    unitName: json["unit_name"].toString(),
    name: json["name"].toString(),
    username: json["username"].toString(),
    password: json["password"].toString(),
    nomineeName: json["nominee_name"].toString(),
    akpaId: json["akpa_id"].toString(),
    mobile: json["mobile"].toString(),
    upiId: json["upi_id"].toString(),
    image: json["image"].toString(),
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    age: json["age"].toString(),
    joinYear: json["join_year"].toString(),
    lastRenewedDate: json["last_renewed_date"].toString(),
    accountAmount: json["account_amount"].toString(),
    balanceAmount: json["balance_amount"].toString(),
    lastDeathId: json["last_death_id"].toString(),
    previousDeathId: json["previous_death_id"].toString(),
    dateOfDeath: json["date_of_death"] == null ? null : DateTime.parse(json["date_of_death"]),
    chequeNumber: json["cheque_number"].toString(),
    creditedDate: json["credited_date"] == null ? null : DateTime.parse(json["credited_date"]),
    creditedAmount: json["credited_amount"].toString(),
    helpImage: json["help_image"].toString(),
    creditedStatus: json["credited_status"].toString(),
    status: json["status"].toString(),
    deathStatus: json["death_status"].toString(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    rememberToken: json["remember_token"].toString(),
    cmFirebaseToken: json["cm_firebase_token"].toString(),
    deviceToken: json["device_token"].toString(),
    temporaryToken: json["temporary_token"].toString(),
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
    "date_of_death": dateOfDeath?.toIso8601String(),
    "cheque_number": chequeNumber,
    "credited_date": creditedDate?.toIso8601String(),
    "credited_amount": creditedAmount,
    "help_image": helpImage,
    "credited_status": creditedStatus,
    "status": status,
    "death_status": deathStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "remember_token": rememberToken,
    "cm_firebase_token": cmFirebaseToken,
    "device_token": deviceToken,
    "temporary_token": temporaryToken,
    "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x)),
  };
}
