class VisibleValue<T> {
  T value;
  bool visible;

  VisibleValue({this.value, this.visible});

  factory VisibleValue.fromJson(Map<dynamic, dynamic> json) {
    if (json != null) {
      return VisibleValue(
        value: json['value'] as T,
        visible: json['visible'] as bool,
      );
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() => _VisibleValueToJson(this);

  Map<String, dynamic> _VisibleValueToJson(VisibleValue<T> instance) =>
      <String, dynamic>{
        'value': instance.value,
        'visible': instance.visible,
      };
}
