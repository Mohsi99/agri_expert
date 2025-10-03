class UserModel {
  final String? docId;
  final String? name;
  final String? email;
  final String? profileImageUrl;
  final String? degreeImageUrl;
  final String? address;
  final String? contact;
  final String? experience;
  final String? qualification;
  final DateTime? createdAt;

  UserModel({
    this.docId,
    this.name,
    this.email,
    this.profileImageUrl,
    this.degreeImageUrl,
    this.address,
    this.contact,
    this.experience,
    this.qualification,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    docId: json["docId"],
    name: json["name"],
    email: json["email"],
    profileImageUrl: json["profileImageUrl"],
    degreeImageUrl: json["degreeImageUrl"],
    address: json["address"],
    contact: json["contact"],
    experience: json["experience"],
    qualification: json["qualification"],
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "docId": docId,
    "name": name,
    "email": email,
    "profileImageUrl": profileImageUrl,
    "degreeImageUrl": degreeImageUrl,
    "address": address,
    "contact": contact,
    "experience": experience,
    "qualification": qualification,
    "createdAt": createdAt?.toIso8601String(),
  };
}