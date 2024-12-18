import 'package:paml/app/models/user.dart';
import 'package:vania/vania.dart';
import 'package:vania/src/exception/validation_exception.dart';

class UserController extends Controller {
  Future<Response> index() async {
    final users = Auth().user();

    return Response.json({
      'success': true,
      'message': 'Data has been loaded',
      'data': users,
    });
  }

  Future<Response> register(Request request) async {
    try {
      request.validate({
        'name': 'required|min_length:3',
        'email': 'required|email',
        'password': 'required|confirmed',
      });
    } catch (e) {
      if (e is ValidationException) {
        return Response.json({'success': false, 'message': e.message}, 401);
      }
    }

    final Map<String, dynamic> user = {
      'name': request.input('name'),
      'email': request.input('email'),
      'password': request.input('password'),
    };

    final Map<String, dynamic> newUser = await User().query().create(user);

    return Response.json(newUser, 201);
  }

  Future<Response> login(Request request) async {
    // Retrieve user data from the model (provider)
    final Map<String, dynamic>? user = await User()
        .query()
        .where('email', '=', request.input('email'))
        .first();

    // Check if user exists
    if (user == null) {
      return Response.json(
        {'message': 'User not found'},
        404,
      );
    }

    // Check if the password matches
    if (user['password'].toString() != request.input('password').toString()) {
      return Response.json(
        {'message': 'Wrong password'},
        401,
      );
    }

    // Authenticate the user and generate a token
    Map token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(hours: 24), withRefreshToken: true);

    // Further actions after successful authentication
    // For example, returning the token
    return Response.json(token, 200);
  }

  Future<Response> logout() async {
    Auth().deleteCurrentToken();

    return Response.json({'success': true, 'message': 'Logged out'}, 200);
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }
}

final UserController userController = UserController();
