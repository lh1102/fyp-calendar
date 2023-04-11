import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:fyp_calendar_2/controllers/task_controller.dart';
import 'package:fyp_calendar_2/ui/widgets/button.dart';
import 'package:get/get.dart';
import 'add_event_page.dart';
import 'ocr_scanner.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarScreenState();
  }
}

class CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  List<NeatCleanCalendarEvent> _todaysEvents = [];

  @override
  void initState() {
    print("initState Called");

    addTaskToList();
  }

  @override
  Widget build(BuildContext context) {
    //_addTaskToList();
    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
        child: Calendar(
          startOnMonday: false,
          weekDays: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
          eventsList: _todaysEvents,
          isExpandable: true,
          eventDoneColor: Colors.green,
          selectedColor: Colors.blueGrey[700],
          selectedTodayColor: Colors.pinkAccent,
          todayColor: Colors.redAccent,
          eventColor: null,
          locale: 'en_EN',
          todayButtonText: "TODAY",
          allDayEventText: 'All Day',
          multiDayEndText: 'End',
          isExpanded: true,
          expandableDateFormat: 'EEEE, dd. MMMM yyyy',
          onEventSelected: (value) {
            print('Event selected ${value.summary}');
            print("Press after:");
            print(_taskController.taskList.length);
            _taskController.getTask();
            //addTaskToList();
            print("PRINT THE LIST OF _todayList: ${_todaysEvents}");
          },
          onEventLongPressed: (value) {
            print('Event long pressed ${value.summary}');
          },
          datePickerType: DatePickerType.date,
          dayOfWeekStyle: TextStyle(
              color: Colors.pinkAccent,
              fontWeight: FontWeight.w800,
              fontSize: 11),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () async {
              await Get.to(() => AddEvent());
            },
            child: const Icon(
              Icons.add,
              color: Colors.pinkAccent,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () async {
              await Get.to(() => Ocr_Screen());
            },
            child: const Icon(
              Icons.camera,
              color: Colors.pinkAccent,
            ),
          ),
        ],
      ),
    );
  }

  void addTaskToList() async {
    int? _id;
    String? _title;
    String? _note;
    String? _holdDate;
    int? _dDate;
    int? _mDate;
    int? _yDate;
    String? _holdStartTime;
    int? _hourStartTime;
    int? _minStartTime;
    String? _holdEndTime;
    int? _hourEndTime;
    int? _minEndTime;
    String? _apmStartTime;
    String? _apmEndTime;
    int? _holdColor;
    Color? _color;

    _todaysEvents.clear();
    print("Update List Functin called");
    print("Here is first _todayEvents list: $_todaysEvents");

    Future<List<Map<String, dynamic>>> _taskListFromDB =
    _taskController.getTaskToEventList();
    List _notFutureListOfTask = await _taskListFromDB;

    print("the taskListFromDB length is: ${_notFutureListOfTask}");
    print("the _taskListFromDB length is: ${_notFutureListOfTask.length}");

    int _lengthOfList = _notFutureListOfTask.length;
    //taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    print("Here is addTaskToList function");
    for (var r = 0; r < _lengthOfList; r++) {
      //split the List<Map> elements into specific variable
      _id = _notFutureListOfTask[r]["id"];
      _title = _notFutureListOfTask[r]["title"].toString();
      _note = _notFutureListOfTask[r]["note"].toString();
      _holdDate = _notFutureListOfTask[r]["date"];
      _dDate = int.parse(_holdDate!.split("/")[1]);
      _mDate = int.parse(_holdDate!.split("/")[0]);
      _yDate = int.parse(_holdDate!.split("/")[2]);

      //convert and split the startTime to fulfill NeatCleanEvent format, and 12 hours format convert to 24 hours format
      _holdStartTime = _notFutureListOfTask[r]["startTime"];
      _apmStartTime = _holdStartTime!.split(" ")[1];
      if (_apmStartTime == "PM") {
        _hourStartTime = int.parse(_holdStartTime!.split(":")[0]) + 12;
      } else {
        _hourStartTime = int.parse(_holdStartTime!.split(":")[0]);
      }
      _minStartTime = int.parse(_holdStartTime!.split(":")[1].split(" ")[0]);

      //convert and split the endTime to fulfill NeatCleanEvent format, and 12 hours format convert to 24 hours format
      _holdEndTime = _notFutureListOfTask[r]["endTime"];
      _apmEndTime = _holdEndTime!.split(" ")[1];
      if (_apmEndTime == "PM") {
        _hourEndTime = int.parse(_holdEndTime!.split(":")[0]) + 12;
      } else {
        _hourEndTime = int.parse(_holdEndTime!.split(":")[0]);
      }
      _minEndTime = int.parse(_holdEndTime!.split(":")[1].split(" ")[0]);

      //color: 0 = blue; 1 = pink; 2 = orange; other = blueGrey
      _holdColor = _notFutureListOfTask[r]["color"];
      _holdColor == 0 ? _color = Colors.blue[700] : _holdColor == 1 ? _color = Colors.pink : _holdColor == 2 ? _color = Colors.orange : _color = Colors.blueGrey[700];

      _todaysEvents.add(NeatCleanCalendarEvent(
        _title,
        description: _note,
        startTime:
        DateTime(_yDate, _mDate, _dDate, _hourStartTime, _minStartTime),
        endTime:
        DateTime(_yDate, _mDate, _dDate, _hourEndTime, _minEndTime),
        color: _color,
      ));
    } //forLoop
  }
}
