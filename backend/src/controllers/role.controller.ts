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

@authenticate('jwt')
export class RoleController {
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

  @post('/roles')
  async create(
  @inject(SecurityBindings.USER) currentUserProfile: UserProfile,
  @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Role, {
            title: 'NewRole',
          }),
        },
      },
    })
    role: Role,
  ): Promise<object> {
	  
    const filterBuilder = new FilterBuilder();
	const filter = filterBuilder
    .where({id: role.userId})
    .build();
	
	let checkAuth = false;
    (await this.roleRepository.find({where: {name:'admin', userId:currentUserProfile[securityId]}})).forEach(role => {
		checkAuth = true;
	});
	if (!checkAuth) return {"error" : "You are not an admin!"};
	
	let check = false;
    (await this.userRepository.find(filter)).forEach(user => {
		check = true;
	});
	
	let check2 = (role.name === "admin" || role.name === "user" || role.name === "coach"); 
	
	if(check && check2) return this.roleRepository.create(role);
	else if (check2) return {"error" : "User not found!"};
	else return {"error" : "Role name doesn't exist!"};
  }

  @get('/roles')
  @response(200, {
    description: 'Array of Role model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Role, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @inject(SecurityBindings.USER) currentUserProfile: UserProfile,
  ): Promise<object> {
	  
	let checkAuth = false;
    (await this.roleRepository.find({where: {name:'admin', userId:currentUserProfile[securityId]}})).forEach(role => {
		checkAuth = true;
	});
	if (!checkAuth) return {"error" : "You are not an admin!"};
	
    return this.roleRepository.find();
  }
  
  
  @get('/my_role')
  @response(200, {
    description: 'Role model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Role, {includeRelations: true}),
        },
      },
    },
  })
  async findMyRoles(
    @inject(SecurityBindings.USER) currentUserProfile: UserProfile,
  ): Promise<object> {
	  
	let roles = (await this.roleRepository.find({where: {userId:currentUserProfile[securityId]}}));
	
    return roles;
  }
}
