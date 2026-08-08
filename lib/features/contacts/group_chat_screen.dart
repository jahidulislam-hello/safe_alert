import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/contacts/chat_widgets.dart';
import 'package:safe_alert/features/contacts/contact_group.dart';
import 'package:safe_alert/features/contacts/group_chat_controller.dart';
import 'package:flutter/material.dart';


/// The group chat screen: blue header with overlapping member avatars,
/// name, and an Online badge; scrollable message bubbles; input bar.
class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key, required this.group});

  final ContactGroup group;

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final GroupChatController controller = GroupChatController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onChange);
    controller.dispose();
    super.dispose();
  }

  void _onChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      body: SafeArea(
        child: Column(
          children: [
            _ChatHeader(group: widget.group, onBack: () => Navigator.of(context).maybePop()),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (_, i) => ChatBubble(message: controller.messages[i]),
              ),
            ),
            ChatInputBar(
              controller: controller.textController,
              canSend: controller.canSend,
              onChanged: controller.onTextChanged,
              onSend: controller.send,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.group, required this.onBack});

  final ContactGroup group;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final avatarMembers = group.members.take(3).toList();

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 16, 14),
      color: AppColors.brand500,
      child: Row(
        children: [
          InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          SizedBox(
            width: 20.0 + avatarMembers.length * 16,
            height: 32,
            child: Stack(
              children: [
                for (int i = 0; i < avatarMembers.length; i++)
                  Positioned(
                    left: i * 16.0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: avatarMembers[i].avatarColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.brand500, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        avatarMembers[i].initials,
                        style: AppTextStyles.caption1Medium.copyWith(color: Colors.white, fontSize: 9),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(group.name, style: AppTextStyles.h6SemiBold.copyWith(color: Colors.white)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: AppColors.success500, borderRadius: BorderRadius.circular(20)),
            child: Text('Online', style: AppTextStyles.body2Bold.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
