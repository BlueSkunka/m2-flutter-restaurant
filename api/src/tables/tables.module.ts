import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CaslModule } from 'nest-casl';
import { TableEntity } from './entities/table.entity';
import { TablesController } from './tables.controller';
import { permissions } from './tables.permissions';
import { TablesService } from './tables.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([TableEntity]),
    CaslModule.forFeature({ permissions }),
  ],
  controllers: [TablesController],
  providers: [TablesService],
})
export class TablesModule { }
