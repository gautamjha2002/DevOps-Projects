to_seconds = 24 * 60 * 60


def days_to_units(num_of_days):
        return f"{num_of_days} days are {num_of_days * to_seconds} seconds"


def validate_and_execute():
    if user_input.isdigit():
        days = int(user_input)
        if days > 0:
            days_to_sec = days_to_units(days)
            print(days_to_sec)
        elif days == 0:
            print("You entered 0 as  value please retry with valid value")

    else:
        print("You didn't entered a valid number please enter a valid number of days")

user_input = input("Hey, provide number of days I will convert it to seconds\n")
validate_and_execute()







