import { Exclude } from 'class-transformer';
import { IsEmail, IsNotEmpty } from 'class-validator';
import Roles from 'src/auth/roles';

export class CreateUserDto {
  @IsEmail()
  email: string;

  @IsNotEmpty()
  firstname: string;

  @IsNotEmpty()
  lastname: string;

  @IsNotEmpty()
  phone: string;

  @IsNotEmpty()
  plainPassword: string;

  @Exclude()
  password: string | undefined;

  @IsNotEmpty()
  roles: Roles;
}
