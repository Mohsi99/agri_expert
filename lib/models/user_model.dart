class UserModel {
  final String docId;
  final String email;
  final String name;
  final String profileImageUrl;
  final String degreeImageUrl;
  final String address;
  final String contact;
  final String experience;
  final String qualification;
  final DateTime createdAt;

  UserModel({
    required this.docId,
    required this.email,
    this.name = "",
    this.profileImageUrl = "",
    this.degreeImageUrl = "",
    this.address = "",
    this.contact = "",
    this.experience = "",
    this.qualification = "",
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    "docId": docId,
    "email": email,
    "name": name,
    "profileImageUrl": profileImageUrl,
    "degreeImageUrl": degreeImageUrl,
    "address": address,
    "contact": contact,
    "experience": experience,
    "qualification": qualification,
    "createdAt": createdAt.toIso8601String(),
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    docId: json["docId"],
    email: json["email"],
    name: json["name"] ?? "",
    profileImageUrl: json["profileImageUrl"] ?? "",
    degreeImageUrl: json["degreeImageUrl"] ?? "",
    address: json["address"] ?? "",
    contact: json["contact"] ?? "",
    experience: json["experience"] ?? "",
    qualification: json["qualification"] ?? "",
    createdAt: DateTime.parse(json["createdAt"]),
  );

  UserModel copyWith({
    String? docId,
    String? email,
    String? name,
    String? profileImageUrl,
    String? degreeImageUrl,
    String? address,
    String? contact,
    String? experience,
    String? qualification,
    DateTime? createdAt,
  }) {
    return UserModel(
      docId: docId ?? this.docId,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      degreeImageUrl: degreeImageUrl ?? this.degreeImageUrl,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      experience: experience ?? this.experience,
      qualification: qualification ?? this.qualification,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}