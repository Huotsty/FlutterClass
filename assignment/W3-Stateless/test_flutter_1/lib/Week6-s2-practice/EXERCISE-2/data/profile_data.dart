import 'package:flutter/material.dart';
import 'package:test_flutter_1/Week6-s2-practice/EXERCISE-2/model/profile_tile_model.dart';


List<ProfileData> users = [
  ProfileData(name: "Huot",
      position: "CS student",
      tiles: [
        TileData( icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
        TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
        TileData(icon: Icons.email, title: "Mail", value: "Penghuot.lim@cadt.edu"),
  ]),
  ProfileData(
      name: "Ronan",
      position: "Flutter Developer",
      avatarUrl: 'assets/w5-s2/aang.png',
      tiles: [
        TileData( icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
        TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
        TileData(icon: Icons.email, title: "Mail", value: "ronan.ogogr@cadt.edu"),
      ]),
  ProfileData(name: "Huot",
      position: "CS student",
      tiles: [
        TileData( icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
        TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
        TileData(icon: Icons.email, title: "Mail", value: "Penghuot.lim@cadt.edu"),
      ]),
];