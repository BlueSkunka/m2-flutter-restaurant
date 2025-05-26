import { IsNotEmpty, IsPositive } from "class-validator";

export class CreateTableDto {
    @IsNotEmpty()
    name: string;

    @IsNotEmpty()
    @IsPositive()
    capacity: number;
}
