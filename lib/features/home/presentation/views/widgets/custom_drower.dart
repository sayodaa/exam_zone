import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 240.w,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              // Header
              Container(
                height: 120.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.school,
                        size: 28.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Examen Zone',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // Logout
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 20.w,
                ),
                leading: Icon(
                  Icons.exit_to_app,
                  size: 24.sp,
                  color: Colors.white,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Text(
                  '© 2025 Examen Zone',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
