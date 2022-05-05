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
    return TvShowsDbModel()
      ..id = fields[0] as int?
      ..name = fields[1] as String?
      ..overview = fields[2] as String?
      ..posterPath = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, TvShowsDbModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.posterPath);
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
