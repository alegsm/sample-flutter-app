class Entity
{
  final String name;
  final String businessName;
  final String email;
  final String logo;
  final String legalId;
  final String address;
  final int lastBillNumber;

  Entity(this.name, this.businessName, this.email, this.logo,
      this.legalId, this.address, [ this.lastBillNumber = 0 ]);

  static Entity createDummyEntity()
  {
    return Entity(
      'Company',
      'BusinessName',
      'some@email.com',
      'https://thoughtsfromthegoldenstate.files.wordpress.com/2013/04/brandmark-large.png',
      '1',
      'address',
      10,
    );
  }
}
