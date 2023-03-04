import 'package:carezone/models/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/task_controller.dart';
import '../../resourses/Color_manager.dart';
import '../../resourses/styles_manager.dart';
import '../../resourses/values_manager.dart';
import '../widget/button.dart';
import '../widget/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind = 0;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly'];

  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Add Reminder',
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: AppSize.s20)),
              InputField(
                title: 'Medicament Name',
                hint: 'Enter Name Here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter Note Here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _getDateFromUser();
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: ColorManager.black,
                  ),
                ),
              ),
              InputField(
                title: 'Start Time',
                hint: _startTime,
                widget: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _getTimeFromUser();
                  },
                  icon: Icon(
                    Icons.access_time_rounded,
                    color: ColorManager.black,
                  ),
                ),
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                widget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: remindList
                          .map<DropdownMenuItem<String>>(
                            (int value) => DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text('$value',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: AppSize.s14)),
                            ),
                          )
                          .toList(),
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: ColorManager.black),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(height: 0),
                      style: getRegularStyle(color: ColorManager.grey),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ),
              InputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: repeatList
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: AppSize.s14)),
                            ),
                          )
                          .toList(),
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: ColorManager.black),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(height: 0),
                      style: getRegularStyle(color: ColorManager.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: _colorPalette()),
                  Expanded(
                    flex: 2,
                    child: MyButton(
                      label: 'Create Task',
                      onTap: () {
                        _validateDate();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    FocusScope.of(context).unfocus();
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasksToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('required', 'All fields are required!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.teal.withOpacity(.7),
          colorText: ColorManager.white,
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
          margin: const EdgeInsets.all(8));
    } else
      print('############ SOMETHING BAD HAPPENED #################');
  }

  _addTasksToDb() async {
    try {
      //print('here is the selected month ${_selectedDate.month}');
      //print('here is the selected day ${_selectedDate.day}');
      int value = await _taskController.addTask(
        task: Task(
          title: _titleController.text,
          note: _noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          color: _selectedColor,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
        ),
      );
      print('id value = $value');
    } catch (e) {
      print('Error = $e');
    }
  }

  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color',
            style:
                getBoldStyle(color: ColorManager.black, fontSize: AppSize.s18)),
        const SizedBox(height: 8),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  child: _selectedColor == index
                      ? const Icon(Icons.done, size: 16, color: Colors.white)
                      : null,
                  backgroundColor: index == 0
                      ? ColorManager.grey
                      : index == 1
                          ? Colors.blue
                          : Colors.brown,
                  radius: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (_pickedDate != null)
      setState(() => _selectedDate = _pickedDate);
    else
      print('It\'s null or something is wrong');
  }

  _getTimeFromUser() async {
    TimeOfDay? _pickedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if (_pickedTime == null) {
      return;
    }
    String _formattedTime = _pickedTime.format(context);

    setState(() => _startTime = _formattedTime);
  }
}

AppBar appBar() {
  return AppBar(
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: Icon(
        Icons.arrow_back_ios,
        size: 26,
        color: ColorManager.black,
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.white,
  );
}
