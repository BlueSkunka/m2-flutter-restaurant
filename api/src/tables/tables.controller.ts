import { Body, Controller, Delete, Get, HttpCode, Param, Post, Put, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { plainToInstance } from 'class-transformer';
import { Roles } from 'src/auth/decorators/roles.decorator';
import { RolesGuard } from 'src/auth/roles.guard';
import { CreateTableDto } from './dto/create-table.dto';
import { UpdateTableDto } from './dto/update-table.dto';
import { TableEntity } from './entities/table.entity';
import { TablesService } from './tables.service';

@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('tables')
export class TablesController {
  constructor(private readonly tablesService: TablesService) { }

  @Post()
  @Roles('admin')
  create(@Body() createTableDto: CreateTableDto) {
    return plainToInstance(TableEntity, this.tablesService.create(createTableDto));
  }

  @Get()
  findAll() {
    return plainToInstance(TableEntity, this.tablesService.findAll());
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return plainToInstance(TableEntity, this.tablesService.findOne(+id));
  }

  @Put(':id')
  @Roles('admin')
  update(@Param('id') id: string, @Body() updateTableDto: UpdateTableDto) {
    return plainToInstance(TableEntity, this.tablesService.update(+id, updateTableDto));
  }

  @Delete(':id')
  @Roles('admin')
  @HttpCode(204)
  remove(@Param('id') id: string) {
    return this.tablesService.remove(+id);
  }
}
