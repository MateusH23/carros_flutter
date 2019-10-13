class ApiResponse<T>{
  bool ok = false;
  String msg;
  T result;

  ApiResponse.ok(this.result){
    //this.result = result;
    ok = true;
  }

  ApiResponse.error(String msg){
    this.msg = msg;
    ok = false;
  }
}