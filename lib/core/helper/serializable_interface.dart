///Used as common way to serialize all page arguments using one interface
abstract class Serializable {
  Map<String, dynamic> toJson();
}

typedef Json = Map<String, dynamic>;
