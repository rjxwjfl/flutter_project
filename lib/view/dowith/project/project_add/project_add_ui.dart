import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/project/model/project_add_inputfield.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/model/button_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ProjectAddUI extends StatefulWidget {
  const ProjectAddUI({Key? key}) : super(key: key);

  @override
  State<ProjectAddUI> createState() => _ProjectAddUIState();
}

class _ProjectAddUIState extends State<ProjectAddUI> with TickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _prjPwController = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  final FocusNode _goalFocus = FocusNode();
  final FocusNode _prjPwFocus = FocusNode();

  DateTime? initDate;
  DateTime? expireDate;
  bool periodExist = true;

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
                    constraints: const BoxConstraints(
                      maxHeight: 400
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProjectAddInputField(
                            title: "프로젝트 제목",
                            hint: "프로젝트의 제목을 입력하세요.",
                            controller: _titleController,
                            focusNode: _titleFocus,
                            validator: _titleValidate,
                            length: 20,
                          ),
                          ProjectAddInputField(
                            title: "설명",
                            hint: "프로젝트의 내용을 설명해주세요.",
                            controller: _descController,
                            focusNode: _descFocus,
                            validator: _descValidate,
                            length: 100,
                          ),
                          Text("프로젝트 목표"),
                          getPeriodUI(),
                          getCategoryUI(),
                          Text("프로젝트 규칙"),
                          Text("프로젝트 공개여부")
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonUI(scheme: scheme, title: "생성")
                      ),
                      const SizedBox(),
                      Expanded(
                        child: ButtonUI(scheme: scheme, title: "취소")
                      ),
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

  Widget getPeriodUI() {
    ColorScheme scheme = Theme.of(context).colorScheme;
    DateFormat formatter = DateFormat("yy MM/dd");
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("기간 (선택)"),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                TextButton(
                  style: ElevatedButton.styleFrom(side: BorderSide(color: periodExist ? scheme.primary : scheme.outline)),
                  onPressed: periodExist
                      ? () async {
                          initDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000, 1, 1),
                              lastDate: DateTime(2100, 12, 31));
                        }
                      : null,
                  child: Text("${initDate ?? formatter.format(DateTime.now())}"),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: SizedBox(
                    child: Text("-"),
                  ),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(side: BorderSide(color: periodExist ? scheme.primary : scheme.outline)),
                  onPressed: periodExist
                      ? () async {
                          expireDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000, 1, 1),
                              lastDate: DateTime(2100, 12, 31));
                        }
                      : null,
                  child: Text("${expireDate ?? formatter.format(DateTime.now())}"),
                ),
                Expanded(
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Transform.scale(
                            scale: 0.7,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                              value: !periodExist,
                              onChanged: (value) {
                                setState(() {
                                  periodExist = !periodExist;
                                });
                                print(periodExist);
                              },
                            ),
                          ),
                        ),
                        Text("기간 없음")
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getCategoryUI() {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        children: [
          Text("카테고리 선택"),

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

  String? _pwValidate(String? title) {
    return "";
  }
}
// const mstId = req.query.uid;
// const { title, category, prj_desc, goal, start_on, expire_on, pvt, prj_pw } = req.body;
