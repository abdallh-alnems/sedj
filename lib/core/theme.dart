import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.amber.shade100,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.amber.shade100,
      titleTextStyle: TextStyle(fontSize: 25.sp, color: Colors.white),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.amber.shade100,
      ),
    ),
  );
}
