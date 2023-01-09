to_seconds = 24 * 60 * 60


def days_to_units():
    print(f"20 days are {20 * to_seconds} seconds")


days_to_units()

def days_to_units(num_of_days):
    print(f"{num_of_days} days are {num_of_days * to_seconds} seconds")




days_to_units(40)
days_to_units(50)
days_to_units(60)
days_to_units(70)

def days_to_units(num_of_days, custom_message):
    print(f"{num_of_days} days are {num_of_days * to_seconds} seconds")
    print(custom_message)

days_to_units(30,"How you doin...")