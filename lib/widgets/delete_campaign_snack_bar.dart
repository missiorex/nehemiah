import 'package:flutter/material.dart';
import 'package:missio_app_core/missio_app_core.dart';
import 'package:campaign_repository/campaign_repository.dart';

class DeleteCampaignSnackBar extends SnackBar {
  final MainLocalizations localizations;

  DeleteCampaignSnackBar({
    Key key,
    @required Campaign campaign,
    @required VoidCallback onUndo,
    @required this.localizations,
  }) : super(
          key: key,
          content: Text(
            localizations.campaignDeleted(campaign.title),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: localizations.undo,
            onPressed: onUndo,
          ),
        );
}
