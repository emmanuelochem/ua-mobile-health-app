import 'dart:convert';

class DropdownModel {
  String name;
  String value;
  String icon;
  //
  DropdownModel({
    this.name,
    this.value,
    this.icon,
  });

  DropdownModel copyWith({
    String name,
    String value,
    String icon,
  }) {
    return DropdownModel(
      name: name ?? this.name,
      value: value ?? this.value,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'value': value});
    result.addAll({'icon': icon});

    return result;
  }

  factory DropdownModel.fromMap(Map<String, dynamic> map) {
    return DropdownModel(
      name: map['name'] ?? '',
      value: map['value'] ?? '',
      icon: map['icon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DropdownModel.fromJson(String source) =>
      DropdownModel.fromMap(json.decode(source));

  @override
  String toString() => 'DropdownModel(name: $name, value: $value, icon: $icon)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropdownModel &&
        other.name == name &&
        other.value == value &&
        other.icon == icon;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode ^ icon.hashCode;
}
