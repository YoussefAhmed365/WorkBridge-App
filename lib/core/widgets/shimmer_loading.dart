import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Synchronized Shimmer Gradient Wrapper
///
/// Wraps any skeleton layout in a continuous, high-performance light sweep
/// across all child elements without spawning individual animation tickers.
class Shimmer extends StatefulWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;
  final bool enabled;

  const Shimmer({super.key, required this.child, this.baseColor, this.highlightColor, this.duration = const Duration(milliseconds: 1400), this.enabled = true});

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    final base = widget.baseColor ?? AppColors.tagBg; // #F1F5F9
    final highlight = widget.highlightColor ?? Colors.white;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [base, highlight, base],
              stops: const [0.1, 0.45, 0.9],
              transform: _SlidingGradientTransform(slidePercent: _controller.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (slidePercent * 2 - 1), 0.0, 0.0);
  }
}

/// Primitive Shimmer Geometry Block
class ShimmerBox extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;
  final Color? color;
  final ShapeBorder? shape;

  const ShimmerBox({super.key, this.width, required this.height, this.borderRadius = 8.0, this.color, this.shape});

  /// Circular avatar / action icon skeleton
  const ShimmerBox.circle({super.key, required double size, this.color}) : width = size, height = size, borderRadius = 9999, shape = const CircleBorder();

  /// Pill skeleton (Design.md: rounded-full 9999px)
  const ShimmerBox.pill({super.key, this.width, required this.height, this.color}) : borderRadius = 9999, shape = const StadiumBorder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: color ?? AppColors.tagBg,
        shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      ),
    );
  }
}

/// Job / Gig Listing Card Skeleton
///
/// Follows Design.md Level 1 Card Specs:
/// - 16px radius, 1px hairline border, pure white container
/// - 48x48 branded company logo slot with 12px radius
/// - Match tag pill, compensation line, and location metadata row
/// - Pill-shaped (stadium) footer skill tags
class JobCardSkeleton extends StatelessWidget {
  const JobCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.0),
      ),
      child: Shimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Avatar (48x48, 12r) + Title & Company + Bookmark Icon
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: 48, height: 48, borderRadius: 12),
                SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ShimmerBox(width: 150, height: 16, borderRadius: 4), SizedBox(height: 8), ShimmerBox(width: 95, height: 12, borderRadius: 4)]),
                ),
                ShimmerBox(width: 32, height: 32, borderRadius: 8),
              ],
            ),
            const SizedBox(height: 14),

            // Match Tag & Compensation
            const Row(children: [ShimmerBox.pill(width: 84, height: 22), SizedBox(width: 10), ShimmerBox(width: 110, height: 14, borderRadius: 4)]),
            const SizedBox(height: 12),

            // Meta Row (Governorate, Work Type, Time)
            const Row(children: [ShimmerBox(width: 74, height: 12, borderRadius: 4), SizedBox(width: 14), ShimmerBox(width: 68, height: 12, borderRadius: 4), SizedBox(width: 14), ShimmerBox(width: 55, height: 12, borderRadius: 4)]),
            const SizedBox(height: 14),

            // Hairline separator
            Container(height: 1.0, color: AppColors.border),
            const SizedBox(height: 12),

            // Footer Skill Tags (Pill / Stadium Contour)
            const Row(children: [ShimmerBox.pill(width: 60, height: 24), SizedBox(width: 8), ShimmerBox.pill(width: 72, height: 24), SizedBox(width: 8), ShimmerBox.pill(width: 54, height: 24)]),
          ],
        ),
      ),
    );
  }
}

/// Contract Agreement Review Skeleton
///
/// Matches the Contract Agreement screen anatomy:
/// - Pending status pill
/// - Dual-party relationship card (Employer ── Talent)
/// - Remuneration box (18,500 EGP + Escrow badge)
/// - 2x2 Engagement parameters grid
class ContractAgreementSkeleton extends StatelessWidget {
  const ContractAgreementSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Shimmer(
        child: Column(
          children: [
            // 1. Pending Status Banner Skeleton
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  ShimmerBox.circle(size: 32),
                  SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ShimmerBox(width: 110, height: 14, borderRadius: 4), SizedBox(height: 6), ShimmerBox(width: 190, height: 11, borderRadius: 4)]),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 2. Parties Overview Card Skeleton
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerBox(width: 100, height: 12, borderRadius: 4),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: AppColors.tagBg, borderRadius: BorderRadius.circular(12)),
                          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ShimmerBox(width: 50, height: 10), SizedBox(height: 8), ShimmerBox(width: 36, height: 36, borderRadius: 8), SizedBox(height: 8), ShimmerBox(width: 75, height: 12)]),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: AppColors.tagBg, borderRadius: BorderRadius.circular(12)),
                          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ShimmerBox(width: 50, height: 10), SizedBox(height: 8), ShimmerBox.circle(size: 36), SizedBox(height: 8), ShimmerBox(width: 75, height: 12)]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 3. Remuneration Box Skeleton
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ShimmerBox(width: 120, height: 12), ShimmerBox.pill(width: 90, height: 20)]),
                  SizedBox(height: 12),
                  ShimmerBox(width: 140, height: 28, borderRadius: 4),
                  SizedBox(height: 10),
                  ShimmerBox(width: double.infinity, height: 12),
                  SizedBox(height: 6),
                  ShimmerBox(width: 220, height: 12),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 4. 2x2 Engagement Parameters Grid Skeleton
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 140, height: 14),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: ShimmerBox(height: 52, borderRadius: 12)),
                      SizedBox(width: 10),
                      Expanded(child: ShimmerBox(height: 52, borderRadius: 12)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: ShimmerBox(height: 52, borderRadius: 12)),
                      SizedBox(width: 10),
                      Expanded(child: ShimmerBox(height: 52, borderRadius: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
