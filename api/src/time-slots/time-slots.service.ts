import { Injectable } from '@nestjs/common';
import { CreateTimeSlotDto } from './dto/create-time-slot.dto';
import { UpdateTimeSlotDto } from './dto/update-time-slot.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { TimeSlot } from './entities/time-slot.entity';
import { Repository } from 'typeorm';

@Injectable()
export class TimeSlotsService {
  constructor(
        @InjectRepository(TimeSlot)
        private timeSlotsRepository: Repository<TimeSlot>,
      ) {}
  
    create(createTimeSlotDto: CreateTimeSlotDto) {    
      return this.timeSlotsRepository.save(createTimeSlotDto);
    }
  
    findAll() {
      return this.timeSlotsRepository.find();
    }
  
    findOne(id: number) {
      return this.timeSlotsRepository.findOne({
        where: {
          id: id
        }
      });
    }
  
    async update(id: number, updateTimeSlotDto: UpdateTimeSlotDto) {
      await this.timeSlotsRepository.update(id, updateTimeSlotDto);
  
      return this.findOne(id);
    }
  
    remove(id: number) {
      return this.timeSlotsRepository.delete(id);;
    }
}
