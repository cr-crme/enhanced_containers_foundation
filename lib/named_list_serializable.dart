import 'package:enhanced_containers_foundation/list_serializable.dart';
import 'package:enhanced_containers_foundation/named_item_serializable.dart';

abstract class NamedItemSerializableList<T extends NamedItemSerializable>
    extends ListSerializable<T> {}
