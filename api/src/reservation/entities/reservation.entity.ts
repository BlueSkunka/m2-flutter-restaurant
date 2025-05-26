import { TableEntity } from 'src/tables/entities/table.entity';
import { TimeSlot } from 'src/time-slots/entities/time-slot.entity';
import { User } from 'src/users/entities/user.entity';
import {
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
  Relation,
  UpdateDateColumn,
} from 'typeorm';

export enum ReservationStatus {
  PENDING = 'pending',
  CONFIRMED = 'confirmed',
  REFUSED = 'refused',
  CANCELLED = 'cancelled',
}

@Entity({ name: 'reservations' })
export class Reservation {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User, (user) => user.reservations, {
    nullable: false,
    onDelete: 'CASCADE',
  })
  user: Relation<User>;

  @ManyToOne(() => TableEntity, (table) => table.reservations, {
    nullable: true,
    onDelete: 'SET NULL',
  })
  table: Relation<TableEntity>;

  @ManyToOne(() => TimeSlot, (timeSlot) => timeSlot.reservations, {
    nullable: false,
    onDelete: 'RESTRICT',
  })
  timeSlot: Relation<TimeSlot>;

  @Column({ type: 'date', name: 'reservation_date' })
  reservationDate: string;

  @Column({ type: 'tinyint', unsigned: true })
  covers: number;

  @Column({
    type: 'enum',
    enum: ReservationStatus,
    default: ReservationStatus.PENDING,
  })
  status: ReservationStatus;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt: Date;
}
