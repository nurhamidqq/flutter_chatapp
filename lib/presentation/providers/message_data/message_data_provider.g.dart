// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageDataHash() => r'8ce1ba490daa79d3797d0544fa7d62fcb61ff233';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MessageData extends BuildlessStreamNotifier<QuerySnapshot?> {
  late final String senderId;
  late final String receiverId;

  Stream<QuerySnapshot?> build({
    required String senderId,
    required String receiverId,
  });
}

/// See also [MessageData].
@ProviderFor(MessageData)
const messageDataProvider = MessageDataFamily();

/// See also [MessageData].
class MessageDataFamily extends Family<AsyncValue<QuerySnapshot?>> {
  /// See also [MessageData].
  const MessageDataFamily();

  /// See also [MessageData].
  MessageDataProvider call({
    required String senderId,
    required String receiverId,
  }) {
    return MessageDataProvider(
      senderId: senderId,
      receiverId: receiverId,
    );
  }

  @override
  MessageDataProvider getProviderOverride(
    covariant MessageDataProvider provider,
  ) {
    return call(
      senderId: provider.senderId,
      receiverId: provider.receiverId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messageDataProvider';
}

/// See also [MessageData].
class MessageDataProvider
    extends StreamNotifierProviderImpl<MessageData, QuerySnapshot?> {
  /// See also [MessageData].
  MessageDataProvider({
    required String senderId,
    required String receiverId,
  }) : this._internal(
          () => MessageData()
            ..senderId = senderId
            ..receiverId = receiverId,
          from: messageDataProvider,
          name: r'messageDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageDataHash,
          dependencies: MessageDataFamily._dependencies,
          allTransitiveDependencies:
              MessageDataFamily._allTransitiveDependencies,
          senderId: senderId,
          receiverId: receiverId,
        );

  MessageDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.senderId,
    required this.receiverId,
  }) : super.internal();

  final String senderId;
  final String receiverId;

  @override
  Stream<QuerySnapshot?> runNotifierBuild(
    covariant MessageData notifier,
  ) {
    return notifier.build(
      senderId: senderId,
      receiverId: receiverId,
    );
  }

  @override
  Override overrideWith(MessageData Function() create) {
    return ProviderOverride(
      origin: this,
      override: MessageDataProvider._internal(
        () => create()
          ..senderId = senderId
          ..receiverId = receiverId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        senderId: senderId,
        receiverId: receiverId,
      ),
    );
  }

  @override
  StreamNotifierProviderElement<MessageData, QuerySnapshot?> createElement() {
    return _MessageDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessageDataProvider &&
        other.senderId == senderId &&
        other.receiverId == receiverId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, senderId.hashCode);
    hash = _SystemHash.combine(hash, receiverId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MessageDataRef on StreamNotifierProviderRef<QuerySnapshot?> {
  /// The parameter `senderId` of this provider.
  String get senderId;

  /// The parameter `receiverId` of this provider.
  String get receiverId;
}

class _MessageDataProviderElement
    extends StreamNotifierProviderElement<MessageData, QuerySnapshot?>
    with MessageDataRef {
  _MessageDataProviderElement(super.provider);

  @override
  String get senderId => (origin as MessageDataProvider).senderId;
  @override
  String get receiverId => (origin as MessageDataProvider).receiverId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
