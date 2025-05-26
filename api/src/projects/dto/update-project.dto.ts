import { IsNotEmpty, IsPositive } from 'class-validator';

export class UpdateProjectDto {
  @IsNotEmpty()
  title: string;

  @IsNotEmpty()
  description: string;

  @IsNotEmpty()
  @IsPositive()
  budget: number;

  ownerId: number;
}
