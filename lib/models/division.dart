import 'package:flutter/material.dart';

enum Division { finance, law, it, medical }

const Map<Division, String> departmentNames = {
  Division.finance: 'Finance',
  Division.law: 'Law',
  Division.it: 'IT',
  Division.medical: 'Medical',
};

const Map<Division, IconData> departmentIcons = {
  Division.finance: Icons.trending_up,
  Division.law: Icons.policy,
  Division.it: Icons.code,
  Division.medical: Icons.local_pharmacy,
};
