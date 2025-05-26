import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TableEntity } from 'src/tables/entities/table.entity';
import { TimeSlot } from 'src/time-slots/entities/time-slot.entity';
import { User } from 'src/users/entities/user.entity';
import { Repository } from 'typeorm';
import { CreateReservationDto } from './dto/create-reservation.dto';
import { UpdateReservationDto } from './dto/update-reservation.dto';
import { Reservation } from './entities/reservation.entity';

@Injectable()
export class ReservationService {
  constructor(
    @InjectRepository(Reservation)
    private reservationsRepository: Repository<Reservation>,
    @InjectRepository(TimeSlot)
    private timeSlotsRepository: Repository<TimeSlot>,
    @InjectRepository(TableEntity)
    private tablesRepository: Repository<TableEntity>,
  ) {
    console.log('ReservationService initialisé avec les repositories:', {
      hasReservationRepo: !!this.reservationsRepository,
      hasTimeSlotRepo: !!this.timeSlotsRepository,
      hasTableRepo: !!this.tablesRepository,
    });
  }

  create(createReservationDto: CreateReservationDto) {
    return this.reservationsRepository.save(createReservationDto);
  }

  findAll() {
    return this.reservationsRepository.find({
      relations: {
        user: true,
        table: true,
        timeSlot: true,
      },
      select: {
        user: {
          id: true,
          email: true,
          firstname: true,
          lastname: true,
          phone: true,
        },
      },
    });
  }

  findOne(id: number) {
    return this.reservationsRepository.findOne({
      where: {
        id,
      },
      relations: {
        user: true,
        table: true,
        timeSlot: true,
      },
      select: {
        user: {
          id: true,
          email: true,
          firstname: true,
          lastname: true,
          phone: true,
        },
      },
    });
  }

  async update(id: number, updateReservationDto: UpdateReservationDto) {
    await this.reservationsRepository.update(id, updateReservationDto);

    return this.findOne(id);
  }

  remove(id: number) {
    return this.reservationsRepository.delete({ id });
  }

  findByUser(user: User) {
    return this.reservationsRepository.find({
      where: {
        user: {
          id: user.id,
        },
      },
      relations: {
        timeSlot: true,
        table: true,
      },
    });
  }

  async checkAvailability(date: string) {
    // Récupérer tous les créneaux horaires
    const timeSlots = await this.timeSlotsRepository.find();
    console.log('TimeSlots trouvés:', timeSlots);

    // Récupérer toutes les tables
    const allTables = await this.tablesRepository.find();
    console.log('Tables trouvées:', allTables);

    // Récupérer les réservations pour la date donnée
    const reservations = await this.reservationsRepository.find({
      where: {
        reservationDate: new Date(date),
      },
      relations: {
        table: true,
        timeSlot: true,
      },
    });
    console.log('Réservations trouvées:', reservations);

    const inputDate = new Date(date);
    const today = new Date();
    const isToday = inputDate.toDateString() === today.toDateString();
    console.log('Date demandée:', inputDate);
    console.log('Est aujourd\'hui:', isToday);

    // Pour chaque créneau, déterminer les tables disponibles
    const availability = timeSlots
      .filter(timeSlot => {
        if (!isToday) return true;

        // Si c'est aujourd'hui, on ne garde que les créneaux futurs
        const [hours, minutes] = timeSlot.startTime.split(':').map(Number);
        const slotTime = new Date();
        slotTime.setHours(hours, minutes, 0, 0);

        const isFuture = slotTime > today;
        console.log(`Créneau ${timeSlot.startTime} - ${timeSlot.endTime} est futur:`, isFuture);
        return isFuture;
      })
      .map(timeSlot => {
        // Trouver les réservations pour ce créneau
        const timeSlotReservations = reservations.filter(
          reservation => reservation.timeSlot.id === timeSlot.id
        );
        console.log(`Réservations pour le créneau ${timeSlot.startTime}:`, timeSlotReservations);

        // Trouver les tables déjà réservées pour ce créneau
        const reservedTableIds = timeSlotReservations.map(
          reservation => reservation.table?.id
        ).filter(id => id !== undefined);
        console.log('Tables réservées:', reservedTableIds);

        // Filtrer les tables disponibles
        const availableTables = allTables.filter(
          table => !reservedTableIds.includes(table.id)
        );
        console.log('Tables disponibles:', availableTables);

        return {
          timeSlot: {
            id: timeSlot.id,
            startTime: timeSlot.startTime,
            endTime: timeSlot.endTime,
          },
          availableTables: availableTables.map(table => ({
            id: table.id,
            name: table.name,
            capacity: table.capacity,
          })),
        };
      });

    console.log('Résultat final:', availability);
    return availability;
  }
}
