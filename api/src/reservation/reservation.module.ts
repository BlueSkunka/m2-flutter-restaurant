import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CaslModule } from 'nest-casl';
import { Reservation } from './entities/reservation.entity';
import { ReservationController } from './reservation.controller';
import { permissions } from './reservation.permissions';
import { ReservationService } from './reservation.service';

@Module({
  controllers: [ReservationController],
  providers: [ReservationService],
  imports: [
    TypeOrmModule.forFeature([Reservation]),
    CaslModule.forFeature({ permissions }),
  ],
  exports: [ReservationService],
})
export class ReservationModule { }
