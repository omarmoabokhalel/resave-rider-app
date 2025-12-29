import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/features/orders/domain/usecases/accepted_order.dart';
import 'package:resave_rider/features/orders/domain/usecases/complete_order.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_event.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_state.dart';
import '../../domain/usecases/get_orders.dart';
import '../../domain/usecases/update_weight.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrders getOrders;
  final UpdateWeight updateWeight;
  final AcceptOrder acceptOrder;
  final CompleteOrder completeOrder;

  OrdersBloc(this.getOrders, this.updateWeight, this.acceptOrder, this.completeOrder)
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

    on<AcceptOrderEvent>((event, emit) async {
      emit(OrdersLoading());
      try {
        await acceptOrder(event.orderId);
        final orders = await getOrders();
        emit(OrdersLoaded(orders));
      } catch (e) {
        emit(OrdersError('فشل قبول الطلب'));
      }
    });

    on<UpdateWeightEvent>((event, emit) async {
      emit(OrdersLoading());
      try {
        await updateWeight(event.orderId, event.items);
        final orders = await getOrders();
        emit(OrdersLoaded(orders));
      } catch (e) {
        emit(OrdersError('فشل تحديث الوزن'));
      }
    });

    on<CompleteOrderEvent>((event, emit) async {
      try {
        await completeOrder(event.orderId);
        add(LoadOrdersEvent());
      } catch (e) {
        emit(OrdersError('فشل إتمام الطلب'));
      }
    });
  }
}
