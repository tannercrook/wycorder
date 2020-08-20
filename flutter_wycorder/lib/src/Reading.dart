// Reading.dart 
// Class for Reading

class Reading {
  int readingID;
  int system_user_id;
  DateTime time_taken;
  String status;
  int fever_chills;
  int cough;
  int sore_throat;
  int short_breath;
  int fatigue;
  int aches;
  int taste_loss;
  int congestion;
  int nausea_vomit_diarrhea;
  int infectious_contact;
  int temperature;


  // Constructor
  Reading({
    this.readingID,
    this.system_user_id,
    this.time_taken,
    this.status,
    this.fever_chills,
    this.cough, 
    this.sore_throat,
    this.short_breath,
    this.fatigue,
    this.aches,
    this.taste_loss,
    this.congestion,
    this.nausea_vomit_diarrhea,
    this.infectious_contact,
    this.temperature
  });

  // JSON Factory
  factory Reading.fromJson(Map<String, dynamic> json) {
    return Reading(
      readingID: json['readingID'],
      system_user_id: json['system_user_id'],
      time_taken: json['time_taken'],
      status: json['status'],
      fever_chills: json['fever_chills'],
      cough: json['cough'], 
      sore_throat: json['sore_throat'],
      short_breath: json['short_breath'],
      fatigue: json['fatigue'],
      aches: json['aches'],
      taste_loss: json['taste_loss'],
      congestion: json['congestion'],
      nausea_vomit_diarrhea: json['nausea_vomit_diarrhea'],
      infectious_contact: json['infectious_contact'],
      temperature: json['temperature'],
    );
  }

  Map<String, dynamic> toJson() => {
    'system_user_id':this.system_user_id,
    'time_taken':this.time_taken,
    'status':this.status,
    'fever_chills':this.fever_chills,
    'cough':this.cough,
    'sore_throat':this.sore_throat,
    'short_breath':this.short_breath,
    'fatigue':this.fatigue,
    'aches':this.aches,
    'taste_loss':this.taste_loss,
    'congestion':this.congestion,
    'nausea_vomit_diarrhea':this.nausea_vomit_diarrhea,
    'infectious_contact':this.infectious_contact,
    'temperature':this.temperature
  };


}





