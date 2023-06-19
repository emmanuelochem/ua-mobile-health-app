// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconly/iconly.dart';
// import 'package:ua_mobile_health/core/ui/ui_colors.dart';
// import 'package:ua_mobile_health/core/ui/typography_style.dart';
// import 'package:ua_mobile_health/doctors/users/user_api.dart';
// import 'package:ua_mobile_health/doctors_routes.dart';
// import 'package:ua_mobile_health/widgets/doctor_tile.dart';
// import 'package:ua_mobile_health/widgets/empty_data_notice.dart';

// class DoctorsPage extends StatefulWidget {
//   const DoctorsPage({Key key}) : super(key: key);

//   @override
//   State<DoctorsPage> createState() => _DoctorsPageState();
// }

// class _DoctorsPageState extends State<DoctorsPage>
//     with TickerProviderStateMixin {
//   TabController _controller;
//   bool isLoaded = false;
//   List<dynamic> doctors = [];
//   Future<List> getDoctors() async {
//     setState(() {
//       isLoaded = false;
//     });
//     UserApi messengerApi = UserApi();
//     var res = await messengerApi
//         .getDoctors(
//       context: context,
//     )
//         .then((value) {
//       if (value != null) {
//         setState(() {
//           isLoaded = true;
//           doctors = value['data'];
//         });
//         return value['data'];
//       } else {
//         return null;
//       }
//     });
//     return res;
//   }

//   Future<List> futureData;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = TabController(vsync: this, length: _tabNames.length);
//     futureData = getDoctors();
//   }

//   final List _tabNames = [
//     'All',
//     'Favourite',
//   ];
//   int activeTab = 0;
//   @override
//   Widget build(BuildContext context) {
//     List alldoctors = [];
//     List favourite = [];

//     for (var item in doctors) {
//       if (item['status'] == 'upcoming') {
//         alldoctors.add(item);
//       } else {
//         favourite.add(item);
//       }
//     }
//     return DefaultTabController(
//       length: _tabNames.length,
//       initialIndex: activeTab,
//       child: Scaffold(
//         backgroundColor: UIColors.secondary600,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: UIColors.primary,
//           elevation: 0,
//           centerTitle: false,
//           title: Text(
//             'Doctors',
//             style: TypographyStyle.heading2
//                 .copyWith(color: Colors.white, fontSize: 23.sp),
//           ),
//           bottom: TabBar(
//             indicatorColor: Colors.white,
//             tabs: List.generate(
//               _tabNames.length,
//               (index) => Tab(text: _tabNames[index]),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           padding:
//               EdgeInsets.symmetric(horizontal: 0.058.sw, vertical: 0.058.sw),
//           child: FutureBuilder(
//               future: futureData,
//               builder: (context, querySnapshot) {
//                 if (querySnapshot.hasError) {
//                   return const Text('Error occured');
//                 }
//                 if (querySnapshot.connectionState == ConnectionState.waiting) {
//                   return SizedBox(
//                     height: 0.7.sh,
//                     child: Center(
//                       child: CircularProgressIndicator(
//                         color: UIColors.primary,
//                       ),
//                     ),
//                   );
//                 } else {
//                   List doctorsData = querySnapshot.data ?? [];
//                   // print(list[0]['summary']);
//                   return doctorsData.isEmpty
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             EmptyDataNotice(
//                               icon: IconlyBold.user_3,
//                               message: 'Doctors not available at the moment.',
//                             ),
//                           ],
//                         )
//                       : Column(
//                           children: List.generate(
//                             doctorsData.length,
//                             (index) => DoctorTile(
//                               doctor: doctorsData[index],
//                             ),
//                           ),
//                         );
//                 }
//               }),
//         ),
//       ),
//     );
//   }
// }

// class TopDoctorCard extends StatelessWidget {
//   Map doctor;

//   TopDoctorCard({
//     Key key,
//     @required this.doctor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(
//           context,
//           Routes.docDetails,
//           arguments: <String, dynamic>{'id': doctor['_id']},
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 0.02.sh),
//         decoration: BoxDecoration(
//           color: UIColors.white,
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         child: Row(
//           children: [
//             Container(
//               //height: 0.12.sh,
//               decoration: BoxDecoration(
//                   color: UIColors.primary,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10.r),
//                     bottomLeft: Radius.circular(10.r),
//                   )),
//               child: doctor['photo'] == null
//                   ? Padding(
//                       padding: EdgeInsets.all(0.015.sh),
//                       child: Icon(
//                         IconlyBold.profile,
//                         size: 0.14.sw,
//                         color: UIColors.white,
//                       ),
//                     )
//                   : Image(
//                       width: 0.24.sw,
//                       image: AssetImage(doctor['photo']),
//                     ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('${doctor['firstname']} ${doctor['lastname']}',
//                       style: TypographyStyle.heading5),
//                   SizedBox(
//                     height: 0.000.sh,
//                   ),
//                   Text(
//                     doctor['specialization'],
//                     style: TypographyStyle.bodySmall,
//                   ),
//                   // SizedBox(
//                   //   height: 0.02.sh,
//                   // ),
//                   // SizedBox(
//                   //   width: 0.5.sw,
//                   //   child: Row(
//                   //     children: [
//                   //       Expanded(
//                   //         child: Row(
//                   //           crossAxisAlignment: CrossAxisAlignment.center,
//                   //           children: [
//                   //             Icon(
//                   //               IconlyBold.star,
//                   //               color: UIColors.secondary300,
//                   //               size: 0.015.sh,
//                   //             ),
//                   //             SizedBox(
//                   //               width: 0.015.sw,
//                   //             ),
//                   //             Text(
//                   //               'Monday',
//                   //               style: TypographyStyle.bodySmall,
//                   //             )
//                   //           ],
//                   //         ),
//                   //       ),
//                   //       Expanded(
//                   //         child: Row(
//                   //           crossAxisAlignment: CrossAxisAlignment.center,
//                   //           mainAxisAlignment: MainAxisAlignment.start,
//                   //           children: [
//                   //             Icon(
//                   //               IconlyBold.time_circle,
//                   //               color: UIColors.secondary300,
//                   //               size: 0.015.sh,
//                   //             ),
//                   //             SizedBox(
//                   //               width: 0.015.sw,
//                   //             ),
//                   //             Text(
//                   //               '^pm',
//                   //               style: TypographyStyle.bodySmall,
//                   //             )
//                   //           ],
//                   //         ),
//                   //       )
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
