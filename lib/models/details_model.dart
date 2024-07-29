class DetailsModel {
  String? message;
  List<Data>? data;

  DetailsModel({this.message, this.data});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic predictionPercentage;
  String? diseaseName;
  List<String>? diseaseSymptoms;
  List<String>? diseaseReason;
  List<String>? medicineForDisease;
  List<String>? homeTreatment;
  List<BestHospital>? bestHospital;

  Data(
      {this.predictionPercentage,
      this.diseaseName,
      this.diseaseSymptoms,
      this.diseaseReason,
      this.medicineForDisease,
      this.homeTreatment,
      this.bestHospital});

  Data.fromJson(Map<String, dynamic> json) {
    predictionPercentage = json['prediction_percentage'];
    diseaseName = json['disease_name'];
    diseaseSymptoms = json['disease_symptoms'].cast<String>();
    diseaseReason = json['disease_reason'].cast<String>();
    medicineForDisease = json['medicine_for_disease'].cast<String>();
    homeTreatment = json['home_treatment'].cast<String>();
    if (json['best_hospital'] != null) {
      bestHospital = <BestHospital>[];
      json['best_hospital'].forEach((v) {
        bestHospital!.add(BestHospital.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prediction_percentage'] = predictionPercentage;
    data['disease_name'] = diseaseName;
    data['disease_symptoms'] = diseaseSymptoms;
    data['disease_reason'] = diseaseReason;
    data['medicine_for_disease'] = medicineForDisease;
    data['home_treatment'] = homeTreatment;
    if (bestHospital != null) {
      data['best_hospital'] = bestHospital!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BestHospital {
  String? name;
  Address? address;
  Contact? contact;

  BestHospital({this.name, this.address, this.contact});

  BestHospital.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    contact =
        json['contact'] != null ? Contact.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    return data;
  }
}

class Address {
  String? street;
  String? pin;
  String? city;
  String? state;
  String? country;

  Address({this.street, this.pin, this.city, this.state, this.country});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    pin = json['pin'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['pin'] = pin;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    return data;
  }
}

class Contact {
  String? mobile;
  String? email;

  Contact({this.mobile, this.email});

  Contact.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}
