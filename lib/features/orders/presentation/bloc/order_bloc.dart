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
