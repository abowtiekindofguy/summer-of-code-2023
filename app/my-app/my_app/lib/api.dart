
import 'package:http/http.dart' as http;
import 'dart:convert';

String postAPIEndpoint = 'https://marketplace-1-b3203472.deta.app/product';
Future<void> postData(Map<String,dynamic> fromForm) async {
  try {
        // Send the POST request to the server
        String formData = jsonEncode(fromForm);
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
        };
        final response = await http.post(
          Uri.parse(postAPIEndpoint),
          headers: headers,
          body: formData,
        );

        if (response.statusCode == 201) {
          var responseBody = jsonDecode(response.body);
          print(responseBody['_id']);
        } else {
          // Handle error response
          print('POST request failed with status: ${response.statusCode}');
        }
      } catch (e) {
        // Handle error
        print('Error sending POST request: $e');
      }
    
}
