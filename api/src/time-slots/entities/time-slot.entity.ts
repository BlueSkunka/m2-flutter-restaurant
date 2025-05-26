import { Reservation } from 'src/reservation/entities/reservation.entity';
import {
  Column,
  Entity,
  OneToMany,
  PrimaryGeneratedColumn,
  Relation,
} from 'typeorm';

@Entity({ name: 'time_slots' })
export class TimeSlot {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'time', name: 'start_time' })
  startTime: string;

  @Column({ type: 'time', name: 'end_time' })
  endTime: string;

  @OneToMany(() => Reservation, (reservation) => reservation.timeSlot)
  reservations: Relation<Reservation>[];
}
