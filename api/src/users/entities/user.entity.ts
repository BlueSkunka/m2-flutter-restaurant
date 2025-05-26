import { Exclude } from 'class-transformer';
import Role from 'src/auth/roles';
import { Project } from 'src/projects/entities/project.entity';
import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';

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

  @OneToMany(() => Project, (project) => project.owner)
  projects: Project[];
}
