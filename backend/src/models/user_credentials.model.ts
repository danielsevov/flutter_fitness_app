import { Entity } from '@loopback/repository';
import {model, property, repository} from '@loopback/repository';

@model()
export declare class UserCredentials extends Entity {
    @property()
    id: string;
    
    @property()
    password: string;

    @property()
    userId: string;

    [prop: string]: any;
    constructor(data?: Partial<UserCredentials>);
}
export interface UserCredentialsRelations {
}
export declare type UserCredentialsWithRelations = UserCredentials & UserCredentialsRelations;
