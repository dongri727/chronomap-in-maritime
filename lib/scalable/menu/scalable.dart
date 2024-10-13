import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../../hints/scalabel_hint_page.dart';
import '../../index.dart';
import '../../serverpod_client.dart';
import '../../utils/navi_button.dart';
import '../../utils/shadowed_container.dart';
import '../bloc_provider.dart';
import '../timeline/widget.dart';
import 'menu_data.dart';
import 'menu_section.dart';

class Scalable extends StatefulWidget {
  final List<Principal>? principal;
  const Scalable({super.key, this.principal});

  @override
  ScalableState createState() => ScalableState();
}

class ScalableState extends State<Scalable> {
  List<Principal> listPrincipal = [];
  List<int> principalIds = [];

  List<int> maritimeCode = [695];

  /// [MenuData] selects era witch will be displayed at the Timeline
  /// This data is loaded from the asset bundle during [initState()]
  final MenuData _menu = MenuData();

  ///fetch principal in Space
  Future<void> fetchPrincipalByDetailId({List<int>? detailIds}) async {
    try {
      listPrincipal = await client.principal.getPrincipalByDetailIds(detailIds: maritimeCode);
      principalIds = listPrincipal.map((item) => item.id as int).toList();
      setState(() {}); // データの更新をUIに反映させる
    } catch (e) {
      debugPrint('$e');
    }
  }

  /// Helper function which sets the [MenuItemData] for the [TimelineWidget].
  /// This will trigger a transition from the current menu to the Timeline,
  /// thus the push on the [Navigator], this widget will know where to scroll to.
  navigateToTimeline(MenuItemData item, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) =>
          TimelineWidget(item, BlocProvider.getTimeline(context)),
    ));
  }

  @override
  void initState() {
    super.initState();

    /// Initialize the menu with hardcoded data.
    _menu.initializeWithDefaultData();

    /// Notify the framework that the internal state of this object has changed.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final timeline = BlocProvider.getTimeline(context);

    List<Widget> tail = [];

    tail
        .addAll(_menu.sections
        .map<Widget>((MenuSectionData section) => MenuSection(
      section.label,
      section.backgroundColor,
      section.textColor,
      section.items,
      navigateToTimeline,
    ))
        .toList(growable: false)
    );

    return Scaffold(
        appBar: AppBar(
          leading: const NavigationButton(
              destinationPage: IndexPage(),
              buttonText: 'INDEX'),
          leadingWidth: 100,
          title: const Text("SCALABLE"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScalableHintPage()));
                },
                icon: const Icon(
                  Icons.question_mark,
                  color: Colors.blue,
                ))
          ],
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sea.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(80, 100, 80, 0),
                child: Column(
                    children: [
                      const Text('Step 1 Get Data', style: TextStyle(color: Colors.white, fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ShadowedContainer(
                          child: OutlinedButton(
                            onPressed: () async {
                              await fetchPrincipalByDetailId();
                              await timeline.gatherEntries(listPrincipal);
                            },
                            child: const Text('Get', style: TextStyle(color: Colors.red, fontSize: 20),),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Text('Step 2 Choose Epoch', style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ] + tail),
              ),
            ),
          ),
        ));
  }
}
