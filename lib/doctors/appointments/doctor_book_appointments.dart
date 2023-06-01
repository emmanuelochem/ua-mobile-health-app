import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/utils/booking_date_converter.dart';
import 'package:ua_mobile_health/doctors/appointments/appointment_api.dart';
import 'package:ua_mobile_health/doctors/appointments/booking_successful.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/custom_appbar.dart';
import 'package:ua_mobile_health/widgets/snack_bar.dart';
import 'package:ua_mobile_health/widgets/text_input.dart';

class DoctorBookingPage extends StatefulWidget {
  const DoctorBookingPage({Key key, @required this.doctorId}) : super(key: key);
  final String doctorId;

  @override
  State<DoctorBookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<DoctorBookingPage> {
  //declaration
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (_currentDay.weekday == 6 || _currentDay.weekday == 7) {
      _isWeekend = true;
      _timeSelected = false;
      _currentIndex = null;
    } else {
      _isWeekend = false;
      checkAppointmentDate();
    }
  }

  bool checkingAppointment = false;
  bool _isLoading = false;
  List<String> bookedTime = [];

  String cleanupTime(String time) {
    var t = time.split(' ');
    var t2 = t[0];
    var t3 = t2.split(':');
    return t3[0];
  }

  Future<List> checkAppointmentDate() async {
    DoctorAppointmentApi appointmentApi = DoctorAppointmentApi();
    final date = DateConverted.getDate(_currentDay);
    setState(() {
      checkingAppointment = true;
    });
    var res = await appointmentApi
        .getDoctorAppointmentsByDate(
            context: context, doctorId: widget.doctorId, date: date)
        .then((value) {
      if (value != null) {
        List appointments = value['data'];
        bookedTime = [];
        for (var appointment in appointments) {
          if (!bookedTime.contains(cleanupTime(appointment['time']))) {
            bookedTime.add(cleanupTime(appointment['time']));
          }
        }
        setState(() {
          checkingAppointment = false;
        });
        return value['data'];
      } else {
        return null;
      }
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Book Appointment',
        icon: Icon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.01.sh,
                horizontal: 0.048.sw,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 0.018.sw,
                    ),
                    decoration: BoxDecoration(
                        color: UIColors.secondary500,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: _tableCalendar(),
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  _isWeekend
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          alignment: Alignment.center,
                          child: Text(
                            'Weekend appointments are not available.\n Please select another date',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: UIColors.secondary300,
                            ),
                          ),
                        )
                      : checkingAppointment
                          ? Center(
                              child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.03.sh),
                              child: const CircularProgressIndicator(),
                            ))
                          : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.02.sh, bottom: 0.01.sh),
                                  child: Center(
                                    child: Text(
                                      'Select Appointment Time',
                                      style:
                                          TypographyStyle.bodyMediumn.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                        color: UIColors.secondary200,
                                      ),
                                    ),
                                  ),
                                ),
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 8,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                          onTap: bookedTime.contains(
                                                  cleanupTime(
                                                      (index + 9).toString()))
                                              ? () {
                                                  GeneralLogics.showMessageNew(
                                                      'Sorry, an appointment has already been booked for this time on this date.',
                                                      FlushbarType.error,
                                                      context);
                                                }
                                              : () {
                                                  setState(() {
                                                    _currentIndex = index;
                                                    _timeSelected = true;
                                                  });
                                                },
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: bookedTime.contains(
                                                        _currentIndex
                                                            .toString())
                                                    ? UIColors.primary100
                                                        .withOpacity(.4)
                                                    : _currentIndex == index
                                                        ? Colors.white
                                                        : UIColors.secondary500,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: bookedTime.contains(
                                                      cleanupTime((index + 9)
                                                          .toString()))
                                                  ? UIColors.primary200
                                                      .withOpacity(.6)
                                                  : _currentIndex == index
                                                      ? UIColors.primary
                                                      : UIColors.secondary500,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: _currentIndex == index
                                                    ? Colors.white
                                                    : null,
                                              ),
                                            ),
                                          )),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 1.5,
                                  ),
                                ),
                                TextInputField(
                                  hintText: 'Leave a note for the doctor',
                                  textController: noteController,
                                  inputType: InputType.textarea,
                                ),
                              ],
                            ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _isWeekend
          ? const SizedBox()
          : Container(
              height: 0.093.sh,
              decoration: BoxDecoration(
                  color: UIColors.white,
                  border: Border(
                    top: BorderSide(color: UIColors.secondary500),
                  )),
              padding: EdgeInsets.symmetric(
                  horizontal: 0.048.sw, vertical: 0.028.sw),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ActionButton(
                    isLoading: _isLoading,
                    text: 'Book Appointment',
                    backgroundColor: UIColors.primary,
                    textColor: UIColors.white,
                    shape: ButtonShape.capsule,
                    size: ButtonSizes.large,
                    onPressed: _isWeekend
                        ? null
                        : () async {
                            final getDate = DateConverted.getDate(_currentDay);

                            final getTime =
                                DateConverted.getTime(_currentIndex);

                            Map<String, dynamic> data = {
                              "doctor": widget.doctorId,
                              "note": noteController.text,
                              "date": getDate.toString(),
                              "time": getTime.toString(),
                              "status": "pending",
                            };
                            //log(data.toString());

                            DoctorAppointmentApi appointmentApi =
                                DoctorAppointmentApi();

                            setState(() {
                              _isLoading = true;
                            });
                            var res = await appointmentApi.bookAppointment(
                                context: context, data: data);
                            if (res != null) {
                              if (context.mounted) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorAppointmentBooked(
                                                data: res, onContinue: null)));
                              }
                            }

                            setState(() {
                              _isLoading = false;
                            });
                          },
                  ),
                ],
              ),
            ),
    );
  }

  //table calendar
  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: CalendarStyle(
        todayDecoration:
            BoxDecoration(color: UIColors.primary, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          //check if weekend is selected
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
            checkAppointmentDate();
          }
        });
      }),
    );
  }
}
