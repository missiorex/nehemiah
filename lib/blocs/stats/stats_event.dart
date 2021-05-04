import 'package:equatable/equatable.dart';
import 'package:nehemiah/models/models.dart';
import 'package:campaign_repository/campaign_repository.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class StatsUpdated extends StatsEvent {
  final List<Campaign> campaigns;

  const StatsUpdated(this.campaigns);

  @override
  List<Object> get props => [campaigns];

  @override
  String toString() => 'UpdateStats { campaigns: $campaigns }';
}
