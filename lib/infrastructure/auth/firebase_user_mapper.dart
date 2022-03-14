import 'package:firebase_auth/firebase_auth.dart';
import 'package:mixin_note/domain/auth/user.dart';
import 'package:mixin_note/domain/core/value_objects.dart';

extension FirebaseUserDomainX on User {
  AppUser toDomain() {
    return AppUser(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
