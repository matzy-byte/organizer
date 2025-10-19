class CompensationInfo {
  final String topicName;
  final int value;

  CompensationInfo({required this.topicName, required this.value});

  Map<String, dynamic> toJson() => {'topicName': topicName, 'value': value};
  factory CompensationInfo.fromJson(Map<String, dynamic> json) =>
      CompensationInfo(
        topicName: json['topicName'] as String,
        value: json['value'] as int,
      );
}
