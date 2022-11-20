import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {DbDataSource} from '../datasources';
import {Habit, HabitRelations} from '../models';

export class HabitRepository extends DefaultCrudRepository<
  Habit,
  typeof Habit.prototype.id,
  HabitRelations
> {
  constructor(
    @inject('datasources.db') dataSource: DbDataSource,
  ) {
    super(Habit, dataSource);
  }
}
