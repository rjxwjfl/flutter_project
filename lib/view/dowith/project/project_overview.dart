import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/server_bloc/model/project/project_model.dart';
import 'package:flutter_dowith/view/dowith/project/model/title_view.dart';

class ProjectOverView extends StatelessWidget {
  const ProjectOverView({required this.data, Key? key}) : super(key: key);

  final ProjectModel data;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          sliver: SliverToBoxAdapter(
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(data.title),
                              const SizedBox(height: 20),
                              Text("${data.createAt}")
                            ],
                          ),
                        ),
                        const Column(
                          children: [
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
        const SliverToBoxAdapter(
          child: TitleView(titleText: "CONTRIBUTION"),
        ),
        SliverToBoxAdapter(
          child: getContribution(),
        ),
        const SliverToBoxAdapter(
          child: TitleView(titleText: "MY TASK"),
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
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
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
