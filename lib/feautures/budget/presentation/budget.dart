import 'package:cashly/core/constants/app_color.dart';
import 'package:cashly/core/models/categoria.dart';
import 'package:cashly/core/models/presupuestos.dart';
import 'package:cashly/core/services/category_service.dart';
import 'package:cashly/core/services/budget_service.dart';
import 'package:cashly/core/widgets/budget_card.dart';
import 'package:cashly/core/widgets/custom_button.dart';
import 'package:cashly/core/widgets/general_budget_card.dart';
import 'package:cashly/core/widgets/header.dart';
import 'package:cashly/core/widgets/menu.dart';
import 'package:cashly/feautures/budget/presentation/add_budget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';


import '../../../core/models/presupuestos.dart';
import '../../../core/themes/text_scheme.dart';
import '../../../core/widgets/budget_card.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/general_budget_card.dart';
import '../../../core/widgets/header.dart';
import '../../../core/widgets/menu.dart';
import '../../../feautures/budget/presentation/add_budget.dart';
import '../../../core/services/firebase_api.dart';
import '../../home/presentation/home_screen.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final _presService = PresupuestoService();
  bool _loading = true;
  double _totalDetail = 0;
  List<Presupuestos> _presupuestos = [];
  List<Categoria> _categorias = [];

  final String mesAnio = toBeginningOfSentenceCase(
    DateFormat('MMMM yyyy', 'es_ES').format(DateTime.now()),
  )!;

  @override
  void initState() {
    super.initState();
    _loadBudgetData();
  }

  Future<void> _loadBudgetData() async {
    setState(() => _loading = true);
    try {
      // Carga categorías para asignar nombre
      _categorias = await CategoryService.fetchCategories();

      // Carga detalle
      final detailJson = await _presService.getPresupuestosDetail();
      _totalDetail = (detailJson['amount'] as num).toDouble();

      // Carga lista de presupuestos
      final listJson = await _presService.getPresupuestos();
      _presupuestos = listJson.map<Presupuestos>((json) {
        // Busca nombre de categoría
        final cat = _categorias.firstWhere(
              (c) => c.categoriaId == json['categoria_id'],
          orElse: () => Categoria(
            categoriaId: 0,
            categoriaNom: 'Sin categoría',
            categoriaDescrip: '',
            iconRef: '',
            ownerId: null,
          ),
        );
        return Presupuestos(
          presId: json['pres_id'] as int,
          usuarioId: json['usuario_id'] as int,
          presNombre: json['pres_nombre'] as String,
          categoriaId: json['categoria_id'] as int?,
          categoriaNom: cat.categoriaNom,
          presMontoInicial: double.parse(json['pres_monto_inicial'].toString()),
          presMontoUlt: double.parse(json['pres_monto_ult'].toString()),
          esActivo: json['es_activo'] as bool,
          fechaCreacion: DateTime.parse(json['fecha_creacion'] as String),
          fechaUltAct: DateTime.parse(json['fecha_ult_act'] as String),
          inicioRecurrencia: json['inicio_recurrencia'] != null
              ? DateTime.parse(json['inicio_recurrencia'] as String)
              : null,
          finRecurrencia: json['fin_recurrencia'] != null
              ? DateTime.parse(json['fin_recurrencia'] as String)
              : null,
        );
      }).toList();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar presupuestos: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _navigateAddBudget() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddBudgetScreen()),
    );
    if (result == true) {
      _loadBudgetData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuLateralScreen(),
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título manual
            Container(

              width: double.infinity,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF28523A)),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    ),
                  ),
                  const SizedBox(width: 8),

                  Text(
                    "Presupuesto",
                    style: Theme.of(context).textTheme.headlineSmall,

                  ),
                ],
              ),
            ),

            // GeneralBudgetCard con monto real
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GeneralBudgetCard(amount: _totalDetail),
            ),

            const SizedBox(height: 16),

            // Lista de presupuestos o indicador de carga
            _loading
                ? const Center(child: CircularProgressIndicator())
                : _presupuestos.isEmpty
                ? const Center(child: Text("No hay presupuestos registrados."))
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _presupuestos.length,
              itemBuilder: (context, index) {
                return BudgetCard(presupuesto: _presupuestos[index]);
              },
            ),

            // Botón para agregar presupuesto
            Padding(
              padding: const EdgeInsets.fromLTRB(11, 16, 11, 16),
              child: CustomButton(
                text: "+ Agregar Presupuesto",
                style: 'primary',
                onPressed: _navigateAddBudget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

