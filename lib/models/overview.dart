import 'package:heroicons/heroicons.dart';

class Overview {
  final String header;
  final String subheader;
  final HeroIcons icon;
  final String type;

  Overview({
    required this.header,
    required this.subheader,
    required this.icon,
    required this.type,
  });
}

List<Overview> rental_user_dashboard_overview = [
  Overview(
      header: 'Total Rented Car',
      subheader: 'Rented Car',
      icon: HeroIcons.truck,
      type: 'rented-car'),
  Overview(
      header: 'For Review Car',
      subheader: 'For Review',
      icon: HeroIcons.truck,
      type: 'for-review'),
  Overview(
      header: 'For Rent Car',
      subheader: 'For Rent',
      icon: HeroIcons.pencil,
      type: 'for-rent'),
];
List<Overview> admin_dashboard_oveview = [
  Overview(
      header: 'Total Rented Car',
      subheader: 'Rented Car',
      icon: HeroIcons.truck,
      type: 'rented-car'),
  Overview(
      header: 'For Review Car',
      subheader: 'For Review',
      icon: HeroIcons.truck,
      type: 'for-review'),
  Overview(
      header: 'For Rent Car',
      subheader: 'For Rent',
      icon: HeroIcons.check,
      type: 'for-rent'),
];
