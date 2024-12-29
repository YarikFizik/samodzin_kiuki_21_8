import 'division.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';

enum Gender { male, female }

class Learner {
  final String id;
  final String givenName;
  final String familyName;
  final Division division;
  final int score;
  final Gender gender;

  Learner({
    required this.id,
    required this.givenName,
    required this.familyName,
    required this.division,
    required this.score,
    required this.gender,
  });

  Learner.withId(
      {required this.id,
      required this.givenName,
      required this.familyName,
      required this.division,
      required this.gender,
      required this.score});

  Learner copyWith(givenName, familyName, faculty, gender, score) {
    return Learner.withId(
        id: id,
        givenName: givenName,
        familyName: familyName,
        division: faculty,
        gender: gender,
        score: score);
  }

  static Division parseDivision(String divisionString) {
    return Division.values.firstWhere(
      (d) => d.toString().split('.').last == divisionString,
      orElse: () => throw ArgumentError('Invalid division: $divisionString'),
    );
  }


  static String divisionToString(Division division) {
    return division.toString().split('.').last;
  }

  static Future<List<Learner>> remoteGetList() async {
    final url = Uri.https(baseUrl, "$studentsPath.json");

    final response = await http.get(
      url,
    );

    if (response.statusCode >= 400) {
      throw Exception("Unlucky. List has not been received");
    }

    if (response.body == "null") {
      return [];
    }

    final Map<String, dynamic> data = json.decode(response.body);
    final List<Learner> loadedItems = [];
    for (final item in data.entries) {
      loadedItems.add(
        Learner(
          id: item.key,
          givenName: item.value['given_name']!,
          familyName: item.value['family_name']!,
          division: parseDivision(item.value['division']!),
          gender: Gender.values.firstWhere((v) => v.toString() == item.value['gender']!),
          score: item.value['score']!,
        ),
      );
    }
    return loadedItems;
  }

  static Future<Learner> remoteCreate(
    givenName,
    familyName,
    division,
    gender,
    score,
  ) async {

    final url = Uri.https(baseUrl, "$studentsPath.json");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'given_name': givenName!,
          'family_name': familyName,
          'division': divisionToString(division),
          'gender': gender.toString(),
          'score': score,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception("Couldn't create a student");
    }

    final Map<String, dynamic> resData = json.decode(response.body);

    return Learner(
        id: resData['name'],
        givenName: givenName,
        familyName: familyName,
        division: division,
        gender: gender,
        score: score);
  }

  static Future remoteDelete(studentId) async {
    final url = Uri.https(baseUrl, "$studentsPath/$studentId.json");

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      throw Exception("Couldn't delete a student");
    }
  }

  static Future<Learner> remoteUpdate(
    studentId,
    givenName,
    familyName,
    division,
    gender,
    score,
  ) async {
    final url = Uri.https(baseUrl, "$studentsPath/$studentId.json");

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'given_name': givenName!,
          'family_name': familyName,
          'division': divisionToString(division),
          'gender': gender.toString(),
          'score': score,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception("Couldn't update a student");
    }

    return Learner(
        id: studentId,
        givenName: givenName,
        familyName: familyName,
        division: division,
        gender: gender,
        score: score);
  }
  
}