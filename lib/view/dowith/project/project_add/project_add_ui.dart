import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/model/project_draw_up_input.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/model/button_ui.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/model/get_period_ui.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/model/rule_input.dart';

class ProjectAddUI extends StatefulWidget {
  const ProjectAddUI({Key? key}) : super(key: key);

  @override
  State<ProjectAddUI> createState() => _ProjectAddUIState();
}

class _ProjectAddUIState extends State<ProjectAddUI> with TickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _ruleController = TextEditingController();
  final TextEditingController _prjPwController = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  final FocusNode _goalFocus = FocusNode();
  final FocusNode _ruleFocus = FocusNode();
  final FocusNode _prjPwFocus = FocusNode();

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return AnimatedOpacity(
          opacity: _animationController.value,
          duration: const Duration(milliseconds: 100),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProjectDrawUpInput(
                            title: "프로젝트 제목",
                            hint: "제목을 입력하세요.",
                            controller: _titleController,
                            focusNode: _titleFocus,
                            validator: _titleValidate,
                            length: 20,
                          ),
                          ProjectDrawUpInput(
                            title: "목표",
                            hint: "목표를 설정하세요.",
                            controller: _goalController,
                            focusNode: _goalFocus,
                            validator: _goalValidate,
                          ),
                          ProjectDrawUpInput(
                            title: "설명",
                            hint: "본 프로젝트를 설명할 내용을 기술하세요.",
                            controller: _descController,
                            focusNode: _descFocus,
                            validator: _descValidate,
                            length: 100,
                          ),
                          RuleInput(
                            title: "규칙",
                            hint: "규칙을 추가하세요. 항목은 최대 5개까지입니다.",
                            controller: _ruleController,
                            focusNode: _ruleFocus,
                          ),
                          GetPeriodUI(scheme: scheme),
                          getCategoryUI(),
                          Text("프로젝트 공개여부")
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  Row(
                    children: [
                      Expanded(child: ButtonUI(scheme: scheme, title: "생성")),
                      const SizedBox(),
                      Expanded(child: ButtonUI(scheme: scheme, title: "취소")),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getCategoryUI() {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        children: [
          Text("프로젝트 분류 선택"),
        ],
      ),
    );
  }

  String? _titleValidate(String? title) {
    return "";
  }

  String? _descValidate(String? title) {
    return "";
  }

  String? _goalValidate(String? title) {
    return "";
  }

  String? _ruleValidate(String? title) {
    return "";
  }

  String? _pwValidate(String? title) {
    return "";
  }
}
// const mstId = req.query.uid;
// const { title, category, prj_desc, goal, start_on, expire_on, pvt, prj_pw } = req.body;
