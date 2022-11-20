import {Entity, model, property} from '@loopback/repository';

@model()
export class Image extends Entity {
  @property({
    type: 'number',
    id: true,
    generated: true,
  })
  id?: number;

  @property({
    type: 'string',
    required: true,
  })
  user_id: string;

  @property({
    type: 'string',
    required: true,
  })
  type: string;

  @property({
    type: 'any',
    required: true,
  })
  data: 'TEXT';

  @property({
    type: 'string',
    required: true,
  })
  date: string;


  constructor(data?: Partial<Image>) {
    super(data);
  }
}

export interface ImageRelations {
  // describe navigational properties here
}

export type ImageWithRelations = Image & ImageRelations;
