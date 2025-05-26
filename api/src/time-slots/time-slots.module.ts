import { Module } from '@nestjs/common';
import { TimeSlotsService } from './time-slots.service';
import { TimeSlotsController } from './time-slots.controller';
import { TimeSlot } from './entities/time-slot.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  controllers: [TimeSlotsController],
  providers: [TimeSlotsService],
  imports: [TypeOrmModule.forFeature([TimeSlot])],
})
export class TimeSlotsModule {}
