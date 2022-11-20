import {Entity, model, property} from '@loopback/repository';

@model()
export class Workout extends Entity {
  @property({
    type: 'array',
    itemType: 'object',
    required: true,
  })
  sets: object[];

  @property({
    type: 'string',
    id: true,
    generated: true,
  })
  id?: string;

  @property({
    type: 'string',
    required: true,
  })
  coachId: string;

  @property({
    type: 'string',
    required: true,
  })
  userId: string;

  @property({
    type: 'string',
  })
  coach_note?: string;

  @property({
    type: 'string',
  })
  completed_on?: string;

  @property({
    type: 'string',
  })
  user_note?: string;
  
  @property({
    type: 'string',
  })
  workout_name?: string;
  
  @property({
    type: 'string',
  })
  created_on?: string;
  
  @property({
    type: 'boolean',
	default: false,
  })
  is_template?: boolean;
  
  @property({
    type: 'string',
	default: '0',
  })
  duration?: string;


  constructor(data?: Partial<Workout>) {
    super(data);
  }
}

export interface WorkoutRelations {
  // describe navigational properties here
}

export type WorkoutWithRelations = Workout & WorkoutRelations;
