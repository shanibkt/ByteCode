import 'package:flutter/material.dart';

class LaneRecommendationScreen extends StatefulWidget {
  const LaneRecommendationScreen({super.key});

  @override
  _LaneRecommendationScreenState createState() =>
      _LaneRecommendationScreenState();
}

class _LaneRecommendationScreenState extends State<LaneRecommendationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _fadeAnimation;
  double speed = 0;
  double carPosition = 0;
  bool showHospitalSign = false;
  bool showPumpSign = false;
  double roadOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {
          speed = (_controller.value * 120).clamp(0, 120);
          carPosition = _controller.value * 300;
          roadOffset += 5;
          if (roadOffset > 20) roadOffset = 0;

          if (carPosition >= 100 && carPosition < 200) {
            showPumpSign = true;
            showHospitalSign = false;
          } else if (carPosition >= 200) {
            showHospitalSign = true;
            showPumpSign = false;
          } else {
            showHospitalSign = false;
            showPumpSign = false;
          }
        });
      });

    _animation = Tween<double>(begin: 0, end: 300).animate(_controller);
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  String getLaneRecommendation() {
    if (speed < 40) {
      return "Keep Left (Slow Lane)";
    } else if (speed < 80) {
      return "Stay in Center Lane";
    } else {
      return "Use Right Lane (Fast Lane)";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.gps_fixed),
      ),
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("Lane Recommendation"),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Speed: ${speed.toStringAsFixed(0)} km/h",
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.black12,
                child: CustomPaint(
                  painter: RoadPainter(roadOffset),
                ),
              ),
              Positioned(
                left: _animation.value,
                bottom: 20,
                child: Image.asset("assets/images/car.png", width: 60),
              ),
              if (showHospitalSign)
                Positioned(
                  left: 10,
                  top: 60,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.red,
                      child: const Text("Hospital Ahead",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ),
              if (showPumpSign)
                Positioned(
                  left: 10,
                  top: 100,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.blue,
                      child: const Text("Petrol Pump Ahead",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            getLaneRecommendation(),
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              if (!_controller.isAnimating) {
                _controller.repeat(reverse: true);
              }
            },
            child: const Text("Start Journey"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class RoadPainter extends CustomPainter {
  final double offset;
  RoadPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint lanePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (double i = -offset; i < size.height; i += 20) {
      canvas.drawLine(
          Offset(size.width / 3, i), Offset(size.width / 3, i + 10), lanePaint);
      canvas.drawLine(Offset(size.width * 2 / 3, i),
          Offset(size.width * 2 / 3, i + 10), lanePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
