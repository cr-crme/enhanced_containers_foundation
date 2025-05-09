import 'package:enhanced_containers_foundation/exceptions.dart';
import 'package:enhanced_containers_foundation/item_serializable.dart';

/// An iterable [Map] that is made to handle [ItemSerializable].
///
/// It allows to serialize and deserialize the whole map easily with [serialize] and [MapSerializable.fromSerialized].
///
/// Written by: @pariterre and @Guibi1
abstract class MapSerializable<T extends ItemSerializable>
    extends Iterable<MapEntry<String, T>> {
  /// Creates an empty [MapSerializable].
  MapSerializable();

  /// Creates a [MapSerializable] from a map of serialized items.
  MapSerializable.fromSerialized(map) {
    deserialize(map);
  }

  /// Serializes all of its items into a single map.
  Map<String, dynamic> serialize() {
    final serializedItem = <String, dynamic>{};
    _items.forEach((key, element) {
      serializedItem[key] = element.serialize();
    });
    return serializedItem;
  }

  /// Returns a new [T] from the provided serialized data.
  T deserializeItem(data);

  /// Deserializes a map of items with the help of [deserializeItem].
  void deserialize(map) {
    _items.clear();
    map.forEach((key, element) {
      _items[key] = deserializeItem(element);
    });
  }

  /// Adds [item] to the map, extending the length by one.
  ///
  /// This method accepts a [String] as a [key] or an [ItemSerializable], where its id is going to be used.
  void add(T item, {String? key}) {
    _items[_getKey(key ?? item)] = item;
  }

  /// Updates the value of [item].
  ///
  /// This only works when the ids of the new and old value are identical.
  void replace(T item, {String? key}) {
    this[_getKey(key ?? item)] = item;
  }

  /// Sets the value of the item to [item] at the specified location.
  ///
  /// This method accepts a [String] as a [key] or an [ItemSerializable], where its id is going to be used.
  void operator []=(key, T item) {
    _items[_getKey(key)] = item;
  }

  /// Returns the item specified by [key].
  ///
  /// This method accepts a [String] as a [key] or an [ItemSerializable], where its id is going to be used.
  T? operator [](key) {
    return _items[_getKey(key)];
  }

  /// Removes a single item from the list.
  ///
  /// This method accepts a [String] as a [value] or an [ItemSerializable], where its id is going to be used.
  void remove(value) {
    _items.remove(_getKey(value));
  }

  /// Returns if the element specified byt [key] is in the map
  bool containsKey(key) {
    return _items.containsKey(_getKey(key));
  }

  /// Removes all objects from this map; the length of the map becomes zero.
  void clear() {
    _items.clear();
  }

  /// Interface to the keys of the map
  Iterable<String> get keys => _items.keys;

  /// Returns the key represented by [value] using different methods depending of its type.
  String _getKey(value) {
    if (value is String) {
      return value;
    } else if (value is ItemSerializable) {
      return value.id;
    } else {
      throw const TypeException(
        'Wrong type for getting an element of the map.',
      );
    }
  }

  final Map<String, T> _items = {};

  @override
  Iterator<MapEntry<String, T>> get iterator => _items.entries.iterator;
}
