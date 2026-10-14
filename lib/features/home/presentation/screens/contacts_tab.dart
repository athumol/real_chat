
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_chat/core/providers/repository_providers.dart';
import 'package:real_chat/data/models/user_model.dart';

import '../providers/contacts_provider.dart';

class ContactsTab extends ConsumerWidget {
  const ContactsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(allUsersProvider);

    return usersAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Unable to load contacts.'),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => ref.invalidate(allUsersProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (users) {
        if (users.isEmpty) {
          return const Center(
            child: Text('No other registered users found.'),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(allUsersProvider);
            await ref.read(allUsersProvider.future);
          },
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return _ContactTile(user: users[index]);
            },
          ),
        );
      },
    );
  }
}

class _ContactTile extends ConsumerStatefulWidget {
  final UserModel user;

  const _ContactTile({required this.user});

  @override
  ConsumerState<_ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends ConsumerState<_ContactTile> {
  bool _isSending = false;

  Future<void> _sendFriendRequest(String senderId) async {
    if (_isSending) return;

    setState(() => _isSending = true);

    try {
      await ref.read(friendRepositoryProvider).sendFriendRequest(
            senderId: senderId,
            receiverId: widget.user.uid,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Friend request sent successfully!'),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to send request: ${error.toString().replaceFirst('Exception: ', '')}',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.user.profileImage;
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    final outgoingAsync = currentUserId == null
        ? null
        : ref.watch(outgoingRequestsProvider(currentUserId));

    final friendsAsync = currentUserId == null
        ? null
        : ref.watch(friendsProvider(currentUserId));

    final hasSentRequest = outgoingAsync?.valueOrNull?.any(
          (request) => request.receiverId == widget.user.uid,
        ) ??
        false;

    final isFriend = friendsAsync?.valueOrNull?.any(
          (friend) => friend.friendUid == widget.user.uid,
        ) ??
        false;

    final isLoadingStatus =
        outgoingAsync?.isLoading == true || friendsAsync?.isLoading == true;

    final buttonLabel = isFriend
        ? 'Friends'
        : hasSentRequest
            ? 'Request Sent'
            : 'Add Friend';

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: imageUrl != null && imageUrl.isNotEmpty
              ? NetworkImage(imageUrl)
              : null,
          child: imageUrl == null || imageUrl.isEmpty
              ? const Icon(Icons.person_rounded)
              : null,
        ),
        title: Text(
          widget.user.name.isNotEmpty
              ? widget.user.name
              : widget.user.username,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '@${widget.user.username}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: OutlinedButton(
          onPressed: currentUserId == null ||
                  _isSending ||
                  isLoadingStatus ||
                  hasSentRequest ||
                  isFriend
              ? null
              : () => _sendFriendRequest(currentUserId),
          child: _isSending
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(buttonLabel),
        ),
      ),
    );
  }
}
