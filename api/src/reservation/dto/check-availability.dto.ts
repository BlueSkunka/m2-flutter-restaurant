import { IsDateString, Validate } from 'class-validator';
import { IsDateNotPast } from '../validators/is-date-not-past.validator';

export class CheckAvailabilityDto {
  @IsDateString()
  @Validate(IsDateNotPast)
  date: string;
} 