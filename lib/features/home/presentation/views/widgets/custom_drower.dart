import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220.w,
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 70.h,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: Row(
                    children: [
                      Icon(size: 24.sp, Icons.settings, color: Colors.white),
                      SizedBox(width: 8.w),
                      Text(
                        'LDx App',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 3.h,
                  horizontal: 10.w,
                ),
                leading: Icon(Icons.exit_to_app, size: 22.sp),
                title: Text('Logout', style: TextStyle(fontSize: 14.sp)),
                onTap: () {},
              ),
            ],
          ),

          Container(
            color: Colors.black.withValues(alpha: .5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Colors.blue,

                    strokeWidth: 3,
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'Logging out...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
