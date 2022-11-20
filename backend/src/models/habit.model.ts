import {Entity, model, property} from '@loopback/repository';

@model()
export class Habit extends Entity {
  @property({
    type: 'number',
    id: true,
    generated: true,
  })
  id?: number;

  @property({
    type: 'string',
  })
  date?: string;

  @property({
    type: 'array',
    itemType: 'object',
    required: true,
  })
  habits: object[];

  @property({
    type: 'string',
  })
  note?: string;
  
  @property({
    type: 'string',
	required: true,
  })
  userId: string;
  
  @property({
    type: 'string',
	required: true,
  })
  coachId: string;
  
  @property({
    type: 'boolean',
	default: false,
	
  })
  is_template: boolean;


  constructor(data?: Partial<Habit>) {
    super(data);
  }
}

export interface HabitRelations {
  // describe navigational properties here
}

export type HabitWithRelations = Habit & HabitRelations;
