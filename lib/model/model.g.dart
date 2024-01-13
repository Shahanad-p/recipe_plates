// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class recipeModelAdapter extends TypeAdapter<recipeModel> {
  @override
  final int typeId = 1;

  @override
  recipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return recipeModel(
      name: fields[1] as String,
      category: fields[2] as String,
      description: fields[3] as String,
      ingredients: fields[4] as String,
      cost: fields[5] as String,
      image: fields[6] as String?,
      index: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, recipeModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.ingredients)
      ..writeByte(5)
      ..write(obj.cost)
      ..writeByte(6)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is recipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
