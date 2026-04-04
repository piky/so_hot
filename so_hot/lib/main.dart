import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/weather_model.dart';
import 'services/weather_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const SoHotApp());
}

class SoHotApp extends StatelessWidget {
  const SoHotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoHot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0060AD),
          primary: const Color(0xFF0060AD),
          onPrimary: const Color(0xFFF8F8FF),
          primaryContainer: const Color(0xFF68ABFF),
          onPrimaryContainer: const Color(0xFF002B52),
          secondary: const Color(0xFF466370),
          onSecondary: const Color(0xFFF3FAFF),
          secondaryContainer: const Color(0xFFC9E7F7),
          onSecondaryContainer: const Color(0xFF395663),
          surface: const Color(0xFFF7F9FC),
          onSurface: const Color(0xFF2C3338),
          surfaceVariant: const Color(0xFFDCE3E9),
          onSurfaceVariant: const Color(0xFF596065),
          outline: const Color(0xFF747C81),
          outlineVariant: const Color(0xFFABB3B9),
          background: const Color(0xFFF7F9FC),
          onBackground: const Color(0xFF2C3338),
        ),
        textTheme: GoogleFonts.manropeTextTheme().copyWith(
          displayLarge: GoogleFonts.manrope(
            fontSize: 128,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.04 * 128,
            color: const Color(0xFF002B52),
            height: 0.9,
          ),
          headlineSmall: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2C3338),
          ),
          labelMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF596065),
          ),
          labelSmall: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF596065),
          ),
        ),
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isCelsius = true;
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUnitPreference();
    _fetchWeather();
  }

  Future<void> _loadUnitPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isCelsius = prefs.getBool('isCelsius') ?? true;
    });
  }

  Future<void> _saveUnitPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCelsius', value);
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final weather = await _weatherService.fetchWeather();
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF68ABFF),
                  Color(0xFFC9E7F7),
                  Color(0xFFF7F9FC),
                ],
                stops: [0.0, 0.6, 1.0],
              ),
            ),
          ),
          
          // Abstract Atmospheric Visuals (Blurs)
          Positioned(
            top: -100,
            right: -100,
            child: _BlurredCircle(
              color: Colors.white.withOpacity(0.2),
              size: 300,
              blur: 80,
            ),
          ),
          Positioned(
            bottom: 200,
            left: -150,
            child: _BlurredCircle(
              color: const Color(0xFF68ABFF).withOpacity(0.1),
              size: 400,
              blur: 100,
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top Navigation Shell
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Color(0xFF68ABFF)),
                          const SizedBox(width: 8),
                          Text(
                            _weather?.cityName ?? 'Loading...',
                            style: textTheme.headlineSmall?.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: _fetchWeather,
                        icon: const Icon(Icons.refresh, color: Color(0xFF68ABFF)),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _error != null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                                    const SizedBox(height: 16),
                                    Text(_error!, textAlign: TextAlign.center),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: _fetchWeather,
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Editorial Hero Section
                                  Text(
                                    _weather!.cityName.toUpperCase(),
                                    style: textTheme.labelMedium?.copyWith(
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onPrimaryContainer.withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isCelsius
                                            ? _weather!.temperature.round().toString()
                                            : ((_weather!.temperature * 9 / 5) + 32).round().toString(),
                                        style: textTheme.displayLarge,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text(
                                          '°',
                                          style: textTheme.displayLarge?.copyWith(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 24, left: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isCelsius = !isCelsius;
                                              _saveUnitPreference(isCelsius);
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: colorScheme.onPrimaryContainer.withOpacity(0.2),
                                              ),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              isCelsius ? 'F' : 'C',
                                              style: textTheme.labelSmall?.copyWith(
                                                fontWeight: FontWeight.w800,
                                                color: colorScheme.onPrimaryContainer.withOpacity(0.4),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Text(
                                        _weather!.description,
                                        style: textTheme.headlineSmall?.copyWith(
                                          fontSize: 22,
                                          color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorScheme.onPrimaryContainer.withOpacity(0.3),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Feels like ${isCelsius ? _weather!.feelsLike.round() : ((_weather!.feelsLike * 9 / 5) + 32).round()}°',
                                        style: textTheme.labelMedium?.copyWith(
                                          fontSize: 14,
                                          color: colorScheme.onPrimaryContainer.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),

                                  // Glassmorphic Bento Grid
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildDetailCard(
                                          context,
                                          icon: Icons.air,
                                          label: 'Wind Speed',
                                          value: _weather!.windSpeed.round().toString(),
                                          unit: 'km/h',
                                          badge: _weather!.windDirection,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: _buildDetailCard(
                                          context,
                                          icon: Icons.water_drop,
                                          label: 'Humidity',
                                          value: _weather!.humidity.toString(),
                                          unit: '%',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                ),
              ],
            ),
          ),
          
          // Bottom Navigation Shell
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 12, bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.cloud_queue, 'Today', isActive: true),
                      _buildNavItem(Icons.schedule, 'Forecast'),
                      _buildNavItem(Icons.map, 'Map'),
                      _buildNavItem(Icons.settings, 'Settings'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required String unit,
    String? badge,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: Colors.blue.shade500, size: 28),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      badge,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSecondaryContainer,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: textTheme.headlineSmall?.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      unit,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: isActive
              ? BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                )
              : null,
          child: Column(
            children: [
              Icon(
                icon,
                color: isActive ? const Color(0xFF0060AD) : const Color(0xFF596065),
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? const Color(0xFF0060AD) : const Color(0xFF596065),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BlurredCircle extends StatelessWidget {
  final Color color;
  final double size;
  final double blur;

  const _BlurredCircle({
    required this.color,
    required this.size,
    required this.blur,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    ).withBlur(blur);
  }
}

extension BlurExtension on Widget {
  Widget withBlur(double blur) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: this,
    );
  }
}
