// src/time-slots/time-slot.entity.ts

import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  OneToMany,
} from 'typeorm';

@Entity({ name: 'time_slots' })
export class TimeSlot {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'time', name: 'start_time' })
  startTime: string;

  @Column({ type: 'time', name: 'end_time' })
  endTime: string;
}