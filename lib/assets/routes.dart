import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:client_app/user_details.dart';
import 'package:client_app/account.dart';
import 'package:client_app/deliveries.dart';
import 'package:client_app/delivery_request.dart';
import 'package:client_app/home.dart';

class Routes {
  static const String login = "/login";
  static const String signUp = "/signUp";
  static const String forgotPassword = "/forgotPassword";
  static const String resetPassword = "/resetPassword";
  static const String businessDetails = "/businessDetails";
  static const String account = "/account";
  static const String deliveries = "/deliveries";
  static const String deliveryRequest = "/deliveryRequest";
  static const String home = "/home";

  static void configureRoutes(FluroRouter router) {
    router.define(login, handler: Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => const LoginPage()));
    router.define(signUp, handler: Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => const SignUpPage()));
    router.define(forgotPassword, handler: Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => ForgotPasswordPage()));
    router.define(resetPassword, handler: Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => const ResetPasswordPage()));
    router.define(businessDetails, handler: Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => const BusinessDetailsPage()));
    router.define(account, handler: Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => const AccountPage()));
    router.define(deliveries, handler: Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => const DeliveriesPage(deliveries: [],)));
    router.define(deliveryRequest, handler: Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => DeliveryRequestPage(deliveries: const [],)));
    router.define(home, handler: Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => const HomePage()));
  }
}
