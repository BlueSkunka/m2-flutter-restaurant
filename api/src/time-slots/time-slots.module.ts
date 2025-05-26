import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CaslModule } from 'nest-casl';
import { TimeSlot } from './entities/time-slot.entity';
import { TimeSlotsController } from './time-slots.controller';
import { permissions } from './time-slots.permissions';
import { TimeSlotsService } from './time-slots.service';

@Module({
  controllers: [TimeSlotsController],
  providers: [TimeSlotsService],
  imports: [
    TypeOrmModule.forFeature([TimeSlot]),
    CaslModule.forFeature({ permissions }),
  ],
})
export class TimeSlotsModule { }
