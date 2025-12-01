class CompensationInfo {
  final int topicId;
  final String topicName;
  final int value;

  CompensationInfo({required this.topicId, required this.topicName, required this.value});

  Map<String, dynamic> toJson() => {'topicId': topicId, 'topicName': topicName, 'value': value};

  factory CompensationInfo.fromJson(Map<String, dynamic> json) =>
      CompensationInfo(topicId: json['topicId'], topicName: json['topicName'], value: json['value']);
}
