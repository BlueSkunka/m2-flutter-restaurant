import { Exclude } from 'class-transformer';
import Role from 'src/auth/roles';
import { Reservation } from 'src/reservation/entities/reservation.entity';
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true })
  email: string;

  @Column()
  firstname: string;

  @Column()
  lastname: string;

  @Column()
  phone: string;

  @Column()
  @Exclude()
  password: string;

  @Exclude()
  plainPassword: string | undefined;

  @Column()
  roles: Role = Role.Customer;

  @OneToMany(() => Reservation, (reservation) => reservation.user)
  reservations: Reservation[];
}
