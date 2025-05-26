import { Injectable } from '@nestjs/common';
import { CreateTableDto } from './dto/create-table.dto';
import { UpdateTableDto } from './dto/update-table.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { TableEntity } from './entities/table.entity';
import { Repository } from 'typeorm';

@Injectable()
export class TablesService {
  constructor(
      @InjectRepository(TableEntity)
      private tablesRepository: Repository<TableEntity>,
    ) {}

  create(createTableDto: CreateTableDto) {    
    return this.tablesRepository.save(createTableDto);
  }

  findAll() {
    return this.tablesRepository.find();
  }

  findOne(id: number) {
    return this.tablesRepository.findOne({
      where: {
        id: id
      }
    });
  }

  async update(id: number, updateTableDto: UpdateTableDto) {
    await this.tablesRepository.update(id, updateTableDto);

    return this.findOne(id);
  }

  remove(id: number) {
    return this.tablesRepository.delete(id);;
  }
}
