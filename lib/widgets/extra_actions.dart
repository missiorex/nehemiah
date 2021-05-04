import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missio_app_core/missio_app_core.dart';
import 'package:nehemiah/blocs/blocs.dart';
import 'package:nehemiah/models/models.dart';
import 'package:campaign_repository/campaign_repository.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key key}) : super(key: CampaignKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignsBloc, CampaignsState>(
      builder: (context, state) {
        if (state is CampaignsLoadSuccess) {
          bool allComplete = (BlocProvider.of<CampaignsBloc>(context).state
                  as CampaignsLoadSuccess)
              .campaigns
              .every((campaign) => campaign.complete);
          return PopupMenuButton<ExtraAction>(
            key: CampaignKeys.extraActionsPopupMenuButton,
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  BlocProvider.of<CampaignsBloc>(context).add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  BlocProvider.of<CampaignsBloc>(context).add(ToggleAll());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                key: CampaignKeys.toggleAll,
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete
                      ? MainLocalizations.of(context).markAllIncomplete
                      : MainLocalizations.of(context).markAllComplete,
                ),
              ),
              PopupMenuItem<ExtraAction>(
                key: CampaignKeys.clearCompleted,
                value: ExtraAction.clearCompleted,
                child: Text(
                  MainLocalizations.of(context).clearCompleted,
                ),
              ),
            ],
          );
        }
        return Container(key: CampaignKeys.extraActionsEmptyContainer);
      },
    );
  }
}
