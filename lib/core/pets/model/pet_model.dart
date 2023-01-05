import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiutiu/features/tiutiu_user/model/tiutiu_user.dart';
import 'package:tiutiu/features/posts/model/post.dart';
import 'package:uuid/uuid.dart';

enum PetEnum {
  otherCaracteristics,
  chronicDiseaseInfo,
  lastSeenDetails,
  donatedOrFound,
  disappeared,
  ageMonth,
  ageYear,
  reward,
  gender,
  health,
  color,
  breed,
  size,
}

class Pet extends Post {
  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    return Pet(
      uid: snapshot.get(PostEnum.uid.name) != null ? snapshot.get(PostEnum.uid.name) : Uuid().v4(),
      createdAt: snapshot.get(PostEnum.createdAt.name) ?? DateTime.now().toIso8601String(),
      otherCaracteristics: snapshot.get(PetEnum.otherCaracteristics.name) ?? [],
      chronicDiseaseInfo: snapshot.get(PetEnum.chronicDiseaseInfo.name) ?? '',
      describedAddress: snapshot.get(PostEnum.describedAddress.name) ?? '',
      donatedOrFound: snapshot.get(PetEnum.donatedOrFound.name) ?? false,
      lastSeenDetails: snapshot.get(PetEnum.lastSeenDetails.name) ?? '',
      timesDennounced: snapshot.get(PostEnum.timesDennounced.name),
      owner: TiutiuUser.fromMap(snapshot.get(PostEnum.owner.name)),
      disappeared: snapshot.get(PetEnum.disappeared.name) ?? false,
      description: snapshot.get(PostEnum.description.name) ?? '',
      city: snapshot.get(PostEnum.city.name) ?? 'Acrelândia',
      state: snapshot.get(PostEnum.state.name) ?? 'Acre',
      ageMonth: snapshot.get(PetEnum.ageMonth.name) ?? 0,
      health: snapshot.get(PetEnum.health.name) ?? '-',
      gender: snapshot.get(PetEnum.gender.name) ?? '-',
      longitude: snapshot.get(PostEnum.longitude.name),
      ageYear: snapshot.get(PetEnum.ageYear.name) ?? 0,
      color: snapshot.get(PetEnum.color.name) ?? '-',
      breed: snapshot.get(PetEnum.breed.name) ?? '-',
      reward: snapshot.get(PetEnum.reward.name) ?? '',
      latitude: snapshot.get(PostEnum.latitude.name),
      views: snapshot.get(PostEnum.views.name) ?? 0,
      size: snapshot.get(PetEnum.size.name) ?? '-',
      type: snapshot.get(PostEnum.type.name) ?? '-',
      ownerId: snapshot.get(PostEnum.ownerId.name),
      photos: snapshot.get(PostEnum.photos.name),
      video: snapshot.get(PostEnum.video.name),
      name: snapshot.get(PostEnum.name.name),
    );
  }
  Pet({
    this.otherCaracteristics = const [],
    List dennounceMotives = const [],
    this.chronicDiseaseInfo = '',
    String describedAddress = '',
    this.donatedOrFound = false,
    this.lastSeenDetails = '',
    String city = 'Acrelândia',
    this.disappeared = false,
    String description = '',
    List photos = const [],
    int timesDennounced = 0,
    String state = 'Acre',
    String? createdAt,
    double? longitude,
    this.ageMonth = 0,
    String type = '-',
    this.gender = '-',
    TiutiuUser? owner,
    this.health = '-',
    this.ageYear = 0,
    double? latitude,
    this.color = '-',
    this.breed = '-',
    this.size = '-',
    String? ownerId,
    this.reward = '',
    int views = 0,
    dynamic video,
    String? name,
    String? uid,
  }) : super(
          describedAddress: describedAddress,
          dennounceMotives: dennounceMotives,
          timesDennounced: timesDennounced,
          description: description,
          hidden: donatedOrFound,
          longitude: longitude,
          done: donatedOrFound,
          createdAt: createdAt,
          latitude: latitude,
          ownerId: ownerId,
          photos: photos,
          state: state,
          views: views,
          owner: owner,
          video: video,
          city: city,
          type: type,
          name: name,
          uid: uid,
        );

  @override
  Pet fromMap(Map<String, dynamic> map) {
    return Pet(
      dennounceMotives: map[PostEnum.dennounceMotives.name] ?? super.dennounceMotives,
      timesDennounced: map[PostEnum.timesDennounced.name] ?? super.timesDennounced,
      createdAt: map[PostEnum.createdAt.name] ?? DateTime.now().toIso8601String(),
      uid: map[PostEnum.uid.name] != null ? map[PostEnum.uid.name] : Uuid().v4(),
      otherCaracteristics: map[PetEnum.otherCaracteristics.name] ?? [],
      chronicDiseaseInfo: map[PetEnum.chronicDiseaseInfo.name] ?? '',
      describedAddress: map[PostEnum.describedAddress.name] ?? '',
      donatedOrFound: map[PetEnum.donatedOrFound.name] ?? false,
      lastSeenDetails: map[PetEnum.lastSeenDetails.name] ?? '',
      owner: TiutiuUser.fromMap(map[PostEnum.owner.name]),
      disappeared: map[PetEnum.disappeared.name] ?? false,
      description: map[PostEnum.description.name] ?? '',
      city: map[PostEnum.city.name] ?? 'Acrelândia',
      state: map[PostEnum.state.name] ?? 'Acre',
      ageMonth: map[PetEnum.ageMonth.name] ?? 0,
      health: map[PetEnum.health.name] ?? '-',
      gender: map[PetEnum.gender.name] ?? '-',
      longitude: map[PostEnum.longitude.name],
      ageYear: map[PetEnum.ageYear.name] ?? 0,
      color: map[PetEnum.color.name] ?? '-',
      breed: map[PetEnum.breed.name] ?? '-',
      reward: map[PetEnum.reward.name] ?? '',
      latitude: map[PostEnum.latitude.name],
      views: map[PostEnum.views.name] ?? 0,
      size: map[PetEnum.size.name] ?? '-',
      type: map[PostEnum.type.name] ?? '-',
      ownerId: map[PostEnum.ownerId.name],
      photos: map[PostEnum.photos.name],
      video: map[PostEnum.video.name],
      name: map[PostEnum.name.name],
    );
  }

  String chronicDiseaseInfo;
  List otherCaracteristics;
  String lastSeenDetails;
  bool donatedOrFound;
  bool disappeared;
  String gender;
  String health;
  String reward;
  int ageMonth;
  String breed;
  int ageYear;
  String color;
  String size;

  @override
  Map<String, dynamic> toMap({bool convertFileToVideoPath = false}) {
    return {
      PostEnum.photos.name: convertFileToVideoPath ? photos.map((e) => e.path).toList() : photos,
      PostEnum.video.name: convertFileToVideoPath ? video.path : video,
      PetEnum.otherCaracteristics.name: otherCaracteristics,
      PetEnum.chronicDiseaseInfo.name: chronicDiseaseInfo,
      PostEnum.describedAddress.name: describedAddress,
      PostEnum.dennounceMotives.name: dennounceMotives,
      PostEnum.timesDennounced.name: timesDennounced,
      PetEnum.lastSeenDetails.name: lastSeenDetails,
      PetEnum.donatedOrFound.name: donatedOrFound,
      PostEnum.description.name: description,
      PetEnum.disappeared.name: disappeared,
      PostEnum.owner.name: owner?.toMap(),
      PostEnum.longitude.name: longitude,
      PostEnum.createdAt.name: createdAt,
      PostEnum.latitude.name: latitude,
      PetEnum.ageMonth.name: ageMonth,
      PostEnum.ownerId.name: ownerId,
      PetEnum.ageYear.name: ageYear,
      PetEnum.health.name: health,
      PetEnum.gender.name: gender,
      PetEnum.reward.name: reward,
      PostEnum.state.name: state,
      PostEnum.views.name: views,
      PetEnum.color.name: color,
      PetEnum.breed.name: breed,
      PostEnum.type.name: type,
      PostEnum.name.name: name,
      PostEnum.city.name: city,
      PetEnum.size.name: size,
      PostEnum.uid.name: uid,
    };
  }

  @override
  String toString() {
    return 'Pet(otherCaracteristics: $otherCaracteristics, chronicDiseaseInfo: $chronicDiseaseInfo, lastSeenDetails: $lastSeenDetails, donatedOrFound: $donatedOrFound, createdAt: $createdAt, owner: $owner, longitude: $longitude, disappeared: $disappeared, latitude: $latitude, ownerId: $ownerId, timesDennounced: $timesDennounced, description: $description, gender: $gender, health: $health, color: $color, ageMonth: $ageMonth, breed: $breed, ageYear: $ageYear, size: $size, state: $state, photos: $photos, name: $name, type: $type, city: $city, uid: $uid, views: $views, video: $video, reward: $reward, dennounceMotives: $dennounceMotives)';
  }

  @override
  bool operator ==(covariant Pet other) {
    if (identical(this, other)) return true;

    return other.otherCaracteristics == otherCaracteristics &&
        other.chronicDiseaseInfo == chronicDiseaseInfo &&
        other.describedAddress == describedAddress &&
        other.dennounceMotives == dennounceMotives &&
        other.lastSeenDetails == lastSeenDetails &&
        other.timesDennounced == timesDennounced &&
        other.donatedOrFound == donatedOrFound &&
        other.disappeared == disappeared &&
        other.description == description &&
        other.longitude == longitude &&
        other.createdAt == createdAt &&
        other.latitude == latitude &&
        other.ageMonth == ageMonth &&
        other.ownerId == ownerId &&
        other.ageYear == ageYear &&
        other.gender == gender &&
        other.reward == reward &&
        other.health == health &&
        other.photos == photos &&
        other.owner == owner &&
        other.video == video &&
        other.color == color &&
        other.breed == breed &&
        other.views == views &&
        other.state == state &&
        other.name == name &&
        other.size == size &&
        other.type == type &&
        other.city == city &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return otherCaracteristics.hashCode ^
        chronicDiseaseInfo.hashCode ^
        describedAddress.hashCode ^
        dennounceMotives.hashCode ^
        timesDennounced.hashCode ^
        lastSeenDetails.hashCode ^
        donatedOrFound.hashCode ^
        description.hashCode ^
        disappeared.hashCode ^
        createdAt.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        ageMonth.hashCode ^
        ownerId.hashCode ^
        ageYear.hashCode ^
        gender.hashCode ^
        photos.hashCode ^
        health.hashCode ^
        owner.hashCode ^
        video.hashCode ^
        color.hashCode ^
        breed.hashCode ^
        views.hashCode ^
        state.hashCode ^
        size.hashCode ^
        name.hashCode ^
        type.hashCode ^
        city.hashCode ^
        uid.hashCode;
  }
}
