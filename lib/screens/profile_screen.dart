import 'dart:io';
import 'package:fitapp/blocs/auth/auth_bloc.dart';
import 'package:fitapp/blocs/profile/profile_bloc.dart';
import 'package:fitapp/blocs/theme/theme_bloc.dart';
import 'package:fitapp/screens/landing_page.dart';
import 'package:fitapp/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _avatarFile;
  String? _avatarPath;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileLoaded());
    _loadAvatarPath();
  }

  Future<void> _loadAvatarPath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _avatarPath = prefs.getString('avatarPath');
    });
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (picked != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('avatarPath', picked.path);
      setState(() {
        _avatarFile = File(picked.path);
        _avatarPath = picked.path;
      });
    }
  }

  ImageProvider _avatarImage() {
    if (_avatarFile != null) return FileImage(_avatarFile!);
    if (_avatarPath != null) return FileImage(File(_avatarPath!));
    return const AssetImage('assets/images/splash.png');
  }

  bool get _hasCustomAvatar => _avatarFile != null || _avatarPath != null;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSaveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Saved successfully')),
          );
          context.read<ProfileBloc>().add(ProfileLoaded());
        }
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading || state is ProfileInitial) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        Map<String, dynamic> data = {};
        if (state is ProfileLoadSuccess) data = state.data;

        final username = data['username'] ?? 'User';
        final email = data['email'] ?? '';
        final height = data['height']?.toString() ?? '';
        final weight = data['weight']?.toString() ?? '';

        var icon = Icons.monitor_weight;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Profile',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Avatar
                GestureDetector(
                  onTap: _pickAvatar,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        // 1. الخلفية تتغير بناءً على الثيم
                        backgroundColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade800 // لون غامق للـ Dark Mode
                            : Colors.grey.shade200, // لون فاتح للـ Light Mode

                        child: Icon(
                          Icons.person,
                          size: 50,
                          // 2. الأيقونة نفسها تتغير لتكون واضحة دائماً
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white54  // أيقونة فاتحة في الـ Dark
                              : Colors.grey,    // أيقونة رمادية في الـ Light
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF6C63FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt,
                              color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(username,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                Text(email,
                    style: TextStyle(
                        color: Colors.grey.shade600, fontSize: 14)),
                const SizedBox(height: 30),

                // Stats row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _statCard('Height', '$height cm', Icons.height, isDark),
                      const SizedBox(width: 15),
                      Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.12),
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              children: [
                Icon(icon, color: const Color(0xFF6C63FF), size: 28),
                const SizedBox(height: 8),
                Text('$weight kg',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Weight',
                    style: TextStyle(
                        color: Colors.grey.shade500, fontSize: 12)),
              ],
            ),
          ),
        ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Settings section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionLabel('Account', isDark),
                      _settingTile(
                        icon: Icons.edit,
                        label: 'Edit Profile',
                        isDark: isDark,
                        onTap: () => _showEditProfileSheet(
                            context, data, isDark),
                      ),
                      _settingTile(
                        icon: Icons.lock_outline,
                        label: 'Change Password',
                        isDark: isDark,
                        onTap: () => _showChangePasswordSheet(context, isDark),
                      ),
                      const SizedBox(height: 20),
                      _sectionLabel('Preferences', isDark),
                      _switchTile(
                        icon: Icons.dark_mode_outlined,
                        label: 'Dark Mode',
                        isDark: isDark,
                        value: isDark,
                        onChanged: (val) {
                          context.read<ThemeBloc>().add(ThemeToggled(val));
                        },
                      ),
                      const SizedBox(height: 20),
                      _sectionLabel('Session', isDark),
                      _settingTile(
                        icon: Icons.logout,
                        label: 'Logout',
                        isDark: isDark,
                        isDestructive: true,
                        onTap: () async {
                          context.read<AuthBloc>().add(AuthLoggedOut());
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LandingPage()),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _statCard(
      String label, String value, IconData icon, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.12),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF6C63FF), size: 28),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label,
                style: TextStyle(
                    color: Colors.grey.shade500, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade500,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String label,
    required bool isDark,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.08),
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isDestructive
                    ? Colors.red
                    : const Color(0xFF6C63FF)),
            const SizedBox(width: 14),
            Text(label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? Colors.red : null,
                )),
            const Spacer(),
            if (!isDestructive)
              Icon(Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String label,
    required bool isDark,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.08),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6C63FF)),
          const SizedBox(width: 14),
          Text(label,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500)),
          const Spacer(),
          Switch(
            value: value,
            activeColor: const Color(0xFF6C63FF),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  void _showEditProfileSheet(
      BuildContext context, Map<String, dynamic> data, bool isDark) {
    final usernameCtrl =
        TextEditingController(text: data['username'] ?? '');
    final emailCtrl =
        TextEditingController(text: data['email'] ?? '');
    final heightCtrl =
        TextEditingController(text: data['height']?.toString() ?? '');
    final weightCtrl =
        TextEditingController(text: data['weight']?.toString() ?? '');
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          isDark ? Colors.grey.shade900 : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Edit Profile',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Username',
                  labelText: 'Username',
                  prefixIcon: Icons.person,
                  controller: usernameCtrl,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter username' : null,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icons.email,
                  controller: emailCtrl,
                  validator: (v) {
                    if (v == null ||
                        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  hintText: 'Height (cm)',
                  labelText: 'Height (cm)',
                  prefixIcon: Icons.height,
                  controller: heightCtrl,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter height';
                    final h = double.tryParse(v);
                    if (h == null || h < 100 || h > 250)
                      return 'Enter valid height';
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  hintText: 'Weight (kg)',
                  labelText: 'Weight (kg)',
                  prefixIcon: Icons.monitor_weight,
                  controller: weightCtrl,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter weight';
                    final w = double.tryParse(v);
                    if (w == null || w < 30 || w > 300)
                      return 'Enter valid weight';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      context.read<ProfileBloc>().add(
                            ProfileUpdated(data: {
                              'username': usernameCtrl.text.trim(),
                              'email': emailCtrl.text.trim(),
                              'height':
                                  double.parse(heightCtrl.text.trim()),
                              'weight':
                                  double.parse(weightCtrl.text.trim()),
                            }),
                          );
                      Navigator.pop(ctx);
                    },
                    child: const Text('Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showChangePasswordSheet(BuildContext context, bool isDark) {
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    bool hideOld = true;
    bool hideNew = true;
    bool hideConfirm = true;
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          isDark ? Colors.grey.shade900 : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Change Password',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Old Password',
                    labelText: 'Old Password',
                    prefixIcon: Icons.lock_outline,
                    obsecureText: hideOld,
                    suffixIcon: IconButton(
                      icon: Icon(
                          hideOld ? Icons.visibility_off : Icons.visibility),
                      onPressed: () =>
                          setModalState(() => hideOld = !hideOld),
                    ),
                    controller: oldCtrl,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Enter old password' : null,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    hintText: 'New Password',
                    labelText: 'New Password',
                    prefixIcon: Icons.lock,
                    obsecureText: hideNew,
                    suffixIcon: IconButton(
                      icon: Icon(
                          hideNew ? Icons.visibility_off : Icons.visibility),
                      onPressed: () =>
                          setModalState(() => hideNew = !hideNew),
                    ),
                    controller: newCtrl,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Enter new password';
                      if (v.length < 8)
                        return 'Password must be at least 8 characters';
                      if (!RegExp(r'[A-Z]').hasMatch(v))
                        return 'Must contain an uppercase letter';
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    hintText: 'Confirm New Password',
                    labelText: 'Confirm New Password',
                    prefixIcon: Icons.lock,
                    obsecureText: hideConfirm,
                    suffixIcon: IconButton(
                      icon: Icon(hideConfirm
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setModalState(() => hideConfirm = !hideConfirm),
                    ),
                    controller: confirmCtrl,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Confirm your password';
                      if (v != newCtrl.text) return "Passwords don't match";
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        context.read<ProfileBloc>().add(
                              ProfilePasswordChanged(
                                oldPassword: oldCtrl.text.trim(),
                                newPassword: newCtrl.text.trim(),
                              ),
                            );
                        Navigator.pop(ctx);
                      },
                      child: const Text('Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
