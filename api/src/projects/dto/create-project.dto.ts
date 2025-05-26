import { IsNotEmpty, IsPositive } from 'class-validator';
import { User } from 'src/users/entities/user.entity';

export class CreateProjectDto {
  @IsNotEmpty()
  title: string;

  @IsNotEmpty()
  description: string;

  @IsNotEmpty()
  @IsPositive()
  budget: number;

  owner: User;
}
