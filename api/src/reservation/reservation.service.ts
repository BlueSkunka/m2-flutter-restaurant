import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/users/entities/user.entity';
import { Repository } from 'typeorm';
import { CreateReservationDto } from './dto/create-reservation.dto';
import { UpdateReservationDto } from './dto/update-reservation.dto';
import { Reservation } from './entities/reservation.entity';

@Injectable()
export class ReservationService {
  constructor(
    @InjectRepository(Reservation)
    private reservationsRepository: Repository<Reservation>,
  ) { }

  create(createReservationDto: CreateReservationDto) {
    return this.reservationsRepository.save(createReservationDto);
  }

  findAll() {
    return this.reservationsRepository.find({
      relations: {
        user: true,
        table: true,
        timeSlot: true,
      },
      select: {
        user: {
          id: true,
          email: true,
          firstname: true,
          lastname: true,
          phone: true,
        },
      },
    });
  }

  findOne(id: number) {
    return this.reservationsRepository.findOne({
      where: {
        id,
      },
      relations: {
        user: true,
        table: true,
        timeSlot: true,
      },
      select: {
        user: {
          id: true,
          email: true,
          firstname: true,
          lastname: true,
          phone: true,
        },
      },
    });
  }

  async update(id: number, updateReservationDto: UpdateReservationDto) {
    await this.reservationsRepository.update(id, updateReservationDto);

    return this.findOne(id);
  }

  remove(id: number) {
    return this.reservationsRepository.delete({ id });
  }

  findByUser(user: User) {
    return this.reservationsRepository.find({
      where: {
        user: {
          id: user.id,
        },
      },
    });
  }
}
