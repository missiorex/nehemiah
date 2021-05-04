import 'package:missio_app_core/missio_app_core.dart';
import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Campaign extends Equatable {
  final bool complete;
  final String id;
  final String title;
  final String description;
  final int rosaryCount;
  final int mercyChapletCount;
  final double fastingHourCount;
  final int penanceCount;
  final String imageUrl;
  final String lsImageUrl;
  final String category;
  final String language;
  final bool isActive;
  final bool isPriority;
  final DateTime createdTime;
  final DateTime publishTime;

  Campaign(
    this.title, {
    this.complete = false,
    String description = '',
    String id,
    int rosaryCount,
    int mercyChapletCount,
    double fastingHourCount,
    int penanceCount,
    String imageUrl,
    String lsImageUrl,
    String category,
    String language,
    bool isActive,
    bool isPriority,
    DateTime createdTime,
    DateTime publishTime,
  })  : this.description = description ?? '',
        this.rosaryCount = rosaryCount ?? 0,
        this.mercyChapletCount = mercyChapletCount ?? 0,
        this.fastingHourCount = fastingHourCount ?? 0.0,
        this.penanceCount = penanceCount ?? 0,
        this.id = id ?? Uuid().generateV4(),
        this.category = category ?? 'general',
        this.language = language ?? 'en',
        this.imageUrl = imageUrl ??
            'https://firebasestorage.googleapis.com/v0/b/nehemiah-b1bea.appspot.com/o/default%2Fprayer_default.png?alt=media&token=55222858-52d4-4847-900d-47f98f1775b8',
        this.lsImageUrl = lsImageUrl ??
            'https://firebasestorage.googleapis.com/v0/b/nehemiah-b1bea.appspot.com/o/default%2Fprayer_default.png?alt=media&token=55222858-52d4-4847-900d-47f98f1775b8',
        this.isActive = complete ?? false,
        this.isPriority = isPriority ?? false,
        this.createdTime = createdTime ?? DateTime.now(),
        this.publishTime = publishTime ?? DateTime.now();

  Campaign copyWith({
    bool complete,
    String id,
    String title,
    String description,
    int rosaryCount,
    int mercyChapletCount,
    double fastingHourCount,
    int penanceCount,
    String imageUrl,
    String lsImageUrl,
    String category,
    String language,
    bool isActive,
    bool isPriority,
    DateTime createdTime,
    DateTime publishTime,
  }) {
    return Campaign(title ?? this.title,
        complete: complete ?? this.complete,
        id: id ?? this.id,
        description: description ?? this.description,
        rosaryCount: rosaryCount ?? this.rosaryCount,
        mercyChapletCount: mercyChapletCount ?? this.mercyChapletCount,
        fastingHourCount: fastingHourCount ?? this.fastingHourCount,
        penanceCount: penanceCount ?? this.penanceCount,
        imageUrl: imageUrl ?? this.imageUrl,
        lsImageUrl: lsImageUrl ?? this.lsImageUrl,
        category: category ?? this.category,
        language: language ?? this.language,
        isActive: isActive ?? this.isActive,
        isPriority: isPriority ?? this.isPriority,
        createdTime: createdTime ?? this.createdTime,
        publishTime: publishTime ?? this.publishTime);
  }

  @override
  List<Object> get props => [
        complete,
        id,
        title,
        description,
        rosaryCount,
        mercyChapletCount,
        fastingHourCount,
        penanceCount,
        imageUrl,
        lsImageUrl,
        category,
        language,
        isActive,
        isPriority,
        createdTime,
        publishTime,
      ];

  @override
  String toString() {
    return 'Campaign { complete: $complete, title: $title, description: $description, id: $id }';
  }

  CampaignEntity toEntity() {
    return CampaignEntity(
      id,
      title,
      description,
      complete,
      rosaryCount,
      mercyChapletCount,
      fastingHourCount,
      penanceCount,
      imageUrl,
      lsImageUrl,
      category,
      language,
      isActive,
      isPriority,
      createdTime.millisecondsSinceEpoch,
      publishTime.millisecondsSinceEpoch,
    );
  }

  static Campaign fromEntity(CampaignEntity entity) {
    return Campaign(entity.title,
        complete: entity.complete ?? false,
        description: entity.description,
        id: entity.id ?? Uuid().generateV4(),
        rosaryCount: entity.rosaryCount,
        mercyChapletCount: entity.mercyChapletCount,
        fastingHourCount: entity.fastingHourCount,
        penanceCount: entity.penanceCount,
        imageUrl: entity.imageUrl,
        lsImageUrl: entity.lsImageUrl,
        category: entity.category,
        language: entity.language,
        isActive: entity.isActive,
        isPriority: entity.isPriority,
        createdTime: DateTime.fromMillisecondsSinceEpoch(entity.createdTime),
        publishTime: DateTime.fromMillisecondsSinceEpoch(entity.publishTime));
  }
}
