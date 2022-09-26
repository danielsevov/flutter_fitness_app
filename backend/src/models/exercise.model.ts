import {Entity, model, property} from '@loopback/repository';

@model({settings: {strict: false}})
export class Exercise extends Entity {
  @property({
    type: 'string',
    required: true,
  })
  bodyPart: string;

  @property({
    type: 'string',
    required: true,
  })
  equipment: string;

  @property({
    type: 'string',
  })
  gifUrl?: string;

  @property({
    type: 'string',
    id: true,
    required: true,
  })
  id: string;

  @property({
    type: 'string',
    required: true,
  })
  name: string;

  @property({
    type: 'string',
    required: true,
  })
  target: string;

  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [prop: string]: any;

  constructor(data?: Partial<Exercise>) {
    super(data);
  }
}

export interface ExerciseRelations {
  // describe navigational properties here
}

export type ExerciseWithRelations = Exercise & ExerciseRelations;
