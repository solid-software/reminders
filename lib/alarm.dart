class Alarm {
  double relativeOffset;

  Alarm({required this.relativeOffset});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(relativeOffset: (json['relativeOffset'] as num).toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'relativeOffset': relativeOffset};
  }
}
