import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/notification_models.dart';
import '../../data/repositories/notification_repository.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository();
});

class NotificationState {
  final bool isLoading;
  final bool isSubmitting;
  final bool isLoadingMore;
  final bool hasMore;
  final int nextPage;
  final List<NotificationItemModel> items;
  final int unreadCount;
  final String? errorMessage;

  const NotificationState({
    required this.isLoading,
    required this.isSubmitting,
    required this.isLoadingMore,
    required this.hasMore,
    required this.nextPage,
    required this.items,
    required this.unreadCount,
    required this.errorMessage,
  });

  factory NotificationState.initial() {
    return const NotificationState(
      isLoading: true,
      isSubmitting: false,
      isLoadingMore: false,
      hasMore: true,
      nextPage: 1,
      items: [],
      unreadCount: 0,
      errorMessage: null,
    );
  }

  NotificationState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    bool? isLoadingMore,
    bool? hasMore,
    int? nextPage,
    List<NotificationItemModel>? items,
    int? unreadCount,
    String? errorMessage,
    bool clearError = false,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      nextPage: nextPage ?? this.nextPage,
      items: items ?? this.items,
      unreadCount: unreadCount ?? this.unreadCount,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository _repository;

  NotificationNotifier(this._repository) : super(NotificationState.initial()) {
    initialize();
  }

  static const int _pageSize = 20;

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final results = await Future.wait([
        _repository.getNotifications(page: 0, size: _pageSize),
        _repository.getUnreadCount(),
      ]);
      final firstPage = results[0] as List<NotificationItemModel>;

      state = state.copyWith(
        isLoading: false,
        items: firstPage,
        hasMore: firstPage.length == _pageSize,
        nextPage: 1,
        unreadCount: (results[1] as UnreadCountModel).count,
      );
    } on NotificationException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '알림 정보를 불러오지 못했어요.',
      );
    }
  }

  Future<void> refresh() async {
    await initialize();
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true, clearError: true);
    try {
      final page = state.nextPage;
      final nextItems = await _repository.getNotifications(
        page: page,
        size: _pageSize,
      );
      state = state.copyWith(
        isLoadingMore: false,
        items: [...state.items, ...nextItems],
        hasMore: nextItems.length == _pageSize,
        nextPage: page + 1,
      );
    } on NotificationException catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: '알림을 더 불러오지 못했어요.',
      );
    }
  }

  Future<void> markAsRead(NotificationItemModel item) async {
    if (item.isRead) return;
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.markAsRead(item.id);
      final nextItems = state.items
          .map(
            (n) => n.id == item.id
                ? n.copyWith(isRead: true, readAt: DateTime.now())
                : n,
          )
          .toList();
      state = state.copyWith(
        isSubmitting: false,
        items: nextItems,
        unreadCount: _decrementUnread(state.unreadCount),
      );
    } on NotificationException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: '알림 읽음 처리에 실패했어요.',
      );
    }
  }

  Future<void> markAllAsRead() async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.markAllAsRead();
      final nextItems = state.items
          .map((n) => n.copyWith(isRead: true, readAt: DateTime.now()))
          .toList();
      state = state.copyWith(
        isSubmitting: false,
        items: nextItems,
        unreadCount: 0,
      );
    } on NotificationException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: '전체 읽음 처리에 실패했어요.',
      );
    }
  }

  Future<void> deleteNotification(NotificationItemModel item) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.deleteNotification(item.id);
      final nextItems = state.items.where((n) => n.id != item.id).toList();
      final nextUnread = item.isRead
          ? state.unreadCount
          : _decrementUnread(state.unreadCount);
      state = state.copyWith(
        isSubmitting: false,
        items: nextItems,
        unreadCount: nextUnread,
      );
    } on NotificationException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: '알림 삭제에 실패했어요.',
      );
    }
  }

  int _decrementUnread(int current) {
    return current <= 0 ? 0 : current - 1;
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
      return NotificationNotifier(ref.watch(notificationRepositoryProvider));
    });
