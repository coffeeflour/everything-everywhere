

import 'package:chore_app/domain/models/chore_model.dart';
import 'package:chore_app/domain/repositories/base_repository.dart';

class ChoreRepository extends BaseRepository<Chore> {
  ChoreRepository() : super(tableName: 'chores', fromMap: (map) => Chore.fromMap(map));
}