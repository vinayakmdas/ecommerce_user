part of 'variant_bloc.dart';

 class VariantState extends Equatable{

  final int selecedvarient ;

  const VariantState({required this.selecedvarient});
 
 
  @override
  List<Object?> get props =>  [selecedvarient];
  
  
  }

