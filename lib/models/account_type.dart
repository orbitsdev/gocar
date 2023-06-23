class AccountType {
  final String name;
  final String image;
  final String title;
  final String body;

  AccountType({
    required this.name,
    required this.image,
    required this.title,
    required this.body,
  });
}

List<AccountType> accountdata = [
  AccountType(
    name: 'Admin',
    image: 'admin.svg',
    title: 'Admin',
    body: 'Manage the car rental system and oversee operations.',
  ),
  AccountType(
    name: 'Client',
    image: 'users.svg',
    title: 'Client',
    body: 'Rent cars, view reservations, and manage personal information.',
  ),
  AccountType(
    name: 'Car Owner',
    image: 'rental.svg',
    title: 'Car Owner',
    body: 'List cars for rent, manage availability, and view earnings.',
  ),
];
