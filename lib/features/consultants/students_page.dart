import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/features/users/user_api.dart';
import 'package:ua_mobile_health/widgets/empty_data_notice.dart';
import 'package:ua_mobile_health/widgets/patients_profile_card.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({Key key}) : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage>
    with TickerProviderStateMixin {
  TabController _controller;
  bool isLoaded = false;
  List<dynamic> doctors = [];
  Future<List> getDoctors() async {
    setState(() {
      isLoaded = false;
    });
    UserApi messengerApi = UserApi();
    var res = await messengerApi
        .getStudents(
      context: context,
    )
        .then((value) {
      if (value != null) {
        setState(() {
          isLoaded = true;
          doctors = value['data'];
        });
        return value['data'];
      } else {
        return null;
      }
    });
    return res;
  }

  Future<List> futureData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: _tabNames.length);
    futureData = getDoctors();
  }

  final List _tabNames = [
    'My Patients',
    'All Students',
  ];
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    // _tabNames = [
    //   'Upcoming',
    //   'Past',
    // ];
    List alldoctors = [];
    List favourite = [];

    for (var item in doctors) {
      if (item['status'] == 'upcoming') {
        alldoctors.add(item);
      } else {
        favourite.add(item);
      }
    }
    return Scaffold(
      backgroundColor: UIColors.secondary600,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: UIColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Patients',
          style: TypographyStyle.heading5.copyWith(
            fontSize: 18.sp,
            color: UIColors.secondary,
          ),
        ),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: UIColors.primary,
          labelColor: UIColors.primary,
          unselectedLabelColor: Colors.black54,
          tabs: List.generate(
            _tabNames.length,
            (index) => Tab(text: _tabNames[index]),
          ),
          onTap: (index) {
            setState(() {
              activeTab = index;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0.058.sw, vertical: 0.058.sw),
        child: FutureBuilder(
            future: futureData,
            builder: (context, querySnapshot) {
              if (querySnapshot.hasError) {
                return const Text('Error occured');
              }
              if (querySnapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 0.7.sh,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: UIColors.primary,
                    ),
                  ),
                );
              } else {
                List doctorsData = querySnapshot.data ?? [];
                // print(list[0]['summary']);
                return doctorsData.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          EmptyDataNotice(
                            icon: IconlyBold.user_3,
                            message: 'Students not available at the moment.',
                          ),
                        ],
                      )
                    : Column(
                        children: List.generate(
                          doctorsData.length,
                          (index) => PatientsProfileCard(
                              appointment: doctorsData[index]),
                        ),
                      );
              }
            }),
      ),
    );
  }
}
