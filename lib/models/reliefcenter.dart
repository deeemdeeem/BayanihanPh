class ReliefCenterModel {
  final String id;
  final String uid;
  final String reliefCenterName;
  final String calamityName;
  final bool isDelivered;
  // host
  final String hostLname;
  final String hostFname;
  final String hostContact;
  // delivery
  final String deliveryTarget;
  final String deliveryLocationLat;
  final String deliveryLocationLong;
  // host location
  final String hostLocationLat;
  final String hostLocationLong;
  // dates
  final String startDate;
  final String endDate;
  //availability
  final List<String> availability;
  final String availabilityStartTime;
  final String availabilityEndTime;
  // accepted goods
  final Map<String, dynamic> acceptedGoods;

  ReliefCenterModel({
    this.id,
    this.uid,
    this.reliefCenterName,
    this.calamityName,
    this.isDelivered,
    this.hostLname,
    this.hostFname,
    this.hostContact,
    this.deliveryTarget,
    this.deliveryLocationLat,
    this.deliveryLocationLong,
    this.hostLocationLat,
    this.hostLocationLong,
    this.startDate,
    this.endDate,
    this.availability,
    this.availabilityStartTime,
    this.availabilityEndTime,
    this.acceptedGoods,
  });

  factory ReliefCenterModel.fromJson(Map<String, dynamic> json) {
    var availabilityFromJson = json['availability'];
    List<String> availabilityList = new List<String>.from(availabilityFromJson);
    var acceptedGoodsFromJson = json['acceptedGoods'];

    return ReliefCenterModel(
      id: json['id'],
      uid: json['uid'],
      reliefCenterName: json['reliefCenterName'],
      calamityName: json['calamityName'],
      isDelivered: json['isDelivered'],
      hostLname: json['hostLname'],
      hostFname: json['hostFname'],
      hostContact: json['hostContact'],
      deliveryTarget: json['deliveryTarget'],
      deliveryLocationLat: json['deliveryLocation']['lat'],
      deliveryLocationLong: json['deliveryLocation']['long'],
      hostLocationLat: json['hostLocation']['lat'],
      hostLocationLong: json['hostLocation']['long'],
      startDate: json['dateRange']['startDate'] ?? 'N/A',
      endDate: json['dateRange']['endDate'] ?? 'N/A',
      availability: availabilityList,
      availabilityStartTime: json['availabilityTime']['startTime'] ?? 'N/A',
      availabilityEndTime: json['availabilityTime']['endTime'] ?? 'N/A',
      acceptedGoods: acceptedGoodsFromJson,
    );
  }
}
