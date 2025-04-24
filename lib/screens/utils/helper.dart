import 'package:daily_moode/features/navigation_bloc/navigation_bloc.dart';
import 'package:daily_moode/features/navigation_bloc/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const List<String> navRoutes = ['/', '/diary', '/statistics', '/settings'];

void goToPage(BuildContext context, int index) {
  if (index >= 0 && index < navRoutes.length) {
    context.read<NavigationBloc>().add(NavigationOnChanged(index));
    context.go(navRoutes[index]);
  }
}
