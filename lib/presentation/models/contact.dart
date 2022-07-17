class Contact {
  final int? id;
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber, this.id});

  Contact copyWith({
    int? id,
    String? name,
    String? phoneNumber,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
