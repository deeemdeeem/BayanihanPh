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
  final List<dynamic> acceptedGoods;

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
    var availabilityFromJson = json['body']['availability'];
    List<String> availabilityList = new List<String>.from(availabilityFromJson);
    var acceptedGoodsFromJson = json['body']['acceptedGoods'];

    return ReliefCenterModel(
      id: json['id'],
      uid: json['body']['uid'],
      reliefCenterName: json['body']['reliefCenterName'],
      calamityName: json['body']['calamityName'],
      isDelivered: json['body']['isDelivered'],
      hostLname: json['body']['hostLname'],
      hostFname: json['body']['hostFname'],
      hostContact: json['body']['hostContact'],
      deliveryTarget: json['body']['deliveryTarget'],
      deliveryLocationLat: json['body']['deliveryLocation']['lat'],
      deliveryLocationLong: json['body']['deliveryLocation']['long'],
      hostLocationLat: json['body']['hostLocation']['lat'],
      hostLocationLong: json['body']['hostLocation']['long'],
      startDate: json['body']['dateRange']['startDate'] ?? 'N/A',
      endDate: json['body']['dateRange']['endDate'] ?? 'N/A',
      availability: availabilityList,
      availabilityStartTime:
          json['body']['availabilityTime']['startTime'] ?? 'N/A',
      availabilityEndTime: json['body']['availabilityTime']['endTime'] ?? 'N/A',
      acceptedGoods: acceptedGoodsFromJson,
    );
  }
}
