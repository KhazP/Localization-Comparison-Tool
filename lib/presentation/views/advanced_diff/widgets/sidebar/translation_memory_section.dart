
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';

class TranslationMemorySection extends StatelessWidget {
  const TranslationMemorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvancedDiffController>(
      builder: (context, controller, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enable Toggle
            Row(
              children: [
                 const Icon(Icons.psychology, size: 16, color: Colors.grey),
                 const SizedBox(width: 8),
                 const Expanded(child: Text('Enable TM Fill')),
                 Switch(
                   value: controller.enableTM,
                   onChanged: (val) {
                     controller.setTmEnabled(val);
                   },
                   activeColor: Colors.orange,
                 ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Auto-apply checkbox
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: controller.autoApply,
                    onChanged: controller.enableTM ? (val) {
                      controller.setTmAutoApply(val ?? false);
                    } : null,
                    activeColor: Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),
                Text('Auto-apply above minimum', style: TextStyle(color: controller.enableTM ? null : Colors.grey)),
              ],
            ),
            
            const SizedBox(height: 12),
            const Text('Match Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            
            // Min Match Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Min match:', style: TextStyle(fontSize: 12)),
                Text('${(controller.minMatch * 100).toInt()}%', style: const TextStyle(fontSize: 12)),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                trackHeight: 2,
              ),
              child: Slider(
                value: controller.minMatch,
                min: 0.0,
                max: 1.0,
                activeColor: Colors.orange,
                onChanged: controller.enableTM ? (val) {
                  controller.setTmMinMatch(val);
                } : null,
              ),
            ),
            
            // Limit and Exact (using Wrap to avoid overflow)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Limit:', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 60,
                      height: 32,
                      child: DropdownButtonFormField<int>(
                        value: controller.limit,
                        isDense: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          border: OutlineInputBorder(),
                        ),
                        items: [1, 3, 5, 10].map((e) => DropdownMenuItem(value: e, child: Text('$e', style: TextStyle(fontSize: 12)))).toList(),
                        onChanged: controller.enableTM ? (val) {
                          controller.setTmLimit(val ?? 3);
                        } : null,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: controller.exactMatch,
                        onChanged: controller.enableTM ? (v) {
                          controller.setTmExactMatch(v ?? false);
                        } : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text('Exact', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
