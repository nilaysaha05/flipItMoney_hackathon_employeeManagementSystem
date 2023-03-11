class Employee {
  final String jobId;
  final String name;
  final String address;
  final String dept;
  final String bioJoke;
  final String salary;

  Employee(this.jobId, this.name, this.address, this.dept, this.bioJoke,
      this.salary);

  //constructor that convert json to object instance
  Employee.fromJson(Map<String, dynamic> json)
      : jobId = json['jobId'],
        name = json['name'],
        address = json['address'],
        dept = json['dept'],
        bioJoke = json['bioJoke'],
        salary = json['salary'];

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
        'jobId': jobId,
        'name': name,
        'address': address,
        'dept': dept,
        'bioJoke': bioJoke,
        'salary': salary,
      };
}
