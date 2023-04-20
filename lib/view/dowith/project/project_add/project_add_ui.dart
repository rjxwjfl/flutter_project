import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_set_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/model/category_item.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/model/project_draw_up_input.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/model/button_ui.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/model/get_period_ui.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/model/rule_input.dart';
import 'package:flutter_dowith/view/dowith/project/project_navi_home.dart';
import 'package:flutter_dowith/view/splash/login_signup_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  final FocusNode _goalFocus = FocusNode();
  final FocusNode _ruleFocus = FocusNode();

  late final AnimationController _animationController;

  final _formKey = GlobalKey<FormState>();

  final ProjectRepository _repository = ProjectRepository();

  Future<int?> drawUpPrj(String title, int category, String prjDesc, String goal, bool pvt, bool period,
      DateTime? start, DateTime? end) async {
    ProjectSetModel model = ProjectSetModel(
        title: title, category: category, prjDesc: prjDesc, goal: goal, pvt: pvt, startOn: start, expireOn: end);

    int? userId = prefs.getInt('user_id');
    if (period) {
      // period => only check state
      model.startOn = null;
      model.expireOn = null;
      print(model);
    }
    if (userId == null) {
      return null;
    }
    int prjId = await _repository.createProject(userId, model);
    return prjId;
  }

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
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
                            setPrivate()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Consumer(builder: (context, ref, child) {
                  var refs = ref.watch(drawUp);
                  return Container(
                    color: scheme.background,
                    child: Row(
                      children: [
                        Expanded(
                            child: ButtonUI(
                          scheme: scheme,
                          title: "생성",
                          callback: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            if (refs.selectedCategory == null) {
                              showSnackBar(context, "카테고리를 선택해주세요.");
                              return;
                            }
                            drawUpPrj(_titleController.text, refs.selectedCategory!, _descController.text,
                                    _goalController.text, refs.isPrivate, refs.period, refs.initDate, refs.endDate)
                                .then((value) {
                              if (value == null) {
                                Navigator.push(
                                    context, CupertinoPageRoute(builder: (context) => const LoginSignUpScreen()));
                                return;
                              }
                              Navigator.pop(context);
                              showSnackBar(context, "프로젝트가 생성되었습니다.");
                              Navigator.push(
                                  context, CupertinoPageRoute(builder: (context) => ProjectNaviHome(prjId: value)));
                            });
                          },
                        )),
                        const SizedBox(),
                        Expanded(
                            child: ButtonUI(
                          scheme: scheme,
                          title: "취소",
                          callback: () {
                            Navigator.pop(context);
                          },
                        )),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getCategoryUI() {
    return Consumer(builder: (context, ref, child) {
      var refs = ref.watch(drawUp);
      return Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("프로젝트 분류 선택"),
            GridView.builder(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 1.2,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 10,
                ),
                itemCount: refs.category.length,
                itemBuilder: (context, index) {
                  String title = refs.category.keys.elementAt(index);
                  IconData icon = refs.category[title]!;
                  return CategoryItem(
                    title: title,
                    icon: icon,
                    selectState: refs.gridSwitch[index],
                    callback: () {
                      refs.setCategory(index);
                    },
                  );
                })
          ],
        ),
      );
    });
  }

  Widget setPrivate() {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Consumer(builder: (context, ref, child) {
      var refs = ref.watch(drawUp);
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)), border: Border.all(color: scheme.primary)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: refs.isPrivate
                    ? Icon(
                        FontAwesomeIcons.lock,
                        size: 40,
                        color: scheme.primary,
                      )
                    : Icon(
                        FontAwesomeIcons.lockOpen,
                        size: 40,
                        color: scheme.primary,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Text("이 프로젝트는 ${refs.isPrivate ? "비공개" : "공개"} 프로젝트입니다."),
          ),
          IconButton(
            onPressed: () {
              refs.isPrivate = !refs.isPrivate;
            },
            style: IconButton.styleFrom(shape: const CircleBorder()),
            icon: const Icon(FontAwesomeIcons.arrowsRotate),
          ),
        ],
      );
    });
  }

  String? _titleValidate(String? title) {
    if (title == null || title.isEmpty) {
      return "제목을 입력해주세요.";
    }
    if (title.length > 20) {
      return "제목은 20자 이내로 작성해주세요.";
    }
    if (title.trimLeft() != title) {
      return "첫 글자는 공백이 올 수 없습니다.";
    }
    if (!RegExp(r'^[a-zA-Z0-9ㄱ-ㅎ가-힣]*$').hasMatch(title)) {
      return "특수문자는 사용할 수 없습니다.";
    }
    return null;
  }

  String? _descValidate(String? desc) {
    if (desc == null || desc.isEmpty) {
      return '내용을 입력해주세요.';
    }
    if (desc.length > 100) {
      return '글자 수는 100자 이하여야 합니다.';
    }
    if (desc.trimLeft().isEmpty) {
      return '첫글자에 공백이 올 수 없습니다.';
    }
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(desc)) {
      return '특수문자를 사용할 수 없습니다.';
    }
    return null;
  }

  String? _goalValidate(String? goal) {
    if (goal == null || goal.isEmpty) {
      return '목표를 입력해주세요';
    }
    if (goal.length > 50) {
      return '50자 이내로 입력해주세요';
    }
    if (goal.startsWith(' ')) {
      return '첫 글자에 공백이 올 수 없습니다';
    }
    if (goal.contains(new RegExp(r'[^\w\s]+'))) {
      return '특수문자를 사용할 수 없습니다';
    }
    if (goal.contains(new RegExp(r'\s{2,}'))) {
      return '공백이 연속으로 존재할 수 없습니다';
    }
    return null;
  }

  void showSnackBar(context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
        elevation: 30,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    );
  }
}
