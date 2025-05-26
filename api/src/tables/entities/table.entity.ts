import { Reservation } from 'src/reservation/entities/reservation.entity';
import {
  Column,
  Entity,
  OneToMany,
  PrimaryGeneratedColumn,
  Relation,
} from 'typeorm';

@Entity({ name: 'tables' })
export class TableEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ type: 'tinyint', unsigned: true })
  capacity: number;

  @OneToMany(() => Reservation, (reservation) => reservation.table)
  reservations: Relation<Reservation>[];
}
