class UserModel {
  String? key;
  String? name;
  String? lastName;
  int? document;
  bool? isDeleted;

  UserModel(
      {this.key, this.name, this.lastName, this.document, this.isDeleted});

  toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'document': document,
      'isDeleted': isDeleted,
    };
  }

  toFullName() {
    return name! + ' ' + lastName!;
  }

  factory UserModel.fromSnapshot({data, id}) {
    return UserModel(
        key: id,
        name: data['name'],
        lastName: data['lastName'],
        document: data['document'],
        isDeleted: data['isDeleted'] ?? false);
  }
}
