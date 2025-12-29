import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:resave_rider/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:resave_rider/features/auth/domain/usecases/login_rider.dart';
import 'package:resave_rider/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:resave_rider/features/auth/presentation/pages/login_page.dart';
import 'package:resave_rider/features/orders/domain/usecases/accepted_order.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_bloc.dart';
import 'core/api/api_service.dart';
import 'core/storage/token_storage.dart';
import 'features/orders/domain/usecases/get_orders.dart';
import 'features/orders/domain/usecases/update_weight.dart';
import 'features/orders/data/repositories/orders_repository_impl.dart';
import 'features/orders/data/datasources/orders_remote_datasource.dart';
import 'features/orders/presentation/pages/orders_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final token = await TokenStorage.getToken();

  final apiService = ApiService();

  final ordersRemote = OrdersRemoteDataSourceImpl(apiService);
  final ordersRepository = OrdersRepositoryImpl(ordersRemote);
  final getOrdersUseCase = GetOrders(ordersRepository);
  final updateWeightUseCase = UpdateWeight(ordersRepository);
  final acceptedOrderUseCase = AcceptOrder(ordersRepository);
  final authRemote = AuthRemoteDataSource(apiService);
  final authRepository = AuthRepositoryImpl(authRemote);
  final loginRiderUseCase = LoginRider(authRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(loginRiderUseCase)),
        BlocProvider(
          create: (_) => OrdersBloc(getOrdersUseCase, updateWeightUseCase, acceptedOrderUseCase),
        ),
      ],
      child: MyApp(initialToken: token),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? initialToken;

  const MyApp({super.key, this.initialToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReSave Rider App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: initialToken != null ? OrdersPage() : LoginPage(),
    );
  }
}
