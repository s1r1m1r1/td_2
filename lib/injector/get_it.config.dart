// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:td_2/bloc/stage_bloc.dart' as _i417;
import 'package:td_2/bloc/stage_stats_bloc.dart' as _i1039;
import 'package:td_2/bloc/stage_treasury_bloc.dart' as _i558;
import 'package:td_2/bloc/weapon_bar_bloc.dart' as _i810;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i417.StageBloc>(() => _i417.StageBloc());
    gh.lazySingleton<_i810.WeaponBarBloc>(() => _i810.WeaponBarBloc());
    gh.lazySingleton<_i1039.StageStatsBloc>(() => _i1039.StageStatsBloc());
    gh.lazySingleton<_i558.StageTreasuryBloc>(() => _i558.StageTreasuryBloc());
    return this;
  }
}
