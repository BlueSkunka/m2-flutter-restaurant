import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CaslModule } from 'nest-casl';
import { TableEntity } from 'src/tables/entities/table.entity';
import { TimeSlot } from 'src/time-slots/entities/time-slot.entity';
import { Reservation } from './entities/reservation.entity';
import { ReservationController } from './reservation.controller';
import { permissions } from './reservation.permissions';
import { ReservationService } from './reservation.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([Reservation, TimeSlot, TableEntity]),
    CaslModule.forFeature({ permissions }),
  ],
  controllers: [ReservationController],
  providers: [ReservationService],
})
export class ReservationModule { }
