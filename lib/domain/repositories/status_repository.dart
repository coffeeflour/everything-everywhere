import 'package:chore_app/domain/models/status_model.dart';
import 'package:chore_app/domain/repositories/base_repository.dart';

class StatusRepository extends BaseRepository<Status> {
  StatusRepository() : super(tableName: 'chores', fromMap: (map) => Status.fromMap(map));
}