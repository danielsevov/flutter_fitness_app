import {Model, model, property} from '@loopback/repository';

@model()
export class Workset extends Model {
  @property({
    type: 'string',
    required: true,
  })
  exercise: string;

  @property({
    type: 'array',
    itemType: 'number',
    required: true,
  })
  kilos: number[];

  @property({
    type: 'array',
    itemType: 'number',
    required: true,
  })
  reps: number[];

  @property({
    type: 'string',
  })
  set_note?: string;

  @property({
    type: 'boolean',
    required: true,
  })
  is_completed: boolean;


  constructor(data?: Partial<Workset>) {
    super(data);
  }
}

export interface WorksetRelations {
  // describe navigational properties here
}

export type WorksetWithRelations = Workset & WorksetRelations;
