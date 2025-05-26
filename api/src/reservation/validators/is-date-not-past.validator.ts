import { ValidationArguments, ValidatorConstraint, ValidatorConstraintInterface } from 'class-validator';

@ValidatorConstraint({ name: 'isDateNotPast', async: false })
export class IsDateNotPast implements ValidatorConstraintInterface {
  validate(date: string, args: ValidationArguments) {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const inputDate = new Date(date);
    inputDate.setHours(0, 0, 0, 0);

    return inputDate >= today;
  }

  defaultMessage(args: ValidationArguments) {
    return 'La date doit être supérieure ou égale à aujourd\'hui';
  }
} 