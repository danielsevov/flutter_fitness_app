import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {DbDataSource} from '../datasources';
import {Workout, WorkoutRelations} from '../models';

export class WorkoutRepository extends DefaultCrudRepository<
  Workout,
  typeof Workout.prototype.id,
  WorkoutRelations
> {
  constructor(
    @inject('datasources.db') dataSource: DbDataSource,
  ) {
    super(Workout, dataSource);
  }
}
