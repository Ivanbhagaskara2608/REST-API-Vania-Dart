import 'package:paml/app/http/controllers/customer_controller.dart';
import 'package:paml/app/http/controllers/order_controller.dart';
import 'package:paml/app/http/controllers/order_item_controller.dart';
import 'package:paml/app/http/controllers/product_controller.dart';
import 'package:paml/app/http/controllers/product_note_controller.dart';
import 'package:paml/app/http/controllers/user_controller.dart';
import 'package:paml/app/http/controllers/vendor_controller.dart';
import 'package:paml/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    // User Routes
    Router.group(prefix: 'user', () {
      Router.post('/register', userController.register);
      Router.post('/login', userController.login);
      Router.group(middleware: [AuthenticateMiddleware()], () {
        Router.get('/me', userController.index);
        Router.post('/logout', userController.logout);
      });
    });

    /// Customer Routes
    Router.group(prefix: 'customer', () {
      Router.get('/', customerController.index);
      Router.get('/{id}', customerController.show);
      Router.post('/store', customerController.store);
      Router.put('/update/{id}', customerController.update);
      Router.delete('/delete/{id}', customerController.destroy);
    }, middleware: [AuthenticateMiddleware()]);

    /// Vendor Routes
    Router.group(prefix: 'vendor', () {
      Router.get('/', vendorController.index);
      Router.get('/{id}', vendorController.show);
      Router.post('/store', vendorController.store);
      Router.put('/update/{id}', vendorController.update);
      Router.delete('/delete/{id}', vendorController.destroy);
    }, middleware: [AuthenticateMiddleware()]);

    /// Product Routes
    Router.group(prefix: 'product', () {
      Router.get('/', productController.index);
      Router.get('/{id}', productController.show);
      Router.post('/store', productController.store);
      Router.put('/update/{id}', productController.update);
      Router.delete('/delete/{id}', productController.destroy);
    }, middleware: [AuthenticateMiddleware()]);

    // Product Notes Routes
    Router.group(prefix: 'product-note', () {
      Router.get('/', productNoteController.index);
      Router.get('/{id}', productNoteController.show);
      Router.post('/store', productNoteController.store);
      Router.put('/update/{id}', productNoteController.update);
      Router.delete('/delete/{id}', productNoteController.destroy);
    }, middleware: [AuthenticateMiddleware()]);

    /// Order Routes
    Router.group(prefix: 'order', () {
      Router.get('/', orderController.index);
      Router.get('/{id}', orderController.show);
      Router.post('/store', orderController.store);
      Router.put('/update/{id}', orderController.update);
      Router.delete('/delete/{id}', orderController.destroy);
    }, middleware: [AuthenticateMiddleware()]);

    /// Order Item Routes
    Router.group(prefix: 'order-item', () {
      Router.get('/', orderItemController.index);
      Router.get('/{id}', orderItemController.show);
      Router.post('/store', orderItemController.store);
      Router.put('/update/{id}', orderItemController.update);
      Router.delete('/delete/{id}', orderItemController.destroy);
    }, middleware: [AuthenticateMiddleware()]);
  }
}
