import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/features/auth/presentation/managers/logout_cubit/logout_cubit.dart';
import 'package:graduation/features/auth/presentation/views/signin_view.dart';
import 'drawer_header_widget.dart';
import 'logout_tile.dart';
import 'loading_overlay.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 240.w,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SigninView()),
            );
          } else if (state is LogoutFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is LogoutLoading;

          return Stack(
            children: [
              Column(
                children: [
                  const DrawerHeaderWidget(),
                  SizedBox(height: 16.h),
                  LogoutTile(
                    onTap: () => context.read<LogoutCubit>().signOut(),
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
              if (isLoading) const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }
}
