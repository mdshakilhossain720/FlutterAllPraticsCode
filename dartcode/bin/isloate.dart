import 'dart:isolate';

void runTask(String msg) {
  print("Running in isolate: $msg");
}

void main() async {
  Isolate.spawn(runTask, "Hello isolate");
}
