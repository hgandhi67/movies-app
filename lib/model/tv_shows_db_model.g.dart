// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_shows_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TvShowsDbModelAdapter extends TypeAdapter<TvShowsDbModel> {
  @override
  final int typeId = 0;

  @override
  TvShowsDbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TvShowsDbModel()..tvShowsList = fields[0] as Result?;
  }

  @override
  void write(BinaryWriter writer, TvShowsDbModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.tvShowsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TvShowsDbModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
