to_seconds = 24 * 60 * 60


def days_to_units(num_of_days):
    print(f"{num_of_days} days are {num_of_days * to_seconds} seconds")


days = int(input("Hey, provide number of days I will convert it to seconds\n"))

days_to_units(days)