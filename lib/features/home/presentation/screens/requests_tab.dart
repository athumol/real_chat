
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_chat/core/providers/repository_providers.dart';
import 'package:real_chat/data/models/friend_request_model.dart';
import '../providers/contacts_provider.dart';

class RequestsTab extends ConsumerWidget {
  const RequestsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null) {
      return const Center(
        child: Text('Please log in to view friend requests.'),
      );
    }

    final requestsAsync =
        ref.watch(incomingRequestsProvider(currentUserId));

    return requestsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Unable to load friend requests.'),
            TextButton(
              onPressed: () => ref.invalidate(
                incomingRequestsProvider(currentUserId),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (requests) {
        if (requests.isEmpty) {
          return const Center(
            child: Text('No incoming friend requests yet.'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: requests.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return _RequestTile(request: requests[index]);
          },
        );
      },
    );
  }
}

class _RequestTile extends ConsumerStatefulWidget {
  final FriendRequestModel request;

  const _RequestTile({required this.request});

  @override
  ConsumerState<_RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends ConsumerState<_RequestTile> {
  bool _isProcessing = false;

  Future<void> _handleRequest({required bool accept}) async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      final repository = ref.read(friendRepositoryProvider);

      if (accept) {
        await repository.acceptFriendRequest(
          request: widget.request,
        );
      } else {
        await repository.rejectFriendRequest(
          requestId: widget.request.id,
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            accept ? 'Friend request accepted.' : 'Friend request rejected.',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to process request: $error'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Friend request',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isProcessing
                        ? null
                        : () => _handleRequest(accept: false),
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isProcessing
                        ? null
                        : () => _handleRequest(accept: true),
                    child: _isProcessing
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Accept'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
