import 'dart:convert';

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  String? job;
  String? department;

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
    adult             : json["adult"],
    gender            : json["gender"],
    id                : json["id"],
    knownForDepartment: json["known_for_department"],
    name              : json["name"],
    originalName      : json["original_name"],
    popularity        : json["popularity"].toDouble(),
    profilePath       : json["profile_path"] == null ? null : json["profile_path"],
    castId            : json["cast_id"] == null ? null : json["cast_id"],
    character         : json["character"] == null ? null : json["character"],
    creditId          : json["credit_id"],
    order             : json["order"] == null ? null : json["order"],
    department        : json["department"] == null ? null : json["department"],
    job               : json["job"] == null ? null : json["job"],
  );

  get fullProfilePath {
    if (profilePath == null) return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/26c38110-5b4f-0138-d43f-0242ac11000e/icons/icon-no-image.svg';
    return 'https://image.tmdb.org/t/p/w500$profilePath';
  }
}
