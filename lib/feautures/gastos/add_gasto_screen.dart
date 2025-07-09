import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/constants/app_color.dart';

class AgregarGastoScreen extends StatefulWidget {
  const AgregarGastoScreen({Key? key}) : super(key: key);

  @override
  _AgregarGastoScreenState createState() => _AgregarGastoScreenState();
}

class _AgregarGastoScreenState extends State<AgregarGastoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();

  // Lista de categorías con icono SVG y etiqueta
  final List<_Categoria> _categorias = [
    _Categoria('Vivienda', 'assets/icons/home.svg'),
    _Categoria('Comida', 'assets/icons/food.svg'),
    _Categoria('Transporte', 'assets/icons/bus.svg'),
    _Categoria('Salud', 'assets/icons/health.svg'),
    _Categoria('Compras', 'assets/icons/shopping.svg'),
    _Categoria('Educación', 'assets/icons/education.svg'),
    _Categoria('Electricidad', 'assets/icons/electricity.svg'),
    _Categoria('Otros', 'assets/icons/others.svg'),
    _Categoria('Nueva', 'assets/icons/plus.svg'),
  ];

  int? _selectedCatIndex;

  void _onRegistrar() {
    if (_formKey.currentState?.validate() ?? false && _selectedCatIndex != null) {
      // TODO: guardar el gasto en tu BD, incluyendo _categorias[_selectedCatIndex!].nombre
      Navigator.of(context).pop();
    } else if (_selectedCatIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selecciona una categoría')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 72,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Agregar Gasto',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Registra una nueva fuente de gasto',
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(
              'assets/icons/user.svg',
              width: 24,
              height: 24,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            // Nombre del Gasto
            Text(
              'Nombre del Gasto',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nombreController,
              maxLength: 20,
              decoration: InputDecoration(
                hintText: 'ej: salario mensual',
                hintStyle: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.5),
                ),
                counterText: '',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Container(
                  margin: EdgeInsets.all(8),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.label, color: AppColors.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryContainer),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryContainer),
                ),
              ),
              validator: (v) => (v?.isEmpty ?? true) ? 'Requerido' : null,
            ),

            const SizedBox(height: 24),

            // Monto
            Text(
              'Monto',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _montoController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: '\$ 0.00',
                hintStyle: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.5),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Container(
                  margin: EdgeInsets.all(8),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.attach_money, color: AppColors.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryContainer),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryContainer),
                ),
              ),
              validator: (v) {
                final n = double.tryParse(v?.replaceAll(',', '') ?? '');
                return (n == null) ? 'Monto inválido' : null;
              },
            ),

            const SizedBox(height: 24),

            // Categoría
            Text(
              'Categoría',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            buildGridView(),

            // Espacio inferior para scroll
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: CustomButton(
          text: 'Registrar',
          onPressed: _onRegistrar,
        ),
      ),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _categorias.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (_, i) {
              final cat = _categorias[i];
              final selected = i == _selectedCatIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedCatIndex = i),
                child: Container(
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primaryContainer
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.primaryContainer,
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        cat.iconPath,
                        width: 24,
                        height: 24,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat.nombre,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

class _Categoria {
  final String nombre, iconPath;
  _Categoria(this.nombre, this.iconPath);
}


