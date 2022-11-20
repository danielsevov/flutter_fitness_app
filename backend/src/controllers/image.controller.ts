// Uncomment these imports to begin using these cool features!

// import {inject} from '@loopback/core';
import { inject } from '@loopback/core';
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
import { ImageRepository } from '../repositories';
import { Image } from '../models';
import { SecurityBindings, securityId, UserProfile } from '@loopback/security';

@authenticate('jwt')
export class ImageController {
  constructor(@inject(TokenServiceBindings.TOKEN_SERVICE)
    public jwtService: TokenService,
    @inject(UserServiceBindings.USER_SERVICE)
    public userService: MyUserService,
    @inject(SecurityBindings.USER, {optional: true})
    public user: UserProfile,
	@repository(UserRepository) protected userRepository: UserRepository,
	@repository(ImageRepository) protected imgRepo : ImageRepository,) {}
  
  @get('/profile_images')
  async request_profile_images(
  @inject(SecurityBindings.USER) currentUserProfile: UserProfile,
  ) : Promise<Image[]> {
	return this.imgRepo.find({ where: { user_id: currentUserProfile[securityId], type: 'profile' } });
  }
  
  @get('/images')
  async request_images(
  @inject(SecurityBindings.USER) currentUserProfile: UserProfile,
  ) : Promise<Image[]> {
	return this.imgRepo.find({ where: { user_id: currentUserProfile[securityId] } });
  }
  
  //Upload picture to spot
  @post('/images')
  async upload_image(
  @inject(SecurityBindings.USER) currentUserProfile: UserProfile,
  @requestBody(
      {
        description: 'Required input for image upload',
        required: true,
        content: {
          'application/json': {
            schema: {
              type: 'object',
			  required: ['data', 'type'],
              properties: {
				data:{
                  type: 'string',
                },
                type: {
                  type: 'string',
                }
				
              },
            },
          }
        },
      }) img: Image
  ) {	
	img.user_id = currentUserProfile[securityId];
	img.date = new Date().getTime().toString();
		await this.imgRepo.create(img);
		return {'SUCCES':'image_uploaded'};
  }
  
  
  //Upload picture to spot
  @patch('/images')
  async reupload_image(
  @inject(SecurityBindings.USER) currentUserProfile: UserProfile,
  @requestBody(
      {
        description: 'Required input for image upload',
        required: true,
        content: {
          'application/json': {
            schema: {
              type: 'object',
			  required: ['data', 'type'],
              properties: {
				data:{
                  type: 'string',
                },
                type: {
                  type: 'string',
                },
				id: {
                  type: 'number',
                },
				
              },
            },
          }
        },
      }) img: Image
  ) {	
	img.user_id = currentUserProfile[securityId];
	img.date = new Date().getTime().toString();
	
		let newImg = new Image();
		newImg.data = img.data;
		newImg.type = img.type;
		await this.imgRepo.updateById(img.id, newImg);
		return {'SUCCES':'image_uploaded'};
  }
  
  @del('/images/{id}')
  @response(204, {
    description: 'Image DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.imgRepo.deleteById(id);
  }
  
  @post('/images_for_user')
  @response(204, {
    description: 'Image for user success',
  })
  async findImagesForUser(@requestBody(
      {
        description: 'Required input for image upload',
        required: true,
        content: {
          'application/json': {
            schema: {
              type: 'object',
			  required: ['user_id'],
              properties: {
				user_id:{
                  type: 'string',
                },				
              },
            },
          }
        },
      }) img: Image): Promise<Image[]> {
    return await this.imgRepo.find({ where: { user_id: img.user_id } });
  }
  
  @patch('/images/{id}')
  @response(204, {
    description: 'Image PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Image, {partial: true}),
        },
      },
    })
    img: Image,
  ): Promise<void> {
    await this.imgRepo.updateById(id, img);
  }
  
  @post('/profile_images_for_user')
  @response(204, {
    description: 'Image for user success',
  })
  async findProfileImagesForUser(@requestBody(
      {
        description: 'Required input for image upload',
        required: true,
        content: {
          'application/json': {
            schema: {
              type: 'object',
			  required: ['user_id'],
              properties: {
				user_id:{
                  type: 'string',
                },				
              },
            },
          }
        },
      }) img: Image): Promise<Image[]> {
    return await this.imgRepo.find({ where: { user_id: img.user_id, type: 'profile' } });
  }
}
