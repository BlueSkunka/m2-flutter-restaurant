import {
  Column,
  Entity,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

import { User } from 'src/users/entities/user.entity';

@Entity()
export class Project {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  title: string;

  @Column()
  description: string;

  @Column()
  budget: number;

  @ManyToOne(() => User, (user) => user.projects, { onDelete: 'CASCADE' })
  owner: User;
}
