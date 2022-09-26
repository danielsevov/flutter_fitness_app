import {authenticate, TokenService} from '@loopback/authentication';
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
import {Exercise} from '../models';
import {ExerciseRepository} from '../repositories';

@authenticate('jwt')
export class ExerciseControllerController {
  constructor(
    @repository(ExerciseRepository)
    public exerciseRepository : ExerciseRepository,
  ) {}

  @post('/exercises')
  @response(200, {
    description: 'Exercise model instance',
    content: {'application/json': {schema: getModelSchemaRef(Exercise)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Exercise, {
            title: 'NewExercise',
            exclude: ['id'],
          }),
        },
      },
    })
    exercise: Omit<Exercise, 'id'>,
  ): Promise<Exercise> {
    return this.exerciseRepository.create(exercise);
  }

  @get('/exercises/count')
  @response(200, {
    description: 'Exercise model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Exercise) where?: Where<Exercise>,
  ): Promise<Count> {
    return this.exerciseRepository.count(where);
  }

  @get('/exercises')
  @response(200, {
    description: 'Array of Exercise model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Exercise, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(Exercise) filter?: Filter<Exercise>,
  ): Promise<Exercise[]> {
    return this.exerciseRepository.find(filter);
  }

  @patch('/exercises')
  @response(200, {
    description: 'Exercise PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Exercise, {partial: true}),
        },
      },
    })
    exercise: Exercise,
    @param.where(Exercise) where?: Where<Exercise>,
  ): Promise<Count> {
    return this.exerciseRepository.updateAll(exercise, where);
  }

  @get('/exercises/{id}')
  @response(200, {
    description: 'Exercise model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Exercise, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.string('id') id: string,
    @param.filter(Exercise, {exclude: 'where'}) filter?: FilterExcludingWhere<Exercise>
  ): Promise<Exercise> {
    return this.exerciseRepository.findById(id, filter);
  }

  @patch('/exercises/{id}')
  @response(204, {
    description: 'Exercise PATCH success',
  })
  async updateById(
    @param.path.string('id') id: string,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Exercise, {partial: true}),
        },
      },
    })
    exercise: Exercise,
  ): Promise<void> {
    await this.exerciseRepository.updateById(id, exercise);
  }

  @put('/exercises/{id}')
  @response(204, {
    description: 'Exercise PUT success',
  })
  async replaceById(
    @param.path.string('id') id: string,
    @requestBody() exercise: Exercise,
  ): Promise<void> {
    await this.exerciseRepository.replaceById(id, exercise);
  }

  @del('/exercises/{id}')
  @response(204, {
    description: 'Exercise DELETE success',
  })
  async deleteById(@param.path.string('id') id: string): Promise<void> {
    await this.exerciseRepository.deleteById(id);
  }
}
