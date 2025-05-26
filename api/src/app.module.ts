import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CaslModule } from 'nest-casl';
import { typeOrmConfig } from 'ormconfig';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import Roles from './auth/roles';
import { ReservationModule } from './reservation/reservation.module';
import { TablesModule } from './tables/tables.module';
import { TimeSlotsModule } from './time-slots/time-slots.module';
import { UsersModule } from './users/users.module';

@Module({
  imports: [
    ConfigModule.forRoot(),
    UsersModule,
    TypeOrmModule.forRoot(typeOrmConfig),
    AuthModule,
    CaslModule.forRoot<Roles>({
      getUserFromRequest: (request) => request.user,
    }),
    TablesModule,
    TimeSlotsModule,
    ReservationModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
