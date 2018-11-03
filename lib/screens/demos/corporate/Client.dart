
class Client
{
  String id;
  String email;
  String name;
  String legalIdType;
  String legalId;
  String phone;
  String address;

  Client(this.id, this.email, this.name, this.legalIdType, this.legalId, this.phone, this.address );

  static Client createDummyClient()
  {
    return Client(
      '123',
      'client@mail.com',
      'Client name',
      'Passport',
      '1234567890',
      '+555 55555',
      'client address',
    );
  }
  get legalStr
  {
    switch (legalIdType)
    {
      case '04':
        return 'RUC: $legalId';
      case '05':
        return 'Cédula: $legalId';
      case '06':
        return 'Pasaporte: $legalId';
    }
    return legalId;
  }

  get isComplete
  {
    return email != null && email.isNotEmpty &&
        name != null && name.isNotEmpty &&
        legalIdType != null &&
        legalId != null && legalId.isNotEmpty &&
        phone != null && phone.isNotEmpty &&
        address != null && address.isNotEmpty;
  }
}