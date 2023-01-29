
class Tofirebase {
  final String? firstname;
  final String? lastname;
  final String? matricule;
  final String? day;
  final String? hour;
  final String? userId;


  Tofirebase(
    this.firstname,
    this.lastname,
    this.matricule,
      this.day,
      this.hour,
      this.userId

  );



  Map<String, dynamic> toFirestore() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "matricule": matricule,
      "day": day,
      "hour":hour,
      "userId":userId

    };
  }
}