import { Actions, InferSubjects, Permissions } from 'nest-casl';
import Role from 'src/auth/roles';
import { CreateTimeSlotDto } from './dto/create-time-slot.dto';
import { UpdateTimeSlotDto } from './dto/update-time-slot.dto';
import { TimeSlot } from './entities/time-slot.entity';

export type Subjects = InferSubjects<
  typeof CreateTimeSlotDto | typeof UpdateTimeSlotDto | typeof TimeSlot
>;

export const permissions: Permissions<Role, Subjects, Actions> = {
  everyone({ can }) {
    can(Actions.read, TimeSlot);
  },

  admin({ can }) {
    can(Actions.create, CreateTimeSlotDto);
    can(Actions.update, UpdateTimeSlotDto);
    can(Actions.delete, TimeSlot);
  },
}; 