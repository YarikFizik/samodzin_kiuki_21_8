import 'division.dart';

enum Gender { male, female }

class Learner {
  final String givenName;
  final String familyName;
  final Division division;
  final int score;
  final Gender gender;

  Learner({
    required this.givenName,
    required this.familyName,
    required this.division,
    required this.score,
    required this.gender,
  });

  String get fullName => '$givenName $familyName';
}