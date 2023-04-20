import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/sqflite_bloc/personal_data/sql_model.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/todo/model/input_field.dart';
import 'package:intl/intl.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({required this.today, Key? key}) : super(key: key);
  final DateTime today;

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  late DateTime _startDate;
  late DateTime _endDate;
  TimeOfDay? _startAt;
  TimeOfDay? _expireIn;
  late String _startAtString;
  late String _expireInString;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleEditController = TextEditingController();
  final TextEditingController _contentEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startDate = widget.today;
    _endDate = widget.today.add(const Duration(hours: 1));
    _startAtString = DateFormat("hh:mm a").format(_startDate).toString();
    _expireInString = DateFormat("hh:mm a").format(_endDate).toString();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Edit Page",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InputField(
                  title: "Title",
                  hint: "제목을 입력하세요.",
                  multiLine: false,
                  controller: _titleEditController,
                ),
                InputField(
                  title: "Content",
                  hint: "내용을 입력하세요.",
                  multiLine: true,
                  controller: _contentEditController,
                ),
                InputField(
                    title: "DatePicker",
                    hint: DateFormat("yyyy년 MM월 dd일")
                        .format(_startDate)
                        .toString(),
                    multiLine: false,
                    widget: IconButton(
                        onPressed: () {
                          _getDatePicker();
                        },
                        icon: const Icon(Icons.calendar_today))),
                Row(
                  children: [
                    Expanded(
                        child: InputField(
                            title: "Start At",
                            hint: _startAtString,
                            multiLine: false,
                            widget: IconButton(
                                onPressed: () {
                                  _getTimePicker(isStartAt: true);
                                },
                                icon: const Icon(Icons.access_time)))),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InputField(
                          title: "Expire In",
                          hint: _expireInString,
                          multiLine: false,
                          widget: IconButton(
                              onPressed: () {
                                _getTimePicker(isStartAt: false);
                              },
                              icon: const Icon(Icons.access_time_filled))),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    _addScheduleToDb();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 52,
                    width: 208,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                    color: scheme.primary),
                    child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 20, color: scheme.onPrimary),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getDatePicker() async {
    DateTime? pickedDate =
    await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
        print(pickedDate);
      });
    }
  }

  _getTimePicker({required bool isStartAt}) async {
    var pickedTime = await _showTimePicker();
    // ignore: use_build_context_synchronously
    String timeForm = pickedTime.format(context);
    if (pickedTime == null) {} else if (isStartAt == true) {
      setState(() {
        _startAt = pickedTime;
        _startAtString = timeForm;
      });
    } else if (isStartAt == false) {
      setState(() {
        _expireIn = pickedTime;
        _expireInString = timeForm;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startAtString.split(":")[0]),
            minute: int.parse(_startAtString.split(":")[1].split(" ")[0])));
  }

  _addScheduleToDb() {
    final task = SqlModel(
        title: _titleEditController.text,
        content: _contentEditController.text,
        author: "ME",
        state: TodoState.scheduled,
        createAt: DateTime.now(),
        startOn: _startDate,
        expireOn: _endDate);
    bloc.insertData(task);
  }
}
