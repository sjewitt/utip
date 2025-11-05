void main() {
  // entrypoint
  Fish herring = Fish(); // `new` is implied (VSCode warns)
  herring.setLength(123);
  herring.setType("Herring");

  // or:
  Fish cod = Fish(1145, "COD");

  print(herring.getLength());
  print(herring.getType());

  print(cod.getLength());
  print(cod.getType());

  // from course:
  Bob bob = Bob(123, "FISH");
  Bob bob2 = Bob(1234432, "FISH and CHIPS");
  var age = bob.age = 412;
  // print("BOB: ${bob.name} ${bob.age}");
  bob.greeting();
  bob2.greeting();
}

class Bob {
  int age;
  String name;

  // constructor
  Bob(this.age, this.name);

  // behaviour
  void greeting() {
    print("BOB method: ${this.name} ${this.age}"); // `this` is optional
  }
}

class Fish {
  // int _length = 0;
  // String _type = "";
  // `?` denotes initially null is allowed
  int? _length;
  String? _type;

  // constructor syntax! Method name needs to equal the classname:

  // Fish([int len, String typ]) {
  //   setLength(len);
  //   setType(typ);
  // }

  // actually, see https://stackoverflow.com/questions/52449508/constructor-optional-params
  // and https://dart.dev/language/constructors for further details. Note that the examples
  // in the latter ref also don't have a body:
  Fish([
    this._length,
    this._type,
  ]); // NOTE: The constructor body can be omitted if you don't want to process anything
  // {
  //   print(this._length);
  //   print(this._type);
  // }

  // can also use the `?` modifier on th emethod to denote a possible null return
  int? getLength() {
    return _length; // `this.` is valid, but unnecessary as scope is implied
  }

  String? getType() {
    return _type;
  }

  void setLength(int length) {
    // `this.` IS necessary here (if arg and local have same name). Dart does
    // not work it out as Python would... A gotcha!!
    // but note that underscore denotes private member
    // see https://dart.dev/language/classes
    //     https://stackoverflow.com/questions/17488611/how-to-create-private-variables-in-dart
    _length = length;
  }

  void setType(String type) {
    _type = type;
  }
}
