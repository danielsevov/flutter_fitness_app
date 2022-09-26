// Uncomment these imports to begin using these cool features!

// import {inject} from '@loopback/core';
import {authenticate, TokenService} from '@loopback/authentication';

import {
  Credentials,
  MyUserService,
  TokenServiceBindings,
  User,
  UserRepository,
  UserServiceBindings,
} from '@loopback/authentication-jwt';
import {Role} from '../models';
import {RoleRepository} from '../repositories';
import {inject} from '@loopback/core';
import {model, property, repository, Filter, FilterBuilder} from '@loopback/repository';
import {
  get,
  getModelSchemaRef,
  post,
  requestBody,
  response,
  param,
  SchemaObject,
} from '@loopback/rest';
import {SecurityBindings, securityId, UserProfile} from '@loopback/security';
import {genSalt, hash} from 'bcryptjs';
import _ from 'lodash';

@model()
export class NewUserRequest extends User {
  @property({
    type: 'string',
    required: true,
  })
  password: string;
  
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
}

const CredentialsSchema: SchemaObject = {
  type: 'object',
  required: ['email', 'password'],
  properties: {
    email: {
      type: 'string',
      format: 'email',
    },
    password: {
      type: 'string',
      minLength: 8,
    },
  },
};

export const CredentialsRequestBody = {
  description: 'The input of login function',
  required: true,
  content: {
    'application/json': {schema: CredentialsSchema},
  },
};

export class UserController {
  constructor(
    @inject(TokenServiceBindings.TOKEN_SERVICE)
    public jwtService: TokenService,
    @inject(UserServiceBindings.USER_SERVICE)
    public userService: MyUserService,
    @inject(SecurityBindings.USER, {optional: true})
    public user: UserProfile,
    @repository(UserRepository) protected userRepository: UserRepository,
	@repository(RoleRepository) public roleRepository : RoleRepository,
  ) {}

  @post('/login', {
    responses: {
      '200': {
        description: 'Token',
        content: {
          'application/json': {
            schema: {
              type: 'object',
              properties: {
                token: {
                  type: 'string',
                },
              },
            },
          },
        },
      },
    },
  })
  async login(
    @requestBody(CredentialsRequestBody) credentials: Credentials,
  ): Promise<{token: string}> {
    // ensure the user exists, and the password is correct
    const user = await this.userService.verifyCredentials(credentials);
    // convert a User object into a UserProfile object (reduced set of properties)
    const userProfile = this.userService.convertToUserProfile(user);

    // create a JSON Web Token based on the user profile
    const token = await this.jwtService.generateToken(userProfile);
    return {token};
  }

  @authenticate('jwt')
  @get('/whoAmI', {
    responses: {
      '200': {
        description: 'Return current user',
        content: {
          'application/json': {
            schema: {
              type: 'object',
            },
          },
        },
      },
    },
  })
  async whoAmI(
    @inject(SecurityBindings.USER)
    currentUserProfile: UserProfile,
  ): Promise<object> {
    return {"userId":currentUserProfile[securityId]};
  }

  @post('/signup', {
    responses: {
      '200': {
        description: 'User',
        content: {
          'application/json': {
            schema: {
              'x-ts-type': User,
            },
          },
        },
      },
    },
  })
  async signUp(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(NewUserRequest, {
            title: 'NewUser',
          }),
        },
      },
    })
    newUserRequest: NewUserRequest,
  ): Promise<User> {
	newUserRequest.id = newUserRequest.email;
	
    const password = await hash(newUserRequest.password, await genSalt());
    const savedUser = (await this.userRepository.create(
      _.omit(newUserRequest, 'password'),
    ));

    (await this.userRepository.userCredentials(savedUser.id).create({password}));
	
    return savedUser;
  }
  
  @authenticate('jwt')
  @get('/users')
  async getUsers(
    @inject(SecurityBindings.USER)
    currentUserProfile: UserProfile,
  ): Promise<User[]> {
    return await this.userRepository.find();
  }
  
  @authenticate('jwt')
  @post('/get_user')
  async getUser(
    @inject(SecurityBindings.USER)
    currentUserProfile: UserProfile,
	@requestBody(
      {
        required: true,
        content: {
          'application/json': {
            schema: {
              type: 'object',
			  required: ['id'],
              properties: {
				id:{
                  type: 'string',
                }
              },
            },
          }
        },
      }) user:User,
  ): Promise<User | null> {
    return await this.userRepository.findOne({where: {id:user.id}});
  }
  
  @authenticate('jwt')
  @get('/my_trainees')
  async getMyTrainees(
    @inject(SecurityBindings.USER)
    currentUserProfile: UserProfile,
  ): Promise<User[]> {
    return await this.userRepository.find({where: {coach_id:currentUserProfile[securityId]}});
  }
  
}
