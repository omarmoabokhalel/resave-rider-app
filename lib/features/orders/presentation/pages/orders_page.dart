import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_bloc.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_event.dart';
import 'package:resave_rider/features/orders/presentation/bloc/order_state.dart';
import 'package:resave_rider/features/orders/presentation/widgets/orders_list.dart';

import 'order_details_page.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<OrdersBloc>().add(LoadOrdersEvent());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الطلبات'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'طلبات متاحة'),
              Tab(text: 'طلباتي'),
            ],
          ),
        ),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is OrdersLoaded) {
              final riderId = 3; // لاحقًا من token

              final availableOrders = state.orders.where(
                (o) => o.status == 'pending' && o.riderId == null,
              ).toList();

              final myOrders = state.orders.where(
                (o) =>
                    o.riderId == riderId &&
                    o.status != 'delivered',
              ).toList();

              return TabBarView(
                children: [
                  OrdersList(
                    orders: availableOrders,
                    isMine: false,
                  ),
                  OrdersList(
                    orders: myOrders,
                    isMine: true,
                  ),
                ],
              );
            }

            if (state is OrdersError) {
              return Center(child: Text(state.message));
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}

