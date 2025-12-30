import 'package:resave_rider/core/api/api_service.dart';
import 'package:resave_rider/features/orders/data/models/orders_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<void> updateWeight(
    int orderId,
    List<Map<String, dynamic>> items,
  );
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiService api;

  OrdersRemoteDataSourceImpl(this.api);

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await api.dio.get('/rider/orders');

    final List data = response.data as List;

    return data
        .map((e) => OrderModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> updateWeight(
      int orderId, List<Map<String, dynamic>> items) async {
    await api.dio.post(
      '/rider/order/$orderId/update-weight',
      data: {
        'items': items,
      },
    );
  }
}

class OrderItemModel {
  final int id;
  final String itemName;
  final double estimatedQuantity;

  OrderItemModel({
    required this.id,
    required this.itemName,
    required this.estimatedQuantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      itemName: json['item']['name'],
      estimatedQuantity:
          double.parse(json['estimated_quantity'].toString()),
    );
  }
}

import 'package:resave_rider/features/orders/data/models/order_item_model.dart';

class OrderModel {
  final int id;
  final String status;
  final String address;
  final double lat;
  final double lng;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.address,
    required this.lat,
    required this.lng,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      address: json['address'],
      lat: double.parse(json['lat'].toString()),
      lng: double.parse(json['lng'].toString()),
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}


import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_datasource.dart';
import '../models/orders_model.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remote;

  OrdersRepositoryImpl(this.remote);

  @override
  Future<List<OrderModel>> getOrders() {
    return remote.getOrders();
  }

  @override
  Future<void> updateWeight(
      int orderId, List<Map<String, dynamic>> items) {
    return remote.updateWeight(orderId, items);
  }
}


import 'package:equatable/equatable.dart';

class OrdersEntity extends Equatable {
  final String id;
  final String name;

  const OrdersEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}


import '../../data/models/orders_model.dart';

abstract class OrdersRepository {
  Future<List<OrderModel>> getOrders();
  Future<void> updateWeight(
    int orderId,
    List<Map<String, dynamic>> items,
  );
}


import '../repositories/orders_repository.dart';
import '../../data/models/orders_model.dart';

class GetOrders {
  final OrdersRepository repository;

  GetOrders(this.repository);

  Future<List<OrderModel>> call() {
    return repository.getOrders();
  }
}


import '../repositories/orders_repository.dart';

class UpdateWeight {
  final OrdersRepository repository;

  UpdateWeight(this.repository);

  Future<void> call(
    int orderId,
    List<Map<String, dynamic>> items,
  ) {
    return repository.updateWeight(orderId, items);
  }
}


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_event.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_state.dart';
import '../../domain/usecases/get_orders.dart';
import '../../domain/usecases/update_weight.dart';


class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrders getOrders;
  final UpdateWeight updateWeight;

  OrdersBloc(this.getOrders, this.updateWeight)
      : super(OrdersInitial()) {
    on<LoadOrdersEvent>((event, emit) async {
      emit(OrdersLoading());
      try {
        final orders = await getOrders();
        emit(OrdersLoaded(orders));
      } catch (e) {
        emit(OrdersError('فشل تحميل الطلبات'));
      }
    });

    on<UpdateWeightEvent>((event, emit) async {
      try {
        await updateWeight(event.orderId, event.items);
        add(LoadOrdersEvent()); // reload
      } catch (e) {
        emit(OrdersError('فشل تحديث الوزن'));
      }
    });
  }
}

abstract class OrdersEvent {}

class LoadOrdersEvent extends OrdersEvent {}

class UpdateWeightEvent extends OrdersEvent {
  final int orderId;
  final List<Map<String, dynamic>> items;

  UpdateWeightEvent(this.orderId, this.items);
}

import '../../data/models/orders_model.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;

  OrdersLoaded(this.orders);
}

class OrdersError extends OrdersState {
  final String message;

  OrdersError(this.message);
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_bloc.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_event.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_state.dart';

import 'order_details_page.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<OrdersBloc>().add(LoadOrdersEvent());

    return Scaffold(
      appBar: AppBar(title: Text('الطلبات')),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is OrdersLoaded) {
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return Card(
                  child: ListTile(
                    title: Text('طلب #${order.id}'),
                    subtitle: Text(order.status),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              OrderDetailsPage(order: order),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          if (state is OrdersError) {
            return Center(child: Text(state.message));
          }

          return SizedBox();
        },
      ),
    );
  }
}
