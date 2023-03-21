import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'tank_record.g.dart';

abstract class TankRecord implements Built<TankRecord, TankRecordBuilder> {
  static Serializer<TankRecord> get serializer => _$tankRecordSerializer;

  @BuiltValueField(wireName: 'TankName')
  String? get tankName;

  @BuiltValueField(wireName: 'TankKey')
  String? get tankKey;

  @BuiltValueField(wireName: 'Length')
  String? get length;

  @BuiltValueField(wireName: 'Breadth')
  String? get breadth;

  @BuiltValueField(wireName: 'Height')
  String? get height;

  @BuiltValueField(wireName: 'Radius')
  String? get radius;

  bool? get isCuboid;

  @BuiltValueField(wireName: 'Capacity')
  double? get capacity;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(TankRecordBuilder builder) => builder
    ..tankName = ''
    ..tankKey = ''
    ..length = ''
    ..breadth = ''
    ..height = ''
    ..radius = ''
    ..isCuboid = false
    ..capacity = 0.0;

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('tank')
          : FirebaseFirestore.instance.collectionGroup('tank');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('tank').doc();

  static Stream<TankRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<TankRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  TankRecord._();
  factory TankRecord([void Function(TankRecordBuilder) updates]) = _$TankRecord;

  static TankRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createTankRecordData({
  String? tankName,
  String? tankKey,
  String? length,
  String? breadth,
  String? height,
  String? radius,
  bool? isCuboid,
  double? capacity,
}) {
  final firestoreData = serializers.toFirestore(
    TankRecord.serializer,
    TankRecord(
      (t) => t
        ..tankName = tankName
        ..tankKey = tankKey
        ..length = length
        ..breadth = breadth
        ..height = height
        ..radius = radius
        ..isCuboid = isCuboid
        ..capacity = capacity,
    ),
  );

  return firestoreData;
}
