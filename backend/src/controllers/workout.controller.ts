import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where,
} from '@loopback/repository';
import {authenticate, TokenService} from '@loopback/authentication';

import {
  Credentials,
  MyUserService,
  TokenServiceBindings,
  User,
  UserRepository,
  UserServiceBindings,
} from '@loopback/authentication-jwt';
import {
  post,
  param,
  get,
  getModelSchemaRef,
  patch,
  put,
  del,
  requestBody,
  response,
} from '@loopback/rest';
import {Workout} from '../models';
import {WorkoutRepository} from '../repositories';
import {inject} from '@loopback/core';
import {SecurityBindings, securityId, UserProfile} from '@loopback/security';

@authenticate('jwt')
export class WorkoutController {
  constructor(
  @inject(TokenServiceBindings.TOKEN_SERVICE)
    public jwtService: TokenService,
    @inject(UserServiceBindings.USER_SERVICE)
    public userService: MyUserService,
    @inject(SecurityBindings.USER, {optional: true})
    public user: UserProfile,
	@repository(UserRepository) protected userRepository: UserRepository,
    @repository(WorkoutRepository)
    public workoutRepository : WorkoutRepository,
  ) {}

  @post('/workouts')
  @response(200, {
    description: 'Workout model instance',
    content: {'application/json': {schema: getModelSchemaRef(Workout)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Workout, {
            title: 'NewWorkout',
            exclude: ['id'],
          }),
        },
      },
    })
    workout: Omit<Workout, 'id'>,
  ): Promise<Workout> {
	  workout.created_on = new Date().getTime().toString();
    return this.workoutRepository.create(workout);
  }

  @get('/workouts/count')
  @response(200, {
    description: 'Workout model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Workout) where?: Where<Workout>,
  ): Promise<Count> {
    return this.workoutRepository.count(where);
  }

  @get('/workouts')
  @response(200, {
    description: 'Array of Workout model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Workout, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(Workout) filter?: Filter<Workout>,
  ): Promise<Workout[]> {
    return this.workoutRepository.find(filter);
  }
  
  
  @get('/my_workouts')
  @response(200, {
    description: 'Array of Workout model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Workout, {includeRelations: true}),
        },
      },
    },
  })
  async findMyWorkouts(@inject(SecurityBindings.USER) currentUserProfile: UserProfile): Promise<Workout[]> {
    return this.workoutRepository.find({where: {userId:currentUserProfile[securityId]}});
  }
  
  @get('/my_created_workouts')
  @response(200, {
    description: 'Array of Workout model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Workout, {includeRelations: true}),
        },
      },
    },
  })
  async findCreatedWorkouts(@inject(SecurityBindings.USER) currentUserProfile: UserProfile): Promise<Workout[]> {
    return this.workoutRepository.find({where: {coachId:currentUserProfile[securityId]}});
  }
  
  
  @post('/workouts_for_user')
  @response(200, {
    description: 'Array of Workout model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Workout, {includeRelations: true}),
        },
      },
    },
  })
  async findWorkoutsForUser(@inject(SecurityBindings.USER) currentUserProfile: UserProfile,
  @requestBody(
      {
        description: 'Required input for image upload',
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
      }) user:User): Promise<Workout[]> {
    return this.workoutRepository.find({where: {userId:user.id}});
  }
  
  
  @post('/my_created_workouts_for_user')
  @response(200, {
    description: 'Array of Workout model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Workout, {includeRelations: true}),
        },
      },
    },
  })
  async findCreatedWorkoutsForUser(@inject(SecurityBindings.USER) currentUserProfile: UserProfile,
  @requestBody(
      {
        description: 'Required input for image upload',
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
      }) user:User): Promise<Workout[]> {
    return this.workoutRepository.find({where: {coachId:currentUserProfile[securityId], userId:user.id}});
  }

  @patch('/workouts')
  @response(200, {
    description: 'Workout PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Workout, {partial: true}),
        },
      },
    })
    workout: Workout,
    @param.where(Workout) where?: Where<Workout>,
  ): Promise<Count> {
    return this.workoutRepository.updateAll(workout, where);
  }

  @get('/workouts/{id}')
  @response(200, {
    description: 'Workout model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Workout, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.string('id') id: string,
    @param.filter(Workout, {exclude: 'where'}) filter?: FilterExcludingWhere<Workout>
  ): Promise<Workout> {
    return this.workoutRepository.findById(id, filter);
  }

  @patch('/workouts/{id}')
  @response(204, {
    description: 'Workout PATCH success',
  })
  async updateById(
    @param.path.string('id') id: string,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Workout, {partial: true}),
        },
      },
    })
    workout: Workout,
  ): Promise<void> {
    await this.workoutRepository.updateById(id, workout);
  }

  @put('/workouts/{id}')
  @response(204, {
    description: 'Workout PUT success',
  })
  async replaceById(
    @param.path.string('id') id: string,
    @requestBody() workout: Workout,
  ): Promise<void> {
    await this.workoutRepository.replaceById(id, workout);
  }

  @del('/workouts/{id}')
  @response(204, {
    description: 'Workout DELETE success',
  })
  async deleteById(@param.path.string('id') id: string): Promise<void> {
    await this.workoutRepository.deleteById(id);
  }
}
