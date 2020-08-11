//Used for PetId App Bar Provider
class PetId {
  String pid;

  PetId(this.pid);

  @override
  bool operator ==(Object other) {
    return other is PetId && hashCode == other.hashCode;
  }

  @override
  int get hashCode => pid.hashCode;
}