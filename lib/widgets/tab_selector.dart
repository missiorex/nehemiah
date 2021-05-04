import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:missio_app_core/missio_app_core.dart';
import 'package:nehemiah/models/models.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: CampaignKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.campaigns ? Icons.list : Icons.show_chart,
            key: tab == AppTab.campaigns
                ? CampaignKeys.campaignTab
                : CampaignKeys.statsTab,
          ),
          label: tab == AppTab.stats
              ? MainLocalizations.of(context).stats
              : MainLocalizations.of(context).campaigns,
        );
      }).toList(),
    );
  }
}
