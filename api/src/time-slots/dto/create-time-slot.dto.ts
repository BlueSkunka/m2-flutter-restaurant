import { IsMilitaryTime } from "class-validator";

export class CreateTimeSlotDto {
    @IsMilitaryTime()
    startTime: string;
    
    @IsMilitaryTime()
    endTime: string;
}
