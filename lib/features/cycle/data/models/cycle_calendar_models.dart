class MonthlyCalendarResponse {
  final int year;
  final int month;
  final List<CalendarDayModel> days;
  final CalendarPredictions? predictions;
  final String? disclaimer;

  MonthlyCalendarResponse({
    required this.year,
    required this.month,
    required this.days,
    required this.predictions,
    required this.disclaimer,
  });

  factory MonthlyCalendarResponse.fromJson(Map<String, dynamic> json) {
    return MonthlyCalendarResponse(
      year: (json['year'] as num?)?.toInt() ?? 0,
      month: (json['month'] as num?)?.toInt() ?? 0,
      days: (json['days'] as List<dynamic>? ?? const [])
          .map((e) => CalendarDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      predictions: json['predictions'] == null
          ? null
          : CalendarPredictions.fromJson(
              json['predictions'] as Map<String, dynamic>,
            ),
      disclaimer: json['disclaimer'] as String?,
    );
  }
}

class CalendarDayModel {
  final DateTime date;
  final bool isPeriod;
  final bool isPredictedPeriod;
  final bool isOvulation;
  final bool isFertile;
  final bool isPms;
  final bool hasSymptoms;
  final bool hasAnniversary;
  final String? phase;
  final int symptomCount;
  final List<PredictedSymptomSummary> predictedSymptoms;

  CalendarDayModel({
    required this.date,
    required this.isPeriod,
    required this.isPredictedPeriod,
    required this.isOvulation,
    required this.isFertile,
    required this.isPms,
    required this.hasSymptoms,
    required this.hasAnniversary,
    required this.phase,
    required this.symptomCount,
    required this.predictedSymptoms,
  });

  factory CalendarDayModel.fromJson(Map<String, dynamic> json) {
    return CalendarDayModel(
      date: DateTime.parse(json['date'] as String),
      isPeriod: json['isPeriod'] as bool? ?? false,
      isPredictedPeriod: json['isPredictedPeriod'] as bool? ?? false,
      isOvulation: json['isOvulation'] as bool? ?? false,
      isFertile: json['isFertile'] as bool? ?? false,
      isPms: json['isPms'] as bool? ?? false,
      hasSymptoms: json['hasSymptoms'] as bool? ?? false,
      hasAnniversary: json['hasAnniversary'] as bool? ?? false,
      phase: json['phase'] as String?,
      symptomCount: (json['symptomCount'] as num?)?.toInt() ?? 0,
      predictedSymptoms:
          (json['predictedSymptoms'] as List<dynamic>? ?? const [])
              .map(
                (e) =>
                    PredictedSymptomSummary.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}

class CalendarPredictions {
  final DateTime? nextPeriodDate;
  final DateTime? nextOvulationDate;
  final DateTime? fertileWindowStart;
  final DateTime? fertileWindowEnd;
  final DateTime? pmsWindowStart;
  final DateTime? pmsWindowEnd;

  CalendarPredictions({
    required this.nextPeriodDate,
    required this.nextOvulationDate,
    required this.fertileWindowStart,
    required this.fertileWindowEnd,
    required this.pmsWindowStart,
    required this.pmsWindowEnd,
  });

  factory CalendarPredictions.fromJson(Map<String, dynamic> json) {
    DateTime? parse(dynamic value) =>
        value == null ? null : DateTime.parse(value as String);

    return CalendarPredictions(
      nextPeriodDate: parse(json['nextPeriodDate']),
      nextOvulationDate: parse(json['nextOvulationDate']),
      fertileWindowStart: parse(json['fertileWindowStart']),
      fertileWindowEnd: parse(json['fertileWindowEnd']),
      pmsWindowStart: parse(json['pmsWindowStart']),
      pmsWindowEnd: parse(json['pmsWindowEnd']),
    );
  }
}

class DayDetailResponse {
  final DateTime date;
  final CycleSummary? cycle;
  final int? dayOfCycle;
  final int? dayOfPeriod;
  final String phase;
  final List<SymptomRecord> symptoms;
  final List<AnniversaryInfo> anniversaries;
  final bool isPredictedPeriod;
  final bool isOvulation;
  final bool isFertile;
  final bool isPms;
  final List<PredictedSymptomSummary> predictedSymptoms;
  final String? disclaimer;

  DayDetailResponse({
    required this.date,
    required this.cycle,
    required this.dayOfCycle,
    required this.dayOfPeriod,
    required this.phase,
    required this.symptoms,
    required this.anniversaries,
    required this.isPredictedPeriod,
    required this.isOvulation,
    required this.isFertile,
    required this.isPms,
    required this.predictedSymptoms,
    required this.disclaimer,
  });

  factory DayDetailResponse.fromJson(Map<String, dynamic> json) {
    return DayDetailResponse(
      date: DateTime.parse(json['date'] as String),
      cycle: json['cycle'] == null
          ? null
          : CycleSummary.fromJson(json['cycle'] as Map<String, dynamic>),
      dayOfCycle: (json['dayOfCycle'] as num?)?.toInt(),
      dayOfPeriod: (json['dayOfPeriod'] as num?)?.toInt(),
      phase: json['phase'] as String? ?? 'UNKNOWN',
      symptoms: (json['symptoms'] as List<dynamic>? ?? const [])
          .map((e) => SymptomRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      anniversaries: (json['anniversaries'] as List<dynamic>? ?? const [])
          .map((e) => AnniversaryInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPredictedPeriod: json['isPredictedPeriod'] as bool? ?? false,
      isOvulation: json['isOvulation'] as bool? ?? false,
      isFertile: json['isFertile'] as bool? ?? false,
      isPms: json['isPms'] as bool? ?? false,
      predictedSymptoms:
          (json['predictedSymptoms'] as List<dynamic>? ?? const [])
              .map(
                (e) =>
                    PredictedSymptomSummary.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      disclaimer: json['disclaimer'] as String?,
    );
  }
}

class CycleSummary {
  final int id;
  final DateTime startDate;
  final DateTime? endDate;
  final String? flowIntensity;
  final int? periodLength;
  final int? cycleLength;
  final bool isOngoing;
  final String? warning;

  CycleSummary({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.flowIntensity,
    required this.periodLength,
    required this.cycleLength,
    required this.isOngoing,
    required this.warning,
  });

  factory CycleSummary.fromJson(Map<String, dynamic> json) {
    return CycleSummary(
      id: (json['id'] as num?)?.toInt() ?? 0,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      flowIntensity: json['flowIntensity'] as String?,
      periodLength: (json['periodLength'] as num?)?.toInt(),
      cycleLength: (json['cycleLength'] as num?)?.toInt(),
      isOngoing: json['isOngoing'] as bool? ?? false,
      warning: json['warning'] as String?,
    );
  }
}

class SymptomRecord {
  final int id;
  final DateTime recordDate;
  final String symptomType;
  final String symptomDisplayName;
  final String category;
  final int intensity;
  final String? timeOfDay;
  final String? memo;

  SymptomRecord({
    required this.id,
    required this.recordDate,
    required this.symptomType,
    required this.symptomDisplayName,
    required this.category,
    required this.intensity,
    required this.timeOfDay,
    required this.memo,
  });

  factory SymptomRecord.fromJson(Map<String, dynamic> json) {
    return SymptomRecord(
      id: (json['id'] as num?)?.toInt() ?? 0,
      recordDate: DateTime.parse(json['recordDate'] as String),
      symptomType: json['symptomType'] as String? ?? '',
      symptomDisplayName: json['symptomDisplayName'] as String? ?? '',
      category: json['category'] as String? ?? '',
      intensity: (json['intensity'] as num?)?.toInt() ?? 0,
      timeOfDay: json['timeOfDay'] as String?,
      memo: json['memo'] as String?,
    );
  }
}

class AnniversaryInfo {
  final int id;
  final String name;
  final String? icon;
  final String? color;

  AnniversaryInfo({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  factory AnniversaryInfo.fromJson(Map<String, dynamic> json) {
    return AnniversaryInfo(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String?,
      color: json['color'] as String?,
    );
  }
}

class PredictedSymptomSummary {
  final String symptomType;
  final String displayName;
  final int probability;

  PredictedSymptomSummary({
    required this.symptomType,
    required this.displayName,
    required this.probability,
  });

  factory PredictedSymptomSummary.fromJson(Map<String, dynamic> json) {
    return PredictedSymptomSummary(
      symptomType: json['symptomType'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      probability: (json['probability'] as num?)?.toInt() ?? 0,
    );
  }
}

class PredictedSymptomHistoryResponse {
  final String symptomType;
  final String displayName;
  final String phase;
  final int currentProbability;
  final List<OccurrenceHistoryItem> history;

  PredictedSymptomHistoryResponse({
    required this.symptomType,
    required this.displayName,
    required this.phase,
    required this.currentProbability,
    required this.history,
  });

  factory PredictedSymptomHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PredictedSymptomHistoryResponse(
      symptomType: json['symptomType'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      phase: json['phase'] as String? ?? 'UNKNOWN',
      currentProbability: (json['currentProbability'] as num?)?.toInt() ?? 0,
      history: (json['history'] as List<dynamic>? ?? const [])
          .map((e) => OccurrenceHistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class OccurrenceHistoryItem {
  final DateTime cycleStartDate;
  final int cycleNumber;
  final bool? occurred;
  final DateTime? recordDate;
  final int? intensity;

  OccurrenceHistoryItem({
    required this.cycleStartDate,
    required this.cycleNumber,
    required this.occurred,
    required this.recordDate,
    required this.intensity,
  });

  factory OccurrenceHistoryItem.fromJson(Map<String, dynamic> json) {
    return OccurrenceHistoryItem(
      cycleStartDate: DateTime.parse(json['cycleStartDate'] as String),
      cycleNumber: (json['cycleNumber'] as num?)?.toInt() ?? 0,
      occurred: json['occurred'] as bool?,
      recordDate: json['recordDate'] == null
          ? null
          : DateTime.parse(json['recordDate'] as String),
      intensity: (json['intensity'] as num?)?.toInt(),
    );
  }
}

class CurrentCycleResponse {
  final CycleSummary? currentCycle;
  final String phase;
  final int? dayOfCycle;
  final int? dayOfPeriod;
  final DateTime? nextPeriodDate;
  final DateTime? nextOvulationDate;
  final DateTime? fertileWindowStart;
  final DateTime? fertileWindowEnd;
  final int? daysUntilNextPeriod;
  final int? averagePeriodLength;
  final String? disclaimer;

  CurrentCycleResponse({
    required this.currentCycle,
    required this.phase,
    required this.dayOfCycle,
    required this.dayOfPeriod,
    required this.nextPeriodDate,
    required this.nextOvulationDate,
    required this.fertileWindowStart,
    required this.fertileWindowEnd,
    required this.daysUntilNextPeriod,
    required this.averagePeriodLength,
    required this.disclaimer,
  });

  factory CurrentCycleResponse.fromJson(Map<String, dynamic> json) {
    DateTime? parse(dynamic value) =>
        value == null ? null : DateTime.parse(value as String);

    return CurrentCycleResponse(
      currentCycle: json['currentCycle'] == null
          ? null
          : CycleSummary.fromJson(json['currentCycle'] as Map<String, dynamic>),
      phase: json['phase'] as String? ?? 'UNKNOWN',
      dayOfCycle: (json['dayOfCycle'] as num?)?.toInt(),
      dayOfPeriod: (json['dayOfPeriod'] as num?)?.toInt(),
      nextPeriodDate: parse(json['nextPeriodDate']),
      nextOvulationDate: parse(json['nextOvulationDate']),
      fertileWindowStart: parse(json['fertileWindowStart']),
      fertileWindowEnd: parse(json['fertileWindowEnd']),
      daysUntilNextPeriod: (json['daysUntilNextPeriod'] as num?)?.toInt(),
      averagePeriodLength: (json['averagePeriodLength'] as num?)?.toInt(),
      disclaimer: json['disclaimer'] as String?,
    );
  }
}

class SymptomTypeItem {
  final String type;
  final String displayName;
  final String category;

  SymptomTypeItem({
    required this.type,
    required this.displayName,
    required this.category,
  });

  factory SymptomTypeItem.fromJson(Map<String, dynamic> json) {
    return SymptomTypeItem(
      type: json['type'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }
}
