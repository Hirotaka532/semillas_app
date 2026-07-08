import 'package:flutter/material.dart';

class ParcelaModel {
  final int id;
  final Offset position;
  int etapa;
  String cultivo;

  ParcelaModel({
    required this.id,
    required this.position,
    this.etapa = 0,
    this.cultivo = '',
  });
}
