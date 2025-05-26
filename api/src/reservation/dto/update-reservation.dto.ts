import { IsNotEmpty } from 'class-validator';
import { TableEntity } from 'src/tables/entities/table.entity';
import { TimeSlot } from 'src/time-slots/entities/time-slot.entity';

export class UpdateReservationDto {
  @IsNotEmpty()
  table: TableEntity;

  @IsNotEmpty()
  timeSlot: TimeSlot;

  @IsNotEmpty()
  reservationDate: string;

  @IsNotEmpty()
  covers: number;
}
