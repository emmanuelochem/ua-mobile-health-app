// import 'package:flutter/material.dart';
// import 'package:ua_mobile_health/doctors/users/user_details.dart';
// import 'package:ua_mobile_health/students/appointments/appointment_details.dart';
// import 'package:ua_mobile_health/students/appointments/book_appointments.dart';
// import 'package:ua_mobile_health/students/auth/login_page.dart';
// import 'package:ua_mobile_health/students/auth/register_page.dart';
// import 'package:ua_mobile_health/students/auth/splashscreen.dart';
// import 'package:ua_mobile_health/students/auth/welcome_page.dart';

// import 'package:ua_mobile_health/students/home/app_home.dart';

// class DoctorsRoutes {
//   static const String welcome = '/welcome';
//   static const String splash = '/splash';
//   static const String login = '/login';
//   static const String register = '/register';
//   static const String home = '/home';
//   static const String docDetails = '/doctor-details';
//   static const String bookAppointment = '/book-appointment';
//   static const String bookingSuccessful = '/book-success';
//   static const String appointmentDetails = '/appt-details';

//   static const String registerOtp = '/register-otp';
//   static const String registerInfo = '/register-info';
//   static const String registerPhone = '/register-phone';
//   static const String loginEmail = '/login-email';
//   static const String resetPassword = '/reset-pasword';
//   static const String registerNewAccount = '/register-new-acct';

//   static const String createInflow = '/create-inflow';

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case splash:
//         return MaterialPageRoute(builder: (_) => const SplashScreenPage());
//         break;
//       case welcome:
//         return MaterialPageRoute(builder: (_) => const WelcomePage());
//         break;
//       case login:
//         return MaterialPageRoute(builder: (_) => const LoginPage());
//         break;
//       case register:
//         return MaterialPageRoute(builder: (_) => const RegisterPage());
//         break;
   

//       case docDetails:
//         final Map args = settings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => DoctorsInfo(
//                   doctor: args['id'],
//                 ));
//         break;
//       case bookAppointment:
//         final Map args = settings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => BookingPage(
//                   doctorId: args['doctor'],
//                 ));
//         break;
//       case appointmentDetails:
//         final Map args = settings.arguments as Map;
//         return MaterialPageRoute(
//             builder: (_) => AppointentDetails(
//                   appointmentId: args['appointmentId'],
//                 ));
//         break;
//       // case getStarted:
//       //   return MaterialPageRoute(builder: (_) => const GettingStartedScreen());
//       // case registerNewAccount:
//       //   return MaterialPageRoute(builder: (_) => const RegisterNewAccount());
//       // case resetPassword:
//       //   return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
//       // case registerOtp:
//       //   final Map args = settings.arguments as Map;
//       //   return MaterialPageRoute(
//       //       builder: (_) => RegisterOTP(
//       //             phoneData: args['phoneData'],
//       //             accountData: args['accountData'],
//       //           ));
//       // case registerInfo:
//       //   final Map args = settings.arguments as Map;
//       //   return MaterialPageRoute(builder: (_) => const RegisterInfo());
//       // case home:
//       //   final Map args = settings.arguments as Map;
//       //   return MaterialPageRoute(builder: (_) => const HomePage());
//       // case createInflow:
//       //   final Map args = settings.arguments as Map;
//       //   return MaterialPageRoute(
//       //       builder: (_) =>
//       //           AddFlowRecord(recordFlowType: args['recordFlowType']));
//       default:
//         return MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: SafeArea(
//               child: Center(
//                 child: Text('Route not found.'),
//               ),
//             ),
//           ),
//         );
//     }
//   }
// }
