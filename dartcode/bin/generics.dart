// A generic Box class
class Box<T> {
  T value;

  Box(this.value);

  void update(T newValue) {
    value = newValue;
  }

  @override
  String toString() => 'Box contains: $value';
}

void main() {
  // Example 1: String box
  var stringBox = Box<String>("Hello");
  print(stringBox); // Box contains: Hello

  stringBox.update("World");
  print(stringBox); // Box contains: World

  // Example 2: Integer box
  var intBox = Box<int>(100);
  print(intBox); // Box contains: 100
}
