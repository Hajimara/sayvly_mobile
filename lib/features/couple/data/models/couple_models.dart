class PartnerInfoModel {
  final int id;
  final String nickname;
  final String? profileImageUrl;
  final String? gender;

  PartnerInfoModel({
    required this.id,
    required this.nickname,
    required this.profileImageUrl,
    required this.gender,
  });

  factory PartnerInfoModel.fromJson(Map<String, dynamic> json) {
    return PartnerInfoModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      nickname: json['nickname'] as String? ?? '',
      profileImageUrl: json['profileImageUrl'] as String?,
      gender: json['gender'] as String?,
    );
  }
}

class CoupleInfoModel {
  final int coupleId;
  final PartnerInfoModel partner;
  final DateTime connectedAt;
  final bool isSubscriber;

  CoupleInfoModel({
    required this.coupleId,
    required this.partner,
    required this.connectedAt,
    required this.isSubscriber,
  });

  factory CoupleInfoModel.fromJson(Map<String, dynamic> json) {
    return CoupleInfoModel(
      coupleId: (json['coupleId'] as num?)?.toInt() ?? 0,
      partner: PartnerInfoModel.fromJson(
        json['partner'] as Map<String, dynamic>? ?? const {},
      ),
      connectedAt: DateTime.parse(json['connectedAt'] as String),
      isSubscriber: json['isSubscriber'] as bool? ?? false,
    );
  }
}

class InviteResponseModel {
  final String code;
  final DateTime expiresAt;
  final String shareUrl;

  InviteResponseModel({
    required this.code,
    required this.expiresAt,
    required this.shareUrl,
  });

  factory InviteResponseModel.fromJson(Map<String, dynamic> json) {
    return InviteResponseModel(
      code: json['code'] as String? ?? '',
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      shareUrl: json['shareUrl'] as String? ?? '',
    );
  }
}

class ShareSettingsModel {
  final bool sharePeriodExpected;
  final bool sharePeriodCurrent;
  final bool sharePeriodProgress;
  final bool sharePms;
  final bool shareFertile;
  final bool shareCondition;
  final bool shareAnniversary;
  final String shareLevel;

  ShareSettingsModel({
    required this.sharePeriodExpected,
    required this.sharePeriodCurrent,
    required this.sharePeriodProgress,
    required this.sharePms,
    required this.shareFertile,
    required this.shareCondition,
    required this.shareAnniversary,
    required this.shareLevel,
  });

  factory ShareSettingsModel.fromJson(Map<String, dynamic> json) {
    return ShareSettingsModel(
      sharePeriodExpected: json['sharePeriodExpected'] as bool? ?? false,
      sharePeriodCurrent: json['sharePeriodCurrent'] as bool? ?? false,
      sharePeriodProgress: json['sharePeriodProgress'] as bool? ?? false,
      sharePms: json['sharePms'] as bool? ?? false,
      shareFertile: json['shareFertile'] as bool? ?? false,
      shareCondition: json['shareCondition'] as bool? ?? false,
      shareAnniversary: json['shareAnniversary'] as bool? ?? false,
      shareLevel: json['shareLevel'] as String? ?? 'MINIMUM',
    );
  }

  Map<String, dynamic> toPatchJson() {
    return {
      'sharePeriodExpected': sharePeriodExpected,
      'sharePeriodCurrent': sharePeriodCurrent,
      'sharePeriodProgress': sharePeriodProgress,
      'sharePms': sharePms,
      'shareFertile': shareFertile,
      'shareCondition': shareCondition,
      'shareAnniversary': shareAnniversary,
      'shareLevel': shareLevel,
    };
  }

  ShareSettingsModel copyWith({
    bool? sharePeriodExpected,
    bool? sharePeriodCurrent,
    bool? sharePeriodProgress,
    bool? sharePms,
    bool? shareFertile,
    bool? shareCondition,
    bool? shareAnniversary,
    String? shareLevel,
  }) {
    return ShareSettingsModel(
      sharePeriodExpected: sharePeriodExpected ?? this.sharePeriodExpected,
      sharePeriodCurrent: sharePeriodCurrent ?? this.sharePeriodCurrent,
      sharePeriodProgress: sharePeriodProgress ?? this.sharePeriodProgress,
      sharePms: sharePms ?? this.sharePms,
      shareFertile: shareFertile ?? this.shareFertile,
      shareCondition: shareCondition ?? this.shareCondition,
      shareAnniversary: shareAnniversary ?? this.shareAnniversary,
      shareLevel: shareLevel ?? this.shareLevel,
    );
  }
}

class PartnerStatusModel {
  final String partnerName;
  final String? partnerProfileImageUrl;
  final bool? isPms;
  final bool? isOnPeriod;
  final int? dayOfPeriod;
  final DateTime? nextPeriodDate;
  final int? daysUntil;

  PartnerStatusModel({
    required this.partnerName,
    required this.partnerProfileImageUrl,
    required this.isPms,
    required this.isOnPeriod,
    required this.dayOfPeriod,
    required this.nextPeriodDate,
    required this.daysUntil,
  });

  factory PartnerStatusModel.fromJson(Map<String, dynamic> json) {
    final periodStatus = json['periodStatus'] as Map<String, dynamic>?;
    final prediction = json['prediction'] as Map<String, dynamic>?;
    return PartnerStatusModel(
      partnerName: json['partnerName'] as String? ?? '',
      partnerProfileImageUrl: json['partnerProfileImageUrl'] as String?,
      isPms: json['isPms'] as bool?,
      isOnPeriod: periodStatus?['isOnPeriod'] as bool?,
      dayOfPeriod: (periodStatus?['dayOfPeriod'] as num?)?.toInt(),
      nextPeriodDate: prediction?['nextPeriodDate'] == null
          ? null
          : DateTime.parse(prediction!['nextPeriodDate'] as String),
      daysUntil: (prediction?['daysUntil'] as num?)?.toInt(),
    );
  }
}

class PartnerCalendarDataModel {
  final int year;
  final int month;
  final List<PartnerCalendarDayModel> days;

  PartnerCalendarDataModel({
    required this.year,
    required this.month,
    required this.days,
  });

  factory PartnerCalendarDataModel.fromJson(Map<String, dynamic> json) {
    final rawDays = json['days'] as List<dynamic>? ?? const [];
    return PartnerCalendarDataModel(
      year: (json['year'] as num?)?.toInt() ?? 0,
      month: (json['month'] as num?)?.toInt() ?? 0,
      days: rawDays
          .map(
            (item) => PartnerCalendarDayModel.fromJson(
              item as Map<String, dynamic>? ?? const {},
            ),
          )
          .toList(),
    );
  }
}

class PartnerCalendarDayModel {
  final DateTime date;
  final bool? isPeriod;
  final bool? isPredictedPeriod;
  final bool? isPms;
  final bool? isFertile;
  final bool hasAnniversary;
  final String? anniversaryName;

  PartnerCalendarDayModel({
    required this.date,
    required this.isPeriod,
    required this.isPredictedPeriod,
    required this.isPms,
    required this.isFertile,
    required this.hasAnniversary,
    required this.anniversaryName,
  });

  factory PartnerCalendarDayModel.fromJson(Map<String, dynamic> json) {
    return PartnerCalendarDayModel(
      date: DateTime.parse(json['date'] as String),
      isPeriod: json['isPeriod'] as bool?,
      isPredictedPeriod: json['isPredictedPeriod'] as bool?,
      isPms: json['isPms'] as bool?,
      isFertile: json['isFertile'] as bool?,
      hasAnniversary: json['hasAnniversary'] as bool? ?? false,
      anniversaryName: json['anniversaryName'] as String?,
    );
  }
}

class UpcomingEventsModel {
  final UpcomingPeriodModel? nextPeriod;
  final List<UpcomingAnniversaryModel> upcomingAnniversaries;

  UpcomingEventsModel({
    required this.nextPeriod,
    required this.upcomingAnniversaries,
  });

  factory UpcomingEventsModel.fromJson(Map<String, dynamic> json) {
    final rawAnniversaries =
        json['upcomingAnniversaries'] as List<dynamic>? ?? const [];
    final nextPeriodData = json['nextPeriod'] as Map<String, dynamic>?;

    return UpcomingEventsModel(
      nextPeriod: nextPeriodData == null
          ? null
          : UpcomingPeriodModel.fromJson(nextPeriodData),
      upcomingAnniversaries: rawAnniversaries
          .map(
            (item) => UpcomingAnniversaryModel.fromJson(
              item as Map<String, dynamic>? ?? const {},
            ),
          )
          .toList(),
    );
  }
}

class UpcomingPeriodModel {
  final DateTime expectedDate;
  final int daysUntil;

  UpcomingPeriodModel({
    required this.expectedDate,
    required this.daysUntil,
  });

  factory UpcomingPeriodModel.fromJson(Map<String, dynamic> json) {
    return UpcomingPeriodModel(
      expectedDate: DateTime.parse(json['expectedDate'] as String),
      daysUntil: (json['daysUntil'] as num?)?.toInt() ?? 0,
    );
  }
}

class UpcomingAnniversaryModel {
  final int id;
  final String name;
  final DateTime date;
  final int daysUntil;
  final bool isAnnual;

  UpcomingAnniversaryModel({
    required this.id,
    required this.name,
    required this.date,
    required this.daysUntil,
    required this.isAnnual,
  });

  factory UpcomingAnniversaryModel.fromJson(Map<String, dynamic> json) {
    return UpcomingAnniversaryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      date: DateTime.parse(json['date'] as String),
      daysUntil: (json['daysUntil'] as num?)?.toInt() ?? 0,
      isAnnual: json['isAnnual'] as bool? ?? false,
    );
  }
}
