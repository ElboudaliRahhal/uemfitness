

class User_info {

  String email;
  String matricule;
  String fullName;
  String profilUrl;



  User_info(this.email,this.fullName,this.matricule,this.profilUrl);


  Map<String, dynamic> toFirestore() {
    return {
      "full name": fullName,
      "email": email,
      "matricule": matricule,
      "profilUrl": profilUrl

    };
  }









}