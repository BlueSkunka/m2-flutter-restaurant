import { Actions, InferSubjects, Permissions } from 'nest-casl';
import Role from 'src/auth/roles';
import { CreateTableDto } from './dto/create-table.dto';
import { UpdateTableDto } from './dto/update-table.dto';
import { TableEntity } from './entities/table.entity';

export type Subjects = InferSubjects<
  typeof CreateTableDto | typeof UpdateTableDto | typeof TableEntity
>;

export const permissions: Permissions<Role, Subjects, Actions> = {
  everyone({ can }) {
    can(Actions.read, TableEntity);
  },

  admin({ can }) {
    can(Actions.create, CreateTableDto);
    can(Actions.update, UpdateTableDto);
    can(Actions.delete, TableEntity);
  },
}; 