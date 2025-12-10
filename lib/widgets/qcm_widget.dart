

import 'package:flutter/material.dart';
import '../models/lesson_model.dart';


class QCMWidget extends StatefulWidget {
  final QCMActivity activity; 

  const QCMWidget({super.key, required this.activity});


  @override
  State<QCMWidget> createState() => _QCMWidgetState();
}


class _QCMWidgetState extends State<QCMWidget> {

  
  String? selectedOption; 
  bool isSubmitted = false; 

  void checkAnswer() {
    setState(() {
      isSubmitted = true;
    });
  }

  void resetAnswer() {
    setState(() {
      selectedOption = null;
      isSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    final isCorrect = selectedOption == widget.activity.answer;

    final progressValue = (isSubmitted && isCorrect) ? 1.0 : 0.0;
    final progressPercent = (isSubmitted && isCorrect) ? 100 : 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question 1 of 1',
                      style: textTheme.bodyLarge!.copyWith(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '$progressPercent%',
                      style: textTheme.bodyLarge!.copyWith(
                        color: const Color(0xFF6366F1),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progressValue, // 0.0 to 1.0
                    minHeight: 6,
                    backgroundColor: const Color(0xFFE5E7EB),
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF6366F1)),
                  ),
                ),
              ],
            ),
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question',
                    style: textTheme.bodyLarge!.copyWith(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.activity.question,
                    style: textTheme.headlineLarge!.copyWith(fontSize: 28),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          ...widget.activity.options.asMap().entries.map((entry) {
            final index = entry.key;   
            final option = entry.value; 
            
            final bool isOptionCorrect = option == widget.activity.answer;
            final bool isSelected = option == selectedOption;

            Color bgColor = Colors.white;
            Color borderColor = const Color(0xFFE5E7EB);
            Color textColor = const Color(0xFF1F2937);
            IconData? feedbackIcon;
            Color iconColor = const Color(0xFF9CA3AF);

            if (isSubmitted) {
              if (isOptionCorrect) {
                bgColor = const Color(0xFFDCFCE7);
                borderColor = const Color(0xFF86EFAC);
                textColor = const Color(0xFF15803D);
                feedbackIcon = Icons.check_circle_rounded;
                iconColor = const Color(0xFF15803D);
              } else if (isSelected) {
                bgColor = const Color(0xFFFEE2E2);
                borderColor = const Color(0xFFFCA5A5);
                textColor = const Color(0xFF991B1B);
                feedbackIcon = Icons.cancel_rounded;
                iconColor = const Color(0xFF991B1B);
              }
            } else if (isSelected) {
              bgColor = const Color(0xFFE0E7FF);
              borderColor = const Color(0xFF6366F1);
              textColor = const Color(0xFF6366F1);
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _OptionButton(
                index: index,
                option: option,
                backgroundColor: bgColor,
                borderColor: borderColor,
                foregroundColor: textColor,
                icon: feedbackIcon,
                iconColor: iconColor,
                onPressed: isSubmitted
                    ? () {}
                    : () {
                        setState(() {
                          selectedOption = option;
                        });
                      },
              ),
            );
          }), 

          const SizedBox(height: 32),
          
          if (!isSubmitted)

            ElevatedButton(
              onPressed: selectedOption != null ? checkAnswer : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedOption != null 
                    ? const Color(0xFF6366F1)
                    : const Color(0xFFE5E7EB), 
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
                disabledBackgroundColor: const Color(0xFFE5E7EB),
              ),
              child: Text(
                'Check Answer',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            )
          else if (isCorrect)
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Moving to the next question...'),
                    backgroundColor: Color(0xFF15803D),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF15803D), 
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Continue to Next Question!'),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2), 
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFCA5A5),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Color(0xFFDC2626),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Not quite right. Try again!',
                          style: textTheme.bodyLarge!.copyWith(
                            color: const Color(0xFFDC2626),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: resetAnswer,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _OptionButton extends StatefulWidget {
  final int index;
  final String option;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color foregroundColor;
  final IconData? icon;
  final Color iconColor;

  const _OptionButton({
    required this.index,
    required this.option,
    required this.onPressed,
    required this.backgroundColor,
    required this.borderColor,
    required this.foregroundColor,
    required this.iconColor,
    this.icon,
  });

  @override
  State<_OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<_OptionButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.borderColor,
            width: 1.5,
          ),
          boxShadow: isHovered && widget.icon == null
              ? [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12),
            splashColor: const Color(0xFF6366F1).withOpacity(0.1),
            
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: widget.foregroundColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        String.fromCharCode(65 + widget.index), 
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: widget.foregroundColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Text(
                      widget.option,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: widget.foregroundColor,
                      ),
                    ),
                  ),
                  if (widget.icon != null) ...[
                    const SizedBox(width: 12),
                    Icon(
                      widget.icon,
                      color: widget.iconColor,
                      size: 24,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}