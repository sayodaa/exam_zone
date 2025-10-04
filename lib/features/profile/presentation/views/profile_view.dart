import 'package:flutter/material.dart';
import 'package:graduation/core/common/widgets/custom_app_bar.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomAppBar(text: context.translate(LangKeys.profile)),
                // صورة البروفايل + الاسم + الايميل
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/300", // صورة افتراضية
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "أحمد محمد",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "ahmed@example.com",
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                  
                const SizedBox(height: 20),
                  
                // بيانات المستخدم
                Card(
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.phone, color: Colors.teal),
                        title: Text("رقم الهاتف"),
                        subtitle: Text("+20 111 222 333"),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.location_on, color: Colors.teal),
                        title: Text("العنوان"),
                        subtitle: Text("القاهرة، مصر"),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.info, color: Colors.teal),
                        title: Text("نبذة"),
                        subtitle: Text("مطور تطبيقات Flutter 💙"),
                      ),
                    ],
                  ),
                ),
                  
                const SizedBox(height: 10),
                  
                // أزرار الأكشن
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                          label: const Text("تعديل"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.logout),
                          label: const Text("تسجيل خروج"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
