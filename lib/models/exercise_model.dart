class ExerciseModel {
  String? message;
  Data? data;

  ExerciseModel({this.message, this.data});

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? exerciseName;
  String? aasanName;
  String? duration;
  String? difficultyLevel;
  List<String>? steps;
  List<String>? benefit;

  Data(
      {this.exerciseName,
        this.aasanName,
      this.duration,
      this.difficultyLevel,
      this.steps,
      this.benefit});

  Data.fromJson(Map<String, dynamic> json) {
    exerciseName = json['exercise_name'];
    aasanName = json['aasan_name'];
    duration = json['duration'];
    difficultyLevel = json['difficulty_level'];
    steps = json['steps'].cast<String>();
    benefit = json['benefit'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exercise_name'] = exerciseName;
    data['aasan_name'] = aasanName;
    data['duration'] = duration;
    data['difficulty_level'] = difficultyLevel;
    data['steps'] = steps;
    data['benefit'] = benefit;
    return data;
  }
}
