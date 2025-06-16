
// models/group_model.dart
class Group {
  final String id;
  final String name;
  final String code;
  final DateTime createdAt;
  final String managerId;
  final List<String> memberIds;
  final Map<String, dynamic> settings;
  
  Group({
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.managerId,
    required this.memberIds,
    required this.settings,
  });
  
  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'],
      name: map['name'],
      code: map['code'],
      createdAt: DateTime.parse(map['createdAt']),
      managerId: map['managerId'],
      memberIds: List<String>.from(map['memberIds']),
      settings: map['settings'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'createdAt': createdAt.toIso8601String(),
      'managerId': managerId,
      'memberIds': memberIds,
      'settings': settings,
    };
  }
}