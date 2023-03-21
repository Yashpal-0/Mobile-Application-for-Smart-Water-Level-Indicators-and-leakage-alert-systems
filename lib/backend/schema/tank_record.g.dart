// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tank_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TankRecord> _$tankRecordSerializer = new _$TankRecordSerializer();

class _$TankRecordSerializer implements StructuredSerializer<TankRecord> {
  @override
  final Iterable<Type> types = const [TankRecord, _$TankRecord];
  @override
  final String wireName = 'TankRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, TankRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.tankName;
    if (value != null) {
      result
        ..add('TankName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.tankKey;
    if (value != null) {
      result
        ..add('TankKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.length;
    if (value != null) {
      result
        ..add('Length')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.breadth;
    if (value != null) {
      result
        ..add('Breadth')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.height;
    if (value != null) {
      result
        ..add('Height')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.radius;
    if (value != null) {
      result
        ..add('Radius')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isCuboid;
    if (value != null) {
      result
        ..add('isCuboid')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.capacity;
    if (value != null) {
      result
        ..add('Capacity')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  TankRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TankRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'TankName':
          result.tankName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'TankKey':
          result.tankKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Length':
          result.length = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Breadth':
          result.breadth = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Radius':
          result.radius = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isCuboid':
          result.isCuboid = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'Capacity':
          result.capacity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$TankRecord extends TankRecord {
  @override
  final String? tankName;
  @override
  final String? tankKey;
  @override
  final String? length;
  @override
  final String? breadth;
  @override
  final String? height;
  @override
  final String? radius;
  @override
  final bool? isCuboid;
  @override
  final double? capacity;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$TankRecord([void Function(TankRecordBuilder)? updates]) =>
      (new TankRecordBuilder()..update(updates))._build();

  _$TankRecord._(
      {this.tankName,
      this.tankKey,
      this.length,
      this.breadth,
      this.height,
      this.radius,
      this.isCuboid,
      this.capacity,
      this.ffRef})
      : super._();

  @override
  TankRecord rebuild(void Function(TankRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TankRecordBuilder toBuilder() => new TankRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TankRecord &&
        tankName == other.tankName &&
        tankKey == other.tankKey &&
        length == other.length &&
        breadth == other.breadth &&
        height == other.height &&
        radius == other.radius &&
        isCuboid == other.isCuboid &&
        capacity == other.capacity &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, tankName.hashCode),
                                    tankKey.hashCode),
                                length.hashCode),
                            breadth.hashCode),
                        height.hashCode),
                    radius.hashCode),
                isCuboid.hashCode),
            capacity.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TankRecord')
          ..add('tankName', tankName)
          ..add('tankKey', tankKey)
          ..add('length', length)
          ..add('breadth', breadth)
          ..add('height', height)
          ..add('radius', radius)
          ..add('isCuboid', isCuboid)
          ..add('capacity', capacity)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class TankRecordBuilder implements Builder<TankRecord, TankRecordBuilder> {
  _$TankRecord? _$v;

  String? _tankName;
  String? get tankName => _$this._tankName;
  set tankName(String? tankName) => _$this._tankName = tankName;

  String? _tankKey;
  String? get tankKey => _$this._tankKey;
  set tankKey(String? tankKey) => _$this._tankKey = tankKey;

  String? _length;
  String? get length => _$this._length;
  set length(String? length) => _$this._length = length;

  String? _breadth;
  String? get breadth => _$this._breadth;
  set breadth(String? breadth) => _$this._breadth = breadth;

  String? _height;
  String? get height => _$this._height;
  set height(String? height) => _$this._height = height;

  String? _radius;
  String? get radius => _$this._radius;
  set radius(String? radius) => _$this._radius = radius;

  bool? _isCuboid;
  bool? get isCuboid => _$this._isCuboid;
  set isCuboid(bool? isCuboid) => _$this._isCuboid = isCuboid;

  double? _capacity;
  double? get capacity => _$this._capacity;
  set capacity(double? capacity) => _$this._capacity = capacity;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  TankRecordBuilder() {
    TankRecord._initializeBuilder(this);
  }

  TankRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tankName = $v.tankName;
      _tankKey = $v.tankKey;
      _length = $v.length;
      _breadth = $v.breadth;
      _height = $v.height;
      _radius = $v.radius;
      _isCuboid = $v.isCuboid;
      _capacity = $v.capacity;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TankRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TankRecord;
  }

  @override
  void update(void Function(TankRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TankRecord build() => _build();

  _$TankRecord _build() {
    final _$result = _$v ??
        new _$TankRecord._(
            tankName: tankName,
            tankKey: tankKey,
            length: length,
            breadth: breadth,
            height: height,
            radius: radius,
            isCuboid: isCuboid,
            capacity: capacity,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
