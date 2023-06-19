import 'package:flutter/material.dart';
import 'package:ua_mobile_health/features/booking/doctor_appointment_details.dart';
import 'package:ua_mobile_health/features/booking/doctor_book_appointments.dart';
import 'package:ua_mobile_health/features/auth/doctor_login_page.dart';
import 'package:ua_mobile_health/features/auth/doctor_register_page.dart';
import 'package:ua_mobile_health/features/auth/doctor_splashscreen.dart';
import 'package:ua_mobile_health/features/auth/doctor_welcome_page.dart';
import 'package:ua_mobile_health/features/home/doctor_dashboard.dart';
import 'package:ua_mobile_health/features/patients/consultant_details.dart';

class Routes {
  static const String welcome = '/welcome';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String docDetails = '/doctor-details';
  static const String bookAppointment = '/book-appointment';
  static const String bookingSuccessful = '/book-success';
  static const String appointmentDetails = '/appt-details';

  static const String registerOtp = '/register-otp';
  static const String registerInfo = '/register-info';
  static const String registerPhone = '/register-phone';
  static const String loginEmail = '/login-email';
  static const String resetPassword = '/reset-pasword';
  static const String registerNewAccount = '/register-new-acct';

  static const String createInflow = '/create-inflow';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
            builder: (_) => const DoctorSplashScreenPage());
        break;
      case welcome:
        return MaterialPageRoute(builder: (_) => const DoctorWelcomePage());
        break;
      case login:
        return MaterialPageRoute(builder: (_) => const DoctorLoginPage());
        break;
      case register:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => DoctorRegisterPage(
                  isStudent: args['isStudent'],
                ));
        break;
      case home:
        return MaterialPageRoute(builder: (_) => const DoctorDashboardPage());
        break;

      case appointmentDetails:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => DoctorAppointentDetails(
                  appointmentId: args['appointmentId'],
                ));
        break;
      case docDetails:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => UserDetailsPage(
                  doctor: args['id'],
                ));
        break;
      case bookAppointment:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => DoctorBookingPage(
                  doctorId: args['doctor'],
                ));
        break;
      // case getStarted:
      //   return MaterialPageRoute(builder: (_) => const GettingStartedScreen());
      // case registerNewAccount:
      //   return MaterialPageRoute(builder: (_) => const RegisterNewAccount());
      // case resetPassword:
      //   return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      // case registerOtp:
      //   final Map args = settings.arguments as Map;
      //   return MaterialPageRoute(
      //       builder: (_) => RegisterOTP(
      //             phoneData: args['phoneData'],
      //             accountData: args['accountData'],
      //           ));
      // case registerInfo:
      //   final Map args = settings.arguments as Map;
      //   return MaterialPageRoute(builder: (_) => const RegisterInfo());
      // case home:
      //   final Map args = settings.arguments as Map;
      //   return MaterialPageRoute(builder: (_) => const HomePage());
      // case createInflow:
      //   final Map args = settings.arguments as Map;
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           AddFlowRecord(recordFlowType: args['recordFlowType']));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: SafeArea(
              child: Center(
                child: Text('Route not found.'),
              ),
            ),
          ),
        );
    }
  }
}
