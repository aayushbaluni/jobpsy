import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jobpsy/Common/common.dart';

const baseUri='https://app-api-three.vercel.app';

Future<Response?> registerUser(data)async{
    try{
      var url=Uri.parse('$baseUri/user/register');
      var res=await http.post(url,body: data);
      return res;
    } catch(e){
      print("ERROR + $e");
      return null;
    }
}


Future<Response?> loginUser(data)async{
  try{
    var url=Uri.parse('$baseUri/user/login');
    var res=await http.post(url,body: data);
    return res;
  } catch(e){
    print("ERROR + $e");
    return null;
  }
}

Future<Response?> getAllJobs()async{
  try{
    var token=await getToken();
    var url=Uri.parse('$baseUri/jobs/list');
    var headers= setHeaders(token);
    var res=await http.post(url,headers:headers);
    return res;
  } catch(e){
    print("ERROR + $e");
    return null;
  }
}

Future<Response?> getJobById(id)async{
  try{
    var token=await getToken();
    var url=Uri.parse('$baseUri/jobs/details/$id');
    var headers= setHeaders(token);
    var res=await http.get(url,headers:headers);
    return res;
  } catch(e){
    print("ERROR + $e");
    return null;
  }
}

Future<Response?> applyJob(jobId)async{
  try{
    var token=await getToken();

    var url=Uri.parse('$baseUri/applied/jobs/apply');
    var headers= setHeaders(token);
    var res=await http.post(url,body:{
      "jobId":jobId
    },headers:headers);
    return res;
  } catch(e){
    print("ERROR + $e");
    return null;
  }
}



Future<Response?> getAppliedJobs()async{
  try{
    var token=await getToken();

    // var url=Uri.parse('$baseUri/jobs/list-user');
       var url=Uri.parse('$baseUri/applied/jobs/list');
    var headers= setHeaders(token);
    var res=await http.post(url,headers:headers);
    return res;
  } catch(e){
    print("ERROR + $e");
    return null;
  }
}


Future<Response?> createJob(data)async{
  try{
    var token=await getToken();
    var url=Uri.parse('$baseUri/jobs/create');
    var headers= setHeaders(token);
    var res=await http.post(url,body: data,headers: headers);
    return res;
  } catch(e){
    print("ERROR + $e");
    return null;
  }
}




