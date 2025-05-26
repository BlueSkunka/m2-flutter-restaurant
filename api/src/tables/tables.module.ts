import { Module } from '@nestjs/common';
import { TablesService } from './tables.service';
import { TablesController } from './tables.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TableEntity } from './entities/table.entity';

@Module({
  controllers: [TablesController],
  providers: [TablesService],
  imports: [TypeOrmModule.forFeature([TableEntity])],
})
export class TablesModule {}
