import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missio_app_core/missio_app_core.dart';
import 'package:nehemiah/blocs/blocs.dart';
import 'package:nehemiah/widgets/widgets.dart';
import 'package:nehemiah/screens/screens.dart';

class FilteredCampaigns extends StatelessWidget {
  FilteredCampaigns({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MainLocalizations.of(context);

    return BlocBuilder<FilteredCampaignsBloc, FilteredCampaignsState>(
      builder: (context, state) {
        if (state is FilteredCampaignsLoadInProgress) {
          return LoadingIndicator(key: CampaignKeys.campaignsLoading);
        } else if (state is FilteredCampaignsLoadSuccess) {
          final campaigns = state.filteredCampaigns;
          return ListView.builder(
            key: CampaignKeys.campaignList,
            itemCount: campaigns.length,
            itemBuilder: (BuildContext context, int index) {
              final campaign = campaigns[index];
              return CampaignItem(
                campaign: campaign,
                onDismissed: (direction) {
                  BlocProvider.of<CampaignsBloc>(context)
                      .add(CampaignDeleted(campaign));
                  ScaffoldMessenger.of(context).showSnackBar(
                    DeleteCampaignSnackBar(
                      key: CampaignKeys.snackbar,
                      campaign: campaign,
                      onUndo: () => BlocProvider.of<CampaignsBloc>(context)
                          .add(CampaignAdded(campaign)),
                      localizations: localizations,
                    ),
                  );
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return CampaignDetailsScreen(id: campaign.id);
                    }),
                  );
                  if (removedTodo != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteCampaignSnackBar(
                        key: CampaignKeys.snackbar,
                        campaign: campaign,
                        onUndo: () => BlocProvider.of<CampaignsBloc>(context)
                            .add(CampaignAdded(campaign)),
                        localizations: localizations,
                      ),
                    );
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<CampaignsBloc>(context).add(
                    CampaignUpdated(
                        campaign.copyWith(complete: !campaign.complete)),
                  );
                },
                onRosaryIncrement: () {
                  BlocProvider.of<CampaignsBloc>(context).add(
                    RosaryCountUpdated(campaign),
                  );
                },
              );
            },
          );
        } else {
          return Container(key: CampaignKeys.filteredCampaignsEmptyContainer);
        }
      },
    );
  }
}
