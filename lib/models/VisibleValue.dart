class VisibleValue<T> {
  T value;
  bool visible;

  VisibleValue({this.value, this.visible});

  factory VisibleValue.fromJson(Map<dynamic, dynamic> json) {
    return VisibleValue(
      value: json['value'] as T,
      visible: json['visible'] as bool,
    );
  }

  Map<String, dynamic> toJson() => _VisibleValueToJson(this);

  Map<String, dynamic> _VisibleValueToJson(VisibleValue<T> instance) =>
      <String, dynamic>{
        'value': instance.value,
        'visible': instance.visible,
      };
}
