lib/
│
├── core/
│   ├── network/
│   │   ├── api_service.dart
│   │   ├── api_constants.dart
│   │   └── dio_interceptor.dart
│   │
│   ├── error/
│   │   └── failure.dart
│   │
│   ├── utils/
│   │   └── helpers.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── rider_model.dart
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_ds.dart
│   │   │   └── repositories/
│   │   │       └── auth_repo_impl.dart
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── rider.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repo.dart
│   │   │   └── usecases/
│   │   │       └── login_rider.dart
│   │   │
│   │   └── presentation/
│   │       ├── bloc/
│   │       └── pages/
│   │           └── login_page.dart
│
│   ├── orders/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── order_model.dart
│   │   │   │   └── order_item_model.dart
│   │   │   ├── datasources/
│   │   │   │   └── orders_remote_ds.dart
│   │   │   └── repositories/
│   │   │       └── orders_repo_impl.dart
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   │
│   │   └── presentation/
│   │       ├── bloc/
│   │       └── pages/
│   │           ├── orders_page.dart
│   │           └── update_weight_page.dart
│
├── main.dart
└── injection.dart
