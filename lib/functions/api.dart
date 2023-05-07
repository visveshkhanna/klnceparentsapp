import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

Uri URL = Uri.parse("https://www.klnce.edu/Parent/StudentInformation.aspx");

Future<bool> checkWebsiteStatus() async {
  var response = await http.get(URL);
  log("Website Response status: ${response.statusCode}");
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<List> getWebsite() async {
  var response = await http.get(URL);
  //log("Cookies: ${response.headers}");
  return [response.headers, response.body];
}

Future<Map> getStudentDetails(String roll_no, String dob) async {
  final data = await getWebsite();
  bool _isValid = true;
  String name="", univregno="", dept="";

  final body = data[1];
  var htmld = parse(body);
  var _viewstate = htmld.getElementById("__VIEWSTATE")!.attributes["value"];
  var _viewstategenerator =
      htmld.getElementById("__VIEWSTATEGENERATOR")!.attributes["value"];
  var _eventvalidation =
      htmld.getElementById("__EVENTVALIDATION")!.attributes["value"];

  var postdata =
      "__EVENTTARGET=&__EVENTARGUMENT=&ctl00_TreeView1_ExpandState=ennennnnnnennnnneennnnnnnennnnnnennnneennnnnnnnnnnnnenennnnneennnnnnnnnnnnnnnnnnnnn&ctl00_TreeView1_SelectedNode=ctl00_TreeView1t53&ctl00_TreeView1_PopulateLog=&__VIEWSTATE=${Uri.encodeComponent(_viewstate!)}&__VIEWSTATEGENERATOR=${Uri.encodeComponent(_viewstategenerator!)}&__EVENTVALIDATION=${Uri.encodeComponent(_eventvalidation!)}&ctl00%24BodyContent%24StudentCode=${roll_no}&ctl00%24BodyContent%24DOB=${Uri.encodeComponent(dob)}&ctl00%24BodyContent%24MaskedEditExtender1_ClientState=&ctl00%24BodyContent%24GetAtt=Get+The+Informations";

  //log(postdata);

  final headers = {
    "Accept":
        "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
    "Accept-Encoding": "gzip, deflate, br",
    "Accept-Language": "en-US,en;q=0.9",
    "Cache-Control": "max-age=0",
    "Connection": "keep-alive",
    "Content-Length": "${postdata.length}",
    "Content-Type": "application/x-www-form-urlencoded",
    "Cookie": "${data[0]['set-cookie'].split(";")[0]}",
    "Host": "www.klnce.edu",
    "Origin": "https://www.klnce.edu",
    "Referer": "https://www.klnce.edu/Parent/StudentInformation.aspx",
    "Sec-Ch-Ua":
        "\"Google Chrome\";v=\"113\", \"Chromium\";v=\"113\", \"Not-A.Brand\";v=\"24\"",
    "Sec-Ch-Ua-Mobile": "?0",
    "Sec-Ch-Ua-Platform": "\"Windows\"",
    "Sec-Fetch-Dest": "document",
    "Sec-Fetch-Mode": "navigate",
    "Sec-Fetch-Site": "same-origin",
    "Sec-Fetch-User": "?1",
    "Upgrade-Insecure-Requests": "1",
    "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36"
  };

  var response = await http.post(URL, headers: headers, body: postdata);
  log("Post response: ${response.statusCode}");

  if(response.statusCode != 200) {return {"error": true, "message": "Unknown error / Website status down!"};}

  htmld = parse(response.body);

  htmld.body!.getElementsByTagName("div").forEach((element) {
    if(element.id == "ctl00_BodyContent_ResultDiv") {
      if (element.getElementsByTagName("tr").length > 0) {
        _isValid = false;
      }
    }
  });

  if (!_isValid) {
    log("Not valid ${roll_no} ${dob}");
    return {
      "error": true,
      "message": "Sorry!!! Check The Student Roll Number or DOB",
    };
  }

  htmld.body!.getElementsByTagName("span").forEach((element) {
    if(element.id == "ctl00_BodyContent_StudentNameandDeptLbl") {
      var cont = element.text.split("          ");
      var temp = cont[1].split(" ");
      name = cont[0].split("(")[0].trim();
      univregno = temp[temp.length-1];
      dept = cont[2].split(":")[1].trim();
    }

  });

  return {
    "error": false,
    "message": null,
    "student": {
      "name": name,
      "universityRegisterNo": univregno,
      "department": dept,
      "rollNo": roll_no,
    }
  };

  return {};
}
