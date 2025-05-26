import { Body, Controller, Delete, Get, HttpCode, Param, Post, Put, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { plainToInstance } from 'class-transformer';
import { Roles } from 'src/auth/decorators/roles.decorator';
import { RolesGuard } from 'src/auth/roles.guard';
import { CreateTimeSlotDto } from './dto/create-time-slot.dto';
import { UpdateTimeSlotDto } from './dto/update-time-slot.dto';
import { TimeSlot } from './entities/time-slot.entity';
import { TimeSlotsService } from './time-slots.service';

@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('time-slots')
export class TimeSlotsController {
  constructor(private readonly timeSlotsService: TimeSlotsService) { }

  @Post()
  @Roles('admin')
  create(@Body() createTimeSlotDto: CreateTimeSlotDto) {
    return plainToInstance(TimeSlot, this.timeSlotsService.create(createTimeSlotDto));
  }

  @Get()
  findAll() {
    return plainToInstance(TimeSlot, this.timeSlotsService.findAll());
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return plainToInstance(TimeSlot, this.timeSlotsService.findOne(+id));
  }

  @Put(':id')
  @Roles('admin')
  update(@Param('id') id: string, @Body() updateTimeSlotDto: UpdateTimeSlotDto) {
    return plainToInstance(TimeSlot, this.timeSlotsService.update(+id, updateTimeSlotDto));
  }

  @Delete(':id')
  @Roles('admin')
  @HttpCode(204)
  remove(@Param('id') id: string) {
    return this.timeSlotsService.remove(+id);
  }
}
