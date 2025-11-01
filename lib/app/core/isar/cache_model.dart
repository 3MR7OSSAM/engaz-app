import 'package:isar/isar.dart';


abstract base class CacheModel<D> {
  CacheModel({this.id});
  Id? id;

  D toDomain();
}
