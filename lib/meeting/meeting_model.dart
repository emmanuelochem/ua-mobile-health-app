import 'dart:convert';

import 'package:flutter/material.dart';

class MeetingDetail {
  String id;
  String hostId;
  String hostName;
  MeetingDetail({
    @required this.id,
    @required this.hostId,
    @required this.hostName,
  });

  MeetingDetail copyWith({
    String id,
    String hostId,
    String hostName,
  }) {
    return MeetingDetail(
      id: id ?? this.id,
      hostId: hostId ?? this.hostId,
      hostName: hostName ?? this.hostName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'hostId': hostId,
      'hostName': hostName,
    };
  }

  factory MeetingDetail.fromMap(Map<String, dynamic> map) {
    return MeetingDetail(
      id: map['id'] as String,
      hostId: map['hostId'] as String,
      hostName: map['hostName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MeetingDetail.fromJson(String source) =>
      MeetingDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MeetingDetail(id: $id, hostId: $hostId, hostName: $hostName)';

  @override
  bool operator ==(covariant MeetingDetail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.hostId == hostId &&
        other.hostName == hostName;
  }

  @override
  int get hashCode => id.hashCode ^ hostId.hashCode ^ hostName.hashCode;
}
