import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/features/orders/domain/usecases/get_rider_order.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_event.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_state.dart';

import '../../domain/usecases/update_order_weight.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetRiderOrders getOrders;
  final UpdateOrderWeight updateWeight;

  OrdersBloc(this.getOrders, this.updateWeight)
      : super(OrdersInitial()) {
    on<LoadOrders>((event, emit) async {
      emit(OrdersLoading());
      try {
        final orders = await getOrders();
        emit(OrdersLoaded(orders));
      } catch (e) {
        emit(OrdersError('حصل خطأ'));
      }
    });
  }
}
