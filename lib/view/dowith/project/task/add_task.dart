import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/project/task/model/task_add_input_ui.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _taskSubCtrl = TextEditingController();
  final TextEditingController _taskDescCtrl = TextEditingController();

  final FocusNode _taskSubFocus = FocusNode();
  final FocusNode _taskDescFocus = FocusNode();

  bool isSelf = false;
  bool isCharge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("새 업무 생성"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 450),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TaskAddInputUI(
                    title: "업무명",
                    hint: "",
                    controller: _taskSubCtrl,
                    focusNode: _taskSubFocus,
                    validator: _titleValidate,
                    length: 20,
                  ),
                  TaskAddInputUI(
                    title: "업무 내용",
                    hint: "",
                    controller: _taskDescCtrl,
                    focusNode: _taskDescFocus,
                    validator: _descValidate,
                    length: 60,
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("업무 담당자")),
                      SizedBox(
                        child: Row(
                          children: [
                            Checkbox(
                              value: isSelf,
                              onChanged: (value) {
                                setState(() {
                                  isSelf = value!;
                                  isCharge = isSelf;
                                });
                              },
                            ),
                            Text("작성자와 동일"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  isCharge ? Row() : ElevatedButton(onPressed: () {}, child: const Text("추가")),
                  Text("할당"),
                  ElevatedButton(onPressed: () {}, child: Text("추가")),
                  Text("기간"),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 0.8,
          ),
          Row(
            children: [
              Expanded(child: buttonUI("생성", () {})),
              const VerticalDivider(width: 1),
              Expanded(child: buttonUI("취소", () => Navigator.pop(context))),
            ],
          )
        ],
      ),
    );
  }

  Widget buttonUI(String title, VoidCallback callback) {
    return InkWell(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5.0)),
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Center(child: Text(title)),
      ),
    );
  }
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

String? _descValidate(String? title) {
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
