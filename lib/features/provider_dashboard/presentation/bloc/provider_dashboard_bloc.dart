import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/provider_dashboard/data/model/provider_yearly_sales_model.dart';
import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_monthly_sales_entity.dart';
import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_wallet_entity.dart';
import 'package:ambuhub/features/provider_dashboard/domain/usecases/get_provider_sales_by_month.dart';
import 'package:ambuhub/features/provider_dashboard/domain/usecases/get_provider_wallet.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_event.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderDashboardBloc
    extends Bloc<ProviderDashboardEvent, ProviderDashboardState> {
  final GetProviderWalletUsecase _getWalletUsecase;
  final GetProviderSalesByMonthUsecase _getSalesByMonthUsecase;

  ProviderWalletEntity? _walletCache;
  final Map<int, ProviderYearlySalesEntity> _salesCache = {};

  ProviderDashboardBloc(
    this._getWalletUsecase,
    this._getSalesByMonthUsecase,
  ) : super(ProviderDashboardState.initial()) {
    on<LoadProviderDashboard>(_onLoadDashboard);
    on<LoadProviderWallet>(_onLoadWallet);
    on<LoadProviderYearlySales>(_onLoadYearlySales);
    on<SelectProviderSalesYear>(_onSelectYear);
    on<ProviderDashboardReset>(_onReset);
  }

  void _onReset(
    ProviderDashboardReset event,
    Emitter<ProviderDashboardState> emit,
  ) {
    _walletCache = null;
    _salesCache.clear();
    emit(ProviderDashboardState.initial());
  }

  Future<void> _onLoadDashboard(
    LoadProviderDashboard event,
    Emitter<ProviderDashboardState> emit,
  ) async {
    await Future.wait([
      _fetchWallet(emit, forceRefresh: event.forceRefresh),
      _fetchSales(
        emit,
        year: state.selectedYear,
        forceRefresh: event.forceRefresh,
      ),
    ]);
  }

  Future<void> _onLoadWallet(
    LoadProviderWallet event,
    Emitter<ProviderDashboardState> emit,
  ) async {
    await _fetchWallet(emit, forceRefresh: event.forceRefresh);
  }

  Future<void> _onLoadYearlySales(
    LoadProviderYearlySales event,
    Emitter<ProviderDashboardState> emit,
  ) async {
    await _fetchSales(
      emit,
      year: event.year,
      forceRefresh: event.forceRefresh,
    );
  }

  Future<void> _onSelectYear(
    SelectProviderSalesYear event,
    Emitter<ProviderDashboardState> emit,
  ) async {
    final cached = _salesCache[event.year];
    if (cached != null) {
      emit(
        state.copyWith(
          selectedYear: event.year,
          yearlySales: cached,
          isSalesLoading: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        selectedYear: event.year,
        yearlySales: ProviderYearlySalesModel(
          year: event.year,
          months: ProviderYearlySalesModel.emptyMonths(event.year),
        ),
        isSalesLoading: true,
      ),
    );
    await _fetchSales(emit, year: event.year);
  }

  Future<void> _fetchWallet(
    Emitter<ProviderDashboardState> emit, {
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _walletCache != null) {
      emit(
        state.copyWith(
          walletBalanceNgn: _walletCache!.balanceNgn,
          hasWalletLoaded: true,
          isWalletLoading: false,
        ),
      );
      return;
    }

    emit(state.copyWith(isWalletLoading: true));

    final dataState = await _getWalletUsecase();

    if (dataState is DataSuccess<ProviderWalletEntity>) {
      _walletCache = dataState.data;
      emit(
        state.copyWith(
          walletBalanceNgn: dataState.data!.balanceNgn,
          isWalletLoading: false,
          hasWalletLoaded: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        walletBalanceNgn: _walletCache?.balanceNgn ?? 0,
        isWalletLoading: false,
        hasWalletLoaded: true,
      ),
    );
  }

  Future<void> _fetchSales(
    Emitter<ProviderDashboardState> emit, {
    required int year,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _salesCache.containsKey(year)) {
      emit(
        state.copyWith(
          selectedYear: year,
          yearlySales: _salesCache[year]!,
          isSalesLoading: false,
        ),
      );
      return;
    }

    emit(state.copyWith(isSalesLoading: true, selectedYear: year));

    final dataState = await _getSalesByMonthUsecase(
      params: GetProviderSalesByMonthParams(year: year),
    );

    if (dataState is DataSuccess<ProviderYearlySalesEntity>) {
      _salesCache[year] = dataState.data!;
      emit(
        state.copyWith(
          selectedYear: year,
          yearlySales: dataState.data!,
          isSalesLoading: false,
        ),
      );
      return;
    }

    final fallback = ProviderYearlySalesModel(
      year: year,
      months: ProviderYearlySalesModel.emptyMonths(year),
    );
    _salesCache[year] = fallback;
    emit(
      state.copyWith(
        selectedYear: year,
        yearlySales: fallback,
        isSalesLoading: false,
      ),
    );
  }
}
