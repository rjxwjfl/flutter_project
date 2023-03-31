import 'package:flutter/material.dart';
import 'package:flutter_dowith/utils/glow_remover.dart';

class ProjectOverView extends StatelessWidget {
  const ProjectOverView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          sliver: SliverToBoxAdapter(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: const [
                              Text("TITLE"),
                              SizedBox(height: 20),
                              Text("PROJECT PERIOD")
                            ],
                          ),
                        ),
                        Column(
                          children: const [
                            Text("PROGRESS"),
                            Placeholder(
                              fallbackHeight: 100,
                              fallbackWidth: 100,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    const Text("RULE"),
                    const Placeholder(
                      fallbackWidth: 300,
                      fallbackHeight: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: getTitleUI("CONTRIBUTION"),
        ),
        SliverToBoxAdapter(
          child: getContribution(),
        ),
        SliverToBoxAdapter(
          child: getTitleUI("MY TASK"),
        ),
        SliverToBoxAdapter(
          child: getMyTaskOverView(context),
        ),
      ],
    );
  }

  Widget getTitleUI(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: SizedBox(child: Row(
        children: [
          Expanded(child: Text(title, textAlign: TextAlign.start)),
          const Text("SHOW MORE >>")
        ],
      )),
    );
  }

  Widget getContribution() {
    return SingleChildScrollView(
      child: SizedBox(
        height: 110,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
            itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(5),
            child: Placeholder(
              fallbackWidth: 100,
            ),
          );
        }),
      ),
    );
  }

  Widget getMyTaskOverView(context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: ((context, index) {
        return const Padding(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Placeholder(
            fallbackHeight: 100,
          ),
        );
      })),
    );
  }
}
