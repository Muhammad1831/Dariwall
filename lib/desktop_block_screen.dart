import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;



class DesktopNotSupportedApp extends StatelessWidget {
  const DesktopNotSupportedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('پشتیبانی نشده'),
          centerTitle: true,
        ),
        body: FutureBuilder<String>(
          future: _loadHtmlContent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Html(
                        data: snapshot.data!,
                        style: {
                          "body": Style(
                            fontSize: FontSize(16.0),
                            fontFamily: 'Tahoma',
                            color: Colors.black87,
                          ),
                          "h1": Style(
                            color: Colors.red,
                            fontSize: FontSize(24.0),
                            textAlign: TextAlign.center,
                          ),
                        },
                      ),
                    ),
                  ),
                );
              }
              return _buildFallbackContent();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<String> _loadHtmlContent() async {
    try {
      final response = await http.get(
        Uri.parse('/desktop-not-supported.html'),
      );
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to load HTML');
    } catch (e) {
      return '''
        <!DOCTYPE html>
        <html>
        <head>
          <meta charset="UTF-8">
          <title>پشتیبانی نشده</title>
        </head>
        <body>
          <h1>⚠️ این برنامه فقط روی دستگاه‌های موبایل قابل اجراست</h1>
          <p>لطفاً از گوشی هوشمند یا تبلت استفاده کنید.</p>
          <p>برای دسترسی به نسخه موبایل، لطفاً از مرورگر دستگاه همراه خود استفاده نمایید.</p>
        </body>
        </html>
      ''';
    }
  }

  Widget _buildFallbackContent() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 50, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              '⚠️ این برنامه فقط روی دستگاه‌های موبایل قابل اجراست',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'لطفاً از گوشی هوشمند یا تبلت استفاده کنید',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // امکان بازگشت یا هدایت به صفحه اصلی
              },
              child: const Text('دریافت راهنمایی'),
            ),
          ],
        ),
      ),
    );
  }
}