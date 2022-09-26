import { Entity } from '@loopback/repository';
import { UserCredentials } from './user_credentials.model';
import {model, property, repository} from '@loopback/repository';

@model()
export declare class User extends Entity {
    @property()
    id: string;

    @property()
    realm?: string;

    @property()
    username?: string;

    @property()
    email: string;

    @property()
    emailVerified?: boolean;

    @property()
    verificationToken?: string;
	
	@property({
    type: 'string',
    required: true,
  })
  name: string;

  @property({
    type: 'string',
    required: true,
  })
  phone_number: string;
  
  @property({
    type: 'string',
    required: true,
  })
  nationality: string;
  
  @property({
    type: 'string',
    required: true,
  })
  date_of_birth: string;
  
  @property({
    type: 'string',
    required: true,
  })
  coach_id: string;

    @property()
    userCredentials: UserCredentials;
    [prop: string]: any;
    constructor(data?: Partial<User>);
}
export interface UserRelations {
}
export declare type UserWithRelations = User & UserRelations;
