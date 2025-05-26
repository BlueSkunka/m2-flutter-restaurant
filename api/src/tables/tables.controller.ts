import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, HttpCode, Put } from '@nestjs/common';
import { TablesService } from './tables.service';
import { CreateTableDto } from './dto/create-table.dto';
import { UpdateTableDto } from './dto/update-table.dto';
import { AuthGuard } from '@nestjs/passport';
import { RolesGuard } from 'src/auth/roles.guard';
import { Roles } from 'src/auth/decorators/roles.decorator';
import { plainToInstance } from 'class-transformer';
import { TableEntity } from './entities/table.entity';

@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('tables')
export class TablesController {
  constructor(private readonly tablesService: TablesService) {}

  @Post()
  @Roles('waiter')
  create(@Body() createTableDto: CreateTableDto) {
    return plainToInstance(TableEntity, this.tablesService.create(createTableDto));
  }

  @Get()
  @Roles('waiter')
  findAll() {
    return plainToInstance(TableEntity, this.tablesService.findAll());
  }

  @Get(':id')
  @Roles('waiter')
  findOne(@Param('id') id: string) {
    return plainToInstance(TableEntity, this.tablesService.findOne(+id));
  }

  @Put(':id')
  @Roles('waiter')
  update(@Param('id') id: string, @Body() updateTableDto: UpdateTableDto) {
    return plainToInstance(TableEntity, this.tablesService.update(+id, updateTableDto));
  }

  @Delete(':id')
  @Roles('waiter')
  @HttpCode(204)
  remove(@Param('id') id: string) {
    return null;
  }
}
