import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ua_mobile_health/core/logics/generalLogics.dart';
import 'package:ua_mobile_health/core/providers/doctor_data_provider.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/utils/booking_date_converter.dart';
import 'package:ua_mobile_health/features/booking/appointment_api.dart';
import 'package:ua_mobile_health/features/booking/booking_successful.dart';
import 'package:ua_mobile_health/routes.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';
import 'package:ua_mobile_health/widgets/custom_appbar.dart';
import 'package:ua_mobile_health/widgets/dropdown_input.dart';
import 'package:ua_mobile_health/widgets/dropdown_model.dart';
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
  DoctorDataProvider doctorDataProvider;

  @override
  void initState() {
    super.initState();
    doctorDataProvider = context.read<DoctorDataProvider>();
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

  final _urgencyLevel = TextEditingController();

  List<DropdownModel> urgencyList = [
    DropdownModel(name: 'Normal', value: 'normal'),
    DropdownModel(name: 'Urgent', value: 'urgent'),
    DropdownModel(name: 'Very urgent', value: 'very urgent'),
    DropdownModel(name: 'Critical', value: 'critical'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.white,
      appBar: const CustomAppBar(
        appTitle: 'Book Appointment',
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
                        color: UIColors.white,
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
                              child: CircularProgressIndicator(
                                color: UIColors.primary,
                              ),
                            ))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.02.sh, bottom: 0.015.sh),
                                  child: Text(
                                    'Appointment time',
                                    style: TypographyStyle.heading5.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                      color: UIColors.secondary200,
                                    ),
                                  ),
                                ),
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 6,
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
                                            margin: EdgeInsets.symmetric(
                                                vertical: 0.01.sh,
                                                horizontal: 0.008.sh),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: bookedTime.contains(
                                                        _currentIndex
                                                            .toString())
                                                    ? UIColors.primary100
                                                        .withOpacity(.4)
                                                    : _currentIndex == index
                                                        ? Colors.white
                                                        : UIColors.secondary600,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: bookedTime.contains(
                                                      cleanupTime((index + 9)
                                                          .toString()))
                                                  ? UIColors.primary200
                                                      .withOpacity(.6)
                                                  : _currentIndex == index
                                                      ? UIColors.primary
                                                      : UIColors.secondary600,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${index + 9}:30 ${index + 9 > 11 ? "PM" : "AM"}',
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
                                    crossAxisCount: 3,
                                    childAspectRatio: 2,
                                  ),
                                ),
                                DropDownInput(
                                  enabled: !_isLoading,
                                  //fieldTitle: 'Urgency level',
                                  hintText: 'Urgency level',
                                  sheetTitle: 'Urgency level',
                                  showSearch: false,
                                  searchPlaceholder:
                                      'Search urgency level here',
                                  optionsList: urgencyList,
                                  validator: (val) {
                                    if (val == null || val.value.isEmpty) {
                                      return 'Faculty is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _urgencyLevel.text = value.name;
                                      //print(brandController.text);
                                    });

                                    return value;
                                  },
                                ),
                                TextInputField(
                                  hintText: 'Leave a note for the doctor',
                                  textController: noteController,
                                  inputType: InputType.textarea,
                                ),
                                SizedBox(
                                  height: 0.2.sh,
                                )
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
                              "date": getDate,
                              "time": getTime,
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
                                GeneralLogics.setDoctorData(
                                    doctorDataProvider, res['userData']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorAppointmentBooked(
                                              data: res,
                                              onContinue: () {
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        Routes.home,
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              },
                                            )));
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
      rowHeight: 0.06.sh,
      daysOfWeekHeight: 0.045.sh,
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle: TypographyStyle.bodyLarge.copyWith(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        leftChevronMargin: EdgeInsets.zero,
        rightChevronMargin: EdgeInsets.zero,
        leftChevronIcon: Icon(
          PhosphorIcons.caret_left_bold,
          color: UIColors.primary,
        ),
        rightChevronIcon: Icon(
          PhosphorIcons.caret_right_bold,
          color: UIColors.primary,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TypographyStyle.bodySmall.copyWith(
          color: UIColors.secondary300,
          height: 0,
        ),
        weekendStyle: TypographyStyle.bodySmall.copyWith(
          color: UIColors.secondary300,
          height: 0,
        ),
      ),
      calendarStyle: CalendarStyle(
        disabledTextStyle: TypographyStyle.bodyMediumn.copyWith(
          color: UIColors.secondary400,
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        defaultTextStyle: TypographyStyle.bodyMediumn.copyWith(
          color: UIColors.secondary100,
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        weekendTextStyle: TypographyStyle.bodyMediumn.copyWith(
          color: UIColors.secondary100,
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        todayDecoration: BoxDecoration(
          color: UIColors.primary,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TypographyStyle.bodyMediumn.copyWith(
          color: UIColors.white,
          fontWeight: FontWeight.w600,
          height: 0,
        ),
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
