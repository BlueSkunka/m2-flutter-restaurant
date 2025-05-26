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
  async create(@Body() createReservationDto: CreateReservationDto, @Request() req) {
    return this.reservationsService.create(createReservationDto);
  }

  @Get()
  findAll() {
    return this.reservationsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: number) {
    return this.reservationsService.findOne(id);
  }

  @Put(':id')
  @UseGuards(AccessGuard)
  @UseAbility(Actions.update, UpdateReservationDto)
  update(@Param('id') id: number, @Body() updateReservationDto: UpdateReservationDto) {
    return plainToInstance(
      Reservation,
      this.reservationsService.update(id, updateReservationDto),
    );
  }

  @Delete(':id')
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
