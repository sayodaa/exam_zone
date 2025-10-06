import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/constantes.dart';
import 'package:graduation/core/common/animations/animate_do.dart';
import 'package:graduation/core/common/widgets/custom_app_bar.dart';
import 'package:graduation/core/language/app_localizations.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/routes/app_routes.dart';
import 'package:graduation/core/services/service_locator.dart';
import 'package:graduation/core/styles/app_images.dart';
import 'package:graduation/features/auth/domain/repos/auth_repos.dart';
import 'package:graduation/features/auth/presentation/managers/logout_cubit/logout_cubit.dart'
    show LogoutCubit;
import 'package:graduation/features/home/presentation/views/widgets/build_option_card.dart';
import 'package:graduation/features/home/presentation/views/widgets/custom_drower.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: BlocProvider(
        create: (context) => LogoutCubit(sl<AuthRepo>()),
        child: CustomDrawer(),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstantes.defaultPadding.w,
            vertical: AppConstantes.defaultPadding.h * 0.5,
          ),
          child: OrientationBuilder(
            builder: (context, orientation) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      isVisable: true,
                      text: AppLocalizations.of(
                        context,
                      )!.translate(LangKeys.appName)!,
                    ),
                    SizedBox(height: AppConstantes.defaultPadding.h * 2),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return GridView.count(
                          crossAxisCount: orientation == Orientation.portrait
                              ? 1
                              : 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing:
                              AppConstantes.defaultPadding.h * 0.75,
                          crossAxisSpacing:
                              AppConstantes.defaultPadding.w * 0.75,
                          childAspectRatio: orientation == Orientation.portrait
                              ? 3.5
                              : 2.5,
                          children: [
                            CustomFadeInDown(
                              duration: 300,
                              child: BuildOptionCard(
                                title: AppLocalizations.of(
                                  context,
                                )!.translate(LangKeys.createAiExam),
                                subtitle: AppLocalizations.of(
                                  context,
                                )!.translate(LangKeys.createAiExamSubtitle),
                                imagePath: AppImages.logo,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.generateQuestion,
                                  );
                                },
                              ),
                            ),
                            CustomFadeInLeft(
                              duration: 400,
                              child: BuildOptionCard(
                                title: AppLocalizations.of(
                                  context,
                                )!.translate(LangKeys.essay),
                                subtitle: AppLocalizations.of(
                                  context,
                                )!.translate(LangKeys.createAiExamSubtitle),
                                imagePath: AppImages.logo,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.essayAi,
                                  );
                                },
                              ),
                            ),
                            CustomFadeInLeft(
                              duration: 400,
                              child: BuildOptionCard(
                                title: AppLocalizations.of(
                                  context,
                                )!.translate(LangKeys.analytics),
                                subtitle: AppLocalizations.of(
                                  context,
                                )!.translate(LangKeys.exportAnalytics),
                                imagePath: AppImages.logo,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.overWall,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
