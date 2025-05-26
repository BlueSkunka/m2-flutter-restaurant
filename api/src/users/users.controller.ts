import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Post,
  Put,
  Request,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { plainToInstance } from 'class-transformer';
import { Roles } from 'src/auth/decorators/roles.decorator';
import { RolesGuard } from 'src/auth/roles.guard';
import { ReservationService } from 'src/reservation/reservation.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { User } from './entities/user.entity';
import { UsersService } from './users.service';

@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('users')
export class UsersController {
  constructor(
    private readonly usersService: UsersService,
    private readonly reservationService: ReservationService,
  ) { }

  @Post()
  @Roles('admin')
  create(@Body() createUserDto: CreateUserDto) {
    return plainToInstance(User, this.usersService.create(createUserDto));
  }

  @Get()
  @Roles('admin')
  findAll() {
    return this.usersService.findAll();
  }

  @Get('/profile')
  profile(@Request() req) {
    return plainToInstance(
      User,
      this.usersService.findOneByEmail(req.user.email),
    );
  }

  @Put('/profile')
  update_profile(@Request() req, @Body() updateUserDto: UpdateUserDto) {
    return plainToInstance(
      User,
      this.usersService.update(req.user.email, updateUserDto),
    );
  }

  @Delete(':id')
  @Roles('admin')
  delete(@Param('id') id: string) {
    return this.usersService.remove(id);
  }

  @Get('/reservations')
  async getUserReservations(@Request() req) {
    const user = await this.usersService.findOneByEmail(req.user.email);
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return this.reservationService.findByUser(user);
  }
}
