import { Exclude } from 'class-transformer';
import { IsEmail, IsNotEmpty, IsOptional } from 'class-validator';
import Roles from 'src/auth/roles';

export class UpdateUserDto {
  @IsEmail()
  email: string;

  @IsNotEmpty()
  firstname: string;

  @IsNotEmpty()
  lastname: string;

  @IsNotEmpty()
  phone: string;

  @IsNotEmpty()
  @IsOptional()
  plainPassword: string;

  @Exclude()
  password: string | undefined;

  @IsNotEmpty()
  role: Roles = Roles.Customer;
}
