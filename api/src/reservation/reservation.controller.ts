import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Request,
  UseGuards
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { plainToInstance } from 'class-transformer';
import { AccessGuard, Actions, UseAbility } from 'nest-casl';
import { Roles } from 'src/auth/decorators/roles.decorator';
import { RolesGuard } from 'src/auth/roles.guard';
import { UsersService } from 'src/users/users.service';
import { CreateReservationDto } from './dto/create-reservation.dto';
import { UpdateReservationDto } from './dto/update-reservation.dto';
import { Reservation } from './entities/reservation.entity';
import { ReservationService } from './reservation.service';

@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('reservations')
export class ReservationController {
  constructor(
    private readonly reservationsService: ReservationService,
    private readonly usersService: UsersService,
  ) { }

  @Post()
  @UseGuards(AccessGuard)
  @UseAbility(Actions.create, CreateReservationDto)
  async create(@Body() createReservationDto: CreateReservationDto, @Request() req) {
    const user = await this.usersService.findOneByEmail(req.user.email);
    if (!user) {
      throw new Error('User not found');
    }
    createReservationDto.user = user;
    return this.reservationsService.create(createReservationDto);
  }

  @Get()
  @Roles('admin')
  findAll() {
    return this.reservationsService.findAll();
  }

  @Get(':id')
  @Roles('admin')
  findOne(@Param('id') id: number) {
    return this.reservationsService.findOne(id);
  }

  @Put(':id')
  @Roles('admin')
  @UseGuards(AccessGuard)
  @UseAbility(Actions.update, UpdateReservationDto)
  update(@Param('id') id: number, @Body() updateReservationDto: UpdateReservationDto) {
    return plainToInstance(
      Reservation,
      this.reservationsService.update(id, updateReservationDto),
    );
  }

  @Delete(':id')
  @Roles('admin')
  @UseGuards(AccessGuard)
  @UseAbility(Actions.delete, Reservation, [
    ReservationService,
    async (service: ReservationService, { params }) => {
      return await service.findOne(params.id);
    },
  ])
  remove(@Param('id') id: number) {
    return this.reservationsService.remove(id);
  }
}
