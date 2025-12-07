
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case '/login-with-password':
        return MaterialPageRoute(builder: (_) => const LoginWithPasswordPage());
      case '/verify-otp':
        return MaterialPageRoute(
          builder: (_) {
            final String? code = settings.arguments as String?;
            return VerifyOtpPage(code: code);
          },
        );
      case '/set-password':
        return MaterialPageRoute(builder: (_) => const SetPasswordPage());
      case '/change-password':
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
      case '/driver-personal-info-page':
        final isUpdating = settings.arguments != null ? true : false;
        return MaterialPageRoute(
          builder: (_) => DriverPersonalInfoPage(isUpdatingProfile: isUpdating),
        );
      case '/profile-under-review':
        return MaterialPageRoute(builder: (_) => const ProfileUnderReview());
      case '/vehicle-info-page':
        return MaterialPageRoute(builder: (_) => const DriverDocumentsPage());
      case '/home-page':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/booking-page':
        return MaterialPageRoute(builder: (_) => const BookingPage());
      case '/chat-sheet':
        return MaterialPageRoute(builder: (_) => const ChatSheet());
      case '/profile-info-page':
        return MaterialPageRoute(builder: (_) => const ProfileInfoPage());
      case '/payout-method':
        return MaterialPageRoute(builder: (_) => const PayoutMethodView());
      case '/ride-history-page':
        return MaterialPageRoute(builder: (_) => const RideHistoryPage());
      case '/payment-methods':
        return MaterialPageRoute(builder: (_) => const PaymentMethodsPage());
      case '/wallets-page':
        return MaterialPageRoute(builder: (_) => const Wallet());
      case '/report-issue':
        final orderId = settings.arguments as int?;
        return MaterialPageRoute(builder: (_) => ReportIssueView(orderId));
      case '/ride-history-detail':
        final Order? order = settings.arguments as Order?;
        return MaterialPageRoute(
          builder: (_) => RideHistoryDetail(order: order),
        );
      case '/add-payment-gateway':
        return MaterialPageRoute(builder: (_) => const AddPaymentGateway());
      case '/no-internet':
        return MaterialPageRoute(builder: (_) => const NoInternetPage());
      case '/broken-page':
        return MaterialPageRoute(builder: (_) => const BrokenPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: ErrorView(message: 'No route defined for ${settings.name}'),
          ),
        );
    }
  }
}
