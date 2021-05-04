import 'package:equatable/equatable.dart';
import 'package:campaign_repository/campaign_repository.dart';

abstract class CampaignsState extends Equatable {
  const CampaignsState();

  @override
  List<Object> get props => [];
}

class CampaignsLoadInProgress extends CampaignsState {}

class CampaignsLoadSuccess extends CampaignsState {
  final List<Campaign> campaigns;

  const CampaignsLoadSuccess([this.campaigns = const []]);

  @override
  List<Object> get props => [campaigns];

  @override
  String toString() => 'CampaignsLoadSuccess { campaigns: $campaigns }';
}

class CampaignsLoadFailure extends CampaignsState {}
