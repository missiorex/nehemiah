import 'package:flutter/material.dart';
import 'package:missio_app_core/missio_app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nehemiah/blocs/blocs.dart';
import 'package:nehemiah/widgets/widgets.dart';
import 'package:nehemiah/models/models.dart';
import 'package:nehemiah/localization.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(CampaignLocalizations.of(context).appTitle),
            actions: [
              FilterButton(visible: activeTab == AppTab.campaigns),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.campaigns ? FilteredCampaigns() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: CampaignKeys.addCampaignFab,
            onPressed: () {
              Navigator.pushNamed(context, CampaignRoutes.addCampaign);
            },
            child: Icon(Icons.add),
            tooltip: MainLocalizations.of(context).addCampaign,
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
