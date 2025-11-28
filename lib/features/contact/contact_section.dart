import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hammad_portfolio/core/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/widgets/section_header.dart';
import '../../core/theme/app_theme.dart';

class ContactSection extends StatefulWidget {
  final bool isDarkMode;

  const ContactSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //   Future<void> _sendMessage() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//
//       try {
//         // Check if running on web
//         if (kIsWeb) {
//           // Use mailto for web
//           final String subject = Uri.encodeComponent('Portfolio Contact: ${_nameController.text}');
//           final String body = Uri.encodeComponent(
//               'Name: ${_nameController.text}\n'
//                   'Email: ${_emailController.text}\n\n'
//                   'Message:\n${_messageController.text}\n\n'
//                   '---\n'
//                   'Sent from Portfolio Contact Form'
//           );
//
//           final String mailtoUrl = 'mailto:hammadraza5388@gmail.com?subject=$subject&body=$body';
//           final uri = Uri.parse(mailtoUrl);
//
//           if (await canLaunchUrl(uri)) {
//             await launchUrl(uri);
//
//             if (mounted) {
//               setState(() => _isLoading = false);
//               _showSuccessDialog();
//               _nameController.clear();
//               _emailController.clear();
//               _messageController.clear();
//             }
//           } else {
//             throw Exception('Could not launch email client');
//           }
//         } else {
//           // Use flutter_email_sender for mobile
//           final Email email = Email(
//             body: '''
// Name: ${_nameController.text}
// Email: ${_emailController.text}
//
// Message:
// ${_messageController.text}
//
// ---
// Sent from Portfolio Contact Form
//             ''',
//             subject: 'Portfolio Contact: ${_nameController.text}',
//             recipients: ['hammadraza5388@gmail.com'],
//             isHTML: false,
//           );
//
//           await FlutterEmailSender.send(email);
//
//           if (mounted) {
//             setState(() => _isLoading = false);
//             _showSuccessDialog();
//             _nameController.clear();
//             _emailController.clear();
//             _messageController.clear();
//           }
//         }
//       } on PlatformException catch (error) {
//         if (mounted) {
//           setState(() => _isLoading = false);
//
//           String errorMessage = 'Could not send email. Please try again.';
//
//           // Handle different error codes
//           if (error.code == 'not_available') {
//             errorMessage = 'No email app found. Please install Gmail or another email app.';
//           } else if (error.code == 'cancelled') {
//             // User cancelled sending email, just return without showing error
//             return;
//           } else {
//             // Show the actual error for debugging
//             errorMessage = 'Error: ${error.code}\n${error.message ?? "Unknown error"}\n\nPlease email me directly at hammadraza5388@gmail.com';
//           }
//
//           _showErrorDialog(errorMessage);
//         }
//       } catch (e) {
//         if (mounted) {
//           setState(() => _isLoading = false);
//           // Show the actual error for debugging
//           _showErrorDialog('Unexpected error: ${e.toString()}\n\nPlease email me directly at hammadraza5388@gmail.com');
//         }
//       }
//     }
//   }

  Future<void> _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      const serviceId = 'service_4w4gdno';
      const templateId = 'template_ehda0ih';
      const publicKey = '2HwgE63tsGB6HrHC9';

      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");

      try {
        final response = await http.post(
          url,
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': publicKey,
            'template_params': {
              'name': _nameController.text,
              'email': _emailController.text,
              'message': _messageController.text,
            }
          }),
        );

        if (response.statusCode == 200) {
          if (mounted) {
            setState(() => _isLoading = false);
            _showSuccessDialog();
            _nameController.clear();
            _emailController.clear();
            _messageController.clear();
          }
        } else {
          throw Exception("Error sending email: ${response.body}");
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          _showErrorDialog("Unexpected error: $e");
        }
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.getBackgroundLight(widget.isDarkMode),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppTheme.glassBorder(0.2, widget.isDarkMode),
            width: 1,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppTheme.success, Color(0xFF06B6D4)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.success.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Message Sent!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppTheme.getTextPrimary(widget.isDarkMode),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your message has been sent successfully! I\'ll get back to you as soon as possible.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.getTextSecondary(widget.isDarkMode),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient(widget.isDarkMode),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.getBackgroundLight(widget.isDarkMode),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppTheme.glassBorder(0.2, widget.isDarkMode),
            width: 1,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.error.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: AppTheme.error,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Oops!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppTheme.getTextPrimary(widget.isDarkMode),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.getTextSecondary(widget.isDarkMode),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.error,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
      padding: context.responsive.sectionPadding,
      child: Column(
        children: [
          SectionHeader(
            label: "Let's Connect",
            title: 'Get in Touch',
            subtitle: "Have a project in mind? Let's create something amazing together.",
            isDarkMode: widget.isDarkMode,
          ),

          const SizedBox(height: 60),

          if (responsive.isMobile)
            Column(
              children: [
                _buildContactInfo(responsive),
                const SizedBox(height: 40),
                _buildContactForm(responsive),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildContactInfo(responsive)),
                const SizedBox(width: 40),
                Expanded(child: _buildContactForm(responsive)),
              ],
            ),

          const SizedBox(height: 80),

          _buildFooter(responsive),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildContactInfo(Responsive responsive) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: _isVisible ? 1 : 0),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(-30 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactCard(
            icon: Icons.email_rounded,
            title: 'Email',
            value: 'hammadraza5388@gmail.com',
            onTap: () => _launchUrl('mailto:hammadraza5388@gmail.com'),
          ),
          const SizedBox(height: 20),
          _buildContactCard(
            icon: Icons.location_on_rounded,
            title: 'Location',
            value: 'Multan, Punjab, Pakistan',
            onTap: null,
          ),
          const SizedBox(height: 20),
          _buildContactCard(
            icon: Icons.phone_rounded,
            title: 'Phone',
            value: '+92 317 6642155',
            onTap: () => _launchWhatsApp('+923176642155'),
          ),

          const SizedBox(height: 40),

          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.glass(0.1, widget.isDarkMode),
                  AppTheme.glass(0.05, widget.isDarkMode),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.glassBorder(0.2, widget.isDarkMode),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient(widget.isDarkMode),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.link_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Connect on Social',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.getTextPrimary(widget.isDarkMode),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        _buildSocialButton(
                          FontAwesomeIcons.github,
                          'GitHub',
                          AppTheme.getPrimary(widget.isDarkMode),
                          'https://github.com/razasiddiqui55',
                        ),
                        const SizedBox(width: 16),
                        _buildSocialButton(
                          FontAwesomeIcons.linkedin,
                          'LinkedIn',
                          AppTheme.getAccent(widget.isDarkMode),
                          'https://www.linkedin.com/in/hammad-siddiqui-75a124271/',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return MouseRegion(
      cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.glass(0.1, widget.isDarkMode),
                AppTheme.glass(0.05, widget.isDarkMode),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.glassBorder(0.2, widget.isDarkMode),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient(widget.isDarkMode),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.getTextSecondary(widget.isDarkMode),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppTheme.getTextPrimary(widget.isDarkMode),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onTap != null)
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: AppTheme.getTextSecondary(widget.isDarkMode),
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
      IconData icon,
      String label,
      Color color,
      String url,
      ) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _launchUrl(url),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(widget.isDarkMode ? 0.3 : 0.2),
                  color.withOpacity(widget.isDarkMode ? 0.1 : 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                FaIcon(
                  icon,
                  color: AppTheme.getTextPrimary(widget.isDarkMode),
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.getTextPrimary(widget.isDarkMode),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm(Responsive responsive) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: _isVisible ? 1 : 0),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(30 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.glass(0.1, widget.isDarkMode),
              AppTheme.glass(0.05, widget.isDarkMode),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppTheme.glassBorder(0.2, widget.isDarkMode),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.1),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient(widget.isDarkMode),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.mail_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Send a Message',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.getTextPrimary(widget.isDarkMode),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    _buildTextField(
                      controller: _nameController,
                      label: 'Your Name',
                      hint: 'Enter your full name',
                      icon: Icons.person_rounded,
                      validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your name' : null,
                    ),

                    const SizedBox(height: 20),

                    _buildTextField(
                      controller: _emailController,
                      label: 'Email Address',
                      hint: 'Enter your email address',
                      icon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Please enter your email';
                        if (!value!.contains('@')) return 'Please enter a valid email';
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    _buildTextField(
                      controller: _messageController,
                      label: 'Message',
                      hint: 'Tell me about your project...',
                      icon: Icons.message_rounded,
                      maxLines: 5,
                      validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your message' : null,
                    ),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _sendMessage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient(widget.isDarkMode),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              alignment: Alignment.center,
                              child: _isLoading
                                  ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                                  : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.send_rounded, size: 20, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text(
                                    'Send Message',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.3,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppTheme.getTextPrimary(widget.isDarkMode),
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: TextStyle(
            color: AppTheme.getTextPrimary(widget.isDarkMode),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppTheme.getTextSecondary(widget.isDarkMode).withOpacity(0.6),
              fontSize: 14,
            ),
            prefixIcon: maxLines <= 1
                ? Icon(
              icon,
              color: AppTheme.getTextSecondary(widget.isDarkMode),
              size: 20,
            )
                : null,
            filled: true,
            fillColor: AppTheme.glass(0.05, widget.isDarkMode),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.glassBorder(0.2, widget.isDarkMode),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.glassBorder(0.2, widget.isDarkMode),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.getPrimary(widget.isDarkMode),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppTheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppTheme.error,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildFooter(Responsive responsive) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: _isVisible ? 1 : 0),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: Column(
        children: [
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppTheme.glassBorder(0.2, widget.isDarkMode),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            '© 2025 Hammad Siddiqui. Built with Flutter & DART ❤️',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.getTextSecondary(widget.isDarkMode),
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      debugPrint("Launch error: $e");
    }
  }

  void _launchWhatsApp(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final whatsappUrl = 'https://wa.me/$cleanNumber?text=${Uri.encodeComponent('Hi, I found your portfolio and would like to connect!')}';
    final uri = Uri.parse(whatsappUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        _showErrorDialog('Could not open WhatsApp. Please make sure WhatsApp is installed.');
      }
    }
  }
}