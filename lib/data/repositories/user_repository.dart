import 'package:drift/drift.dart';
import 'package:organizer/core/models/user.dart';
import 'package:organizer/core/repositories/user_repository.dart';
import 'package:organizer/data/database/database.dart' hide User;

class UserRepositoryDrift extends UserRepository {
  final AppDatabase db;
  UserRepositoryDrift(this.db);

  @override
  Future<void> addUser(String name, String color) async {
    await db.into(db.users).insert(UsersCompanion.insert(name: name, color: color));
  }

  @override
  Future<List<User>> getAllUsers() async {
    final rows = await (db.select(db.users)).get();
    return rows.map((t) => User(id: t.id, name: t.name, color: t.color)).toList();
  }

  @override
  Future<void> removeUser(int id) async {
    await (db.delete(db.users)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> updateUser(int id, String name, String color) async {
    await (db.update(db.users)..where((t) => t.id.equals(id))).write(
      UsersCompanion(id: Value(id), name: Value(name), color: Value(color)),
    );
  }
}
