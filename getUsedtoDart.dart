void main() {
  //khai báo biến kiểu string
  var name = 'Dart';
  print("Hello " + name);
  
  //hằng
  const a = 1;
  final b = 12;
  print(a + b);
  
  //lists and map
  var list = ['a', 2, 3];
  print(list);
  var map = {'id': 0, 'name': 'Hey'};
  print(map);
  
  //dynamic: kiểu dữ liệu chưa được định nghĩa, mặc định là dynamic
  dynamic fix = "change";
  
  dynamic n = 10;
  for(var i = 0; i < n; i++) {
    print(i);
  }
  
  showInfo(name);
  
  Name nm = new Name(name);
  nm.getName();
}

void showInfo(var name) {
  print(name);
}

class Name {
  var name;
  
  Name(var name) {
    this.name = name;
  }
  
  String getName() {
    return name;
  }
  
  void setName(var name) {
    this.name = name;
  }
}