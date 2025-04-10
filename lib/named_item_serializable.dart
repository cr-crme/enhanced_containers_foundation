import 'package:enhanced_containers_foundation/enhanced_containers_foundation.dart';

abstract class NamedItemSerializable extends ItemSerializable {
  final String name;

  NamedItemSerializable.fromSerialized(super.map)
      : name = map['n'],
        super.fromSerialized();

  @override
  Map<String, dynamic> serializedMap() => {'id': id, 'n': name};

  String get idWithName => '${int.tryParse(id)} - $name';
}
