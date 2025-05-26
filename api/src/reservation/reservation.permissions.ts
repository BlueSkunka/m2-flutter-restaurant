import { Actions, InferSubjects, Permissions } from 'nest-casl';
import Role from 'src/auth/roles';
import { CreateReservationDto } from './dto/create-reservation.dto';
import { UpdateReservationDto } from './dto/update-reservation.dto';
import { Reservation } from './entities/reservation.entity';

export type Subjects = InferSubjects<
  typeof CreateReservationDto | typeof UpdateReservationDto | typeof Reservation
>;

export const permissions: Permissions<Role, Subjects, Actions> = {
  everyone({ can }) {
    can(Actions.read, 'all');
  },

  admin({ can }) {
    can(Actions.delete, 'all');
  },
};
