class CustomLeague {
  final int id;
  final String name;
  final int rounds;
  final int members;
  final bool private;
  final String privateId;
  final int userPoints;
  final String creator;

  CustomLeague({
    required this.id,
    required this.name,
    required this.rounds,
    required this.members,
    required this.private,
    required this.privateId,
    required this.userPoints,
    required this.creator,
  });
}
