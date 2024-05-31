import 'package:flutter/material.dart';
import '../core/app_export.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/chat_screen/chat_screen.dart';
import '../presentation/detail_kategori_container_screen/detail_kategori_container_screen.dart';
import '../presentation/freelance_home_screen/freelance_home_screen.dart';
import '../presentation/freelance_kotak_masuk_screen/freelance_kotak_masuk_screen.dart';
import '../presentation/freelance_pesanan_screen/freelance_pesanan_screen.dart';
import '../presentation/freelance_profil_screen/freelance_profil_screen.dart';
import '../presentation/freelance_tambah_jasa_screen/freelance_tambah_jasa_screen.dart';
import '../presentation/homepage_screen/homepage_screen.dart';
import '../presentation/layanan_screen/layanan_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/registrasi_screen/registrasi_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String detailKategoriPage = '/detail_kategori_page';

  static const String detailKategoriContainerScreen = '/detail_kategori_container_screen';

  static const String layananScreen = '/layanan_screen';
  static const String chatScreen = '/chat_screen';

  static const String loginScreen = '/login_screen';

  static const String registrasiScreen = '/registrasi_screen';
  static const String homepageScreen = '/homepage_screen';
  static const String inboxPage = '/inbox_page';

  static const String pencarianPage = '/pencarian_page';
}
static const String pesananPage = '/pesanan_page';
static const String profilPage = '/profil_page';
static const String freelanceHomeScreen = '/freelance_home_screen';

static const String freelanceKotakMasukScreen = '/freelance_kotak_masuk_screen';

static const String freelanceTambahJasaScreen = '/freelance_tambah_jasa_screen';

static const String freelancePesananScreen = '/freelance_pesanan_screen';
static const String freelanceProfilScreen = '/freelance_profil_screen';
static const String appNavigationScreen = '/app_navigation_screen';
static const String initialRoute = '/initialRoute';

static Map<String, WidgetBuilder> routes = {
  detailKategoriContainerScreen: (context) => DetailKategoriContainerScreen(),
  layananScreen: (context) => LayananScreen(),
  chatScreen: (context) => ChatScreen(),
  loginScreen: (context) => LoginScreen(),
  registrasiScreen: (context) => RegistrasiScreen(),
  homepageScreen: (context) => HomepageScreen(),
  freelanceHomeScreen: (context) => FreelanceHomeScreen(),
  freelanceKotakMasukScreen: (context) => FreelanceKotakMasukScreen(),
  freelanceTambahJasaScreen: (context) => FreelanceTambahJasaScreen(),
  freelancePesananScreen: (context) => FreelancePesananScreen(),
  freelanceProfilScreen: (context) => FreelanceProfilScreen(),
  appNavigationScreen: (context) => AppNavigationScreen(),
  initialRoute: (context) => LoginScreen()
};
