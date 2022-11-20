import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where,
} from '@loopback/repository';
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
import {authenticate, TokenService} from '@loopback/authentication';
import {
  Credentials,
  MyUserService,
  TokenServiceBindings,
  User,
  UserRepository,
  UserServiceBindings,
} from '@loopback/authentication-jwt';
import {Habit} from '../models';
import {HabitRepository} from '../repositories';
import {inject} from '@loopback/core';
import {SecurityBindings, securityId, UserProfile} from '@loopback/security';

@authenticate('jwt')
export class HabitController {
  constructor(
  @inject(TokenServiceBindings.TOKEN_SERVICE)
    public jwtService: TokenService,
    @inject(UserServiceBindings.USER_SERVICE)
    public userService: MyUserService,
    @inject(SecurityBindings.USER, {optional: true})
    public user: UserProfile,
	@repository(UserRepository) protected userRepository: UserRepository,
    @repository(HabitRepository)
    public habitRepository : HabitRepository,
  ) {}

  @post('/habits')
  @response(200, {
    description: 'Habit model instance',
    content: {'application/json': {schema: getModelSchemaRef(Habit)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Habit, {
            title: 'NewHabit',
            exclude: ['id'],
          }),
        },
      },
    })
    habit: Omit<Habit, 'id'>,
  ): Promise<Habit> {
    return this.habitRepository.create(habit);
  }

  @get('/habits/count')
  @response(200, {
    description: 'Habit model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Habit) where?: Where<Habit>,
  ): Promise<Count> {
    return this.habitRepository.count(where);
  }

  @get('/habits')
  @response(200, {
    description: 'Array of Habit model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Habit, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(Habit) filter?: Filter<Habit>,
  ): Promise<Habit[]> {
    return this.habitRepository.find(filter);
  }

@get('/habits_templates')
  @response(200, {
    description: 'Array of Habit model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Habit, {includeRelations: true}),
        },
      },
    },
  })
  async findTemplates(): Promise<Habit[]> {
    return this.habitRepository.find({where: {is_template:true}});
  }

@get('/my_template_habit')
  @response(200, {
    description: 'Array of Habit model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Habit, {includeRelations: true}),
        },
      },
    },
  })
  async findMyTemplate(@inject(SecurityBindings.USER) currentUserProfile: UserProfile): Promise<Habit[]> {
    return this.habitRepository.find({where: {userId:currentUserProfile[securityId], is_template:true}});
  }
  
  
  @get('/my_habits')
  @response(200, {
    description: 'Array of Habit model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Habit, {includeRelations: true}),
        },
      },
    },
  })
  async findMyHabits(@inject(SecurityBindings.USER) currentUserProfile: UserProfile): Promise<Habit[]> {
    return this.habitRepository.find({where: {userId:currentUserProfile[securityId], is_template:false}});
  }
  
  
  @post('/user_template_habit')
  @response(200, {
    description: 'Array of Habit model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Habit, {includeRelations: true}),
        },
      },
    },
  })
  async findUserTemplate(@requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Habit, {partial: true}),
        },
      },
    })
    habit: Habit, 
	@inject(SecurityBindings.USER) currentUserProfile: UserProfile): Promise<Habit[]> {
    return this.habitRepository.find({where: {userId:habit.userId, is_template:true}});
  }



  @patch('/habits')
  @response(200, {
    description: 'Habit PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Habit, {partial: true}),
        },
      },
    })
    habit: Habit,
    @param.where(Habit) where?: Where<Habit>,
  ): Promise<Count> {
    return this.habitRepository.updateAll(habit, where);
  }

  @get('/habits/{id}')
  @response(200, {
    description: 'Habit model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Habit, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(Habit, {exclude: 'where'}) filter?: FilterExcludingWhere<Habit>
  ): Promise<Habit> {
    return this.habitRepository.findById(id, filter);
  }

  @patch('/habits/{id}')
  @response(204, {
    description: 'Habit PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Habit, {partial: true}),
        },
      },
    })
    habit: Habit,
  ): Promise<void> {
    await this.habitRepository.updateById(id, habit);
  }

  @put('/habits/{id}')
  @response(204, {
    description: 'Habit PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() habit: Habit,
  ): Promise<void> {
    await this.habitRepository.replaceById(id, habit);
  }

  @del('/habits/{id}')
  @response(204, {
    description: 'Habit DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.habitRepository.deleteById(id);
  }
}
