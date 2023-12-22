import 'package:get/get.dart';

import '../modules/accept_trip/bindings/accept_trip_binding.dart';
import '../modules/accept_trip/views/accept_trip_view.dart';
import '../modules/cashflow/bindings/cashflow_binding.dart';
import '../modules/cashflow/views/cashflow_view.dart';
import '../modules/detail_history/bindings/detail_history_binding.dart';
import '../modules/detail_history/views/detail_history_view.dart';
import '../modules/empty_trip/bindings/empty_trip_binding.dart';
import '../modules/empty_trip/views/empty_trip_view.dart';
import '../modules/history_trip/bindings/history_trip_binding.dart';
import '../modules/history_trip/views/history_trip_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_trip/bindings/list_trip_binding.dart';
import '../modules/list_trip/views/list_trip_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/odometer/bindings/odometer_binding.dart';
import '../modules/odometer/views/odometer_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/trip/bindings/trip_binding.dart';
import '../modules/trip/views/trip_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ODOMETER,
      page: () => const OdometerView(),
      binding: OdometerBinding(),
    ),
    GetPage(
      name: _Paths.TRIP,
      page: () => const TripView(),
      binding: TripBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_TRIP,
      page: () => const HistoryTripView(),
      binding: HistoryTripBinding(),
    ),
    GetPage(
      name: _Paths.EMPTY_TRIP,
      page: () => const EmptyTripView(),
      binding: EmptyTripBinding(),
    ),
    GetPage(
      name: _Paths.ACCEPT_TRIP,
      page: () => const AcceptTripView(),
      binding: AcceptTripBinding(),
    ),
    GetPage(
      name: _Paths.CASHFLOW,
      page: () => const CashflowView(),
      binding: CashflowBinding(),
    ),
    GetPage(
      name: _Paths.LIST_TRIP,
      page: () => const ListTripView(),
      binding: ListTripBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_HISTORY,
      page: () => const DetailHistoryView(),
      binding: DetailHistoryBinding(),
    ),
  ];
}
