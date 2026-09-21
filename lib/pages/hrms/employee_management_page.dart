import 'package:flutter/material.dart';

class EmployeeManagementPage extends StatefulWidget {
  const EmployeeManagementPage({super.key});

  @override
  State<EmployeeManagementPage> createState() =>
      _EmployeeManagementPageState();
}

class _EmployeeManagementPageState extends State<EmployeeManagementPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _employees = [
    {
      'id': 'EMP001',
      'name': 'Arun Kumar',
      'email': 'arun.kumar@onecloud.com',
      'department': 'Engineering',
      'role': 'Software Developer',
      'status': 'Active',
    },
    {
      'id': 'EMP002',
      'name': 'Priya Sharma',
      'email': 'priya.sharma@onecloud.com',
      'department': 'Human Resources',
      'role': 'HR Manager',
      'status': 'Active',
    },
    {
      'id': 'EMP003',
      'name': 'Rahul Raj',
      'email': 'rahul.raj@onecloud.com',
      'department': 'Finance',
      'role': 'Accountant',
      'status': 'Active',
    },
    {
      'id': 'EMP004',
      'name': 'Divya Mohan',
      'email': 'divya.mohan@onecloud.com',
      'department': 'Sales',
      'role': 'Sales Executive',
      'status': 'On Leave',
    },
    {
      'id': 'EMP005',
      'name': 'Karthik S',
      'email': 'karthik.s@onecloud.com',
      'department': 'Engineering',
      'role': 'UI Developer',
      'status': 'Active',
    },
    {
      'id': 'EMP006',
      'name': 'Meena Devi',
      'email': 'meena.devi@onecloud.com',
      'department': 'Marketing',
      'role': 'Marketing Executive',
      'status': 'Inactive',
    },
  ];

  List<Map<String, dynamic>> get _filteredEmployees {
    final query = _searchController.text.toLowerCase();

    if (query.isEmpty) {
      return _employees;
    }

    return _employees.where((employee) {
      return employee['name'].toString().toLowerCase().contains(query) ||
          employee['id'].toString().toLowerCase().contains(query) ||
          employee['email'].toString().toLowerCase().contains(query) ||
          employee['department'].toString().toLowerCase().contains(query) ||
          employee['role'].toString().toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddEmployeeDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final departmentController = TextEditingController();
    final roleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Employee',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F3D66),
            ),
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Employee Name',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: departmentController,
                    decoration: const InputDecoration(
                      labelText: 'Department',
                      prefixIcon: Icon(Icons.business_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: roleController,
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      prefixIcon: Icon(Icons.work_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty ||
                    emailController.text.trim().isEmpty ||
                    departmentController.text.trim().isEmpty ||
                    roleController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  final newId =
                      'EMP${(_employees.length + 1).toString().padLeft(3, '0')}';

                  _employees.add({
                    'id': newId,
                    'name': nameController.text.trim(),
                    'email': emailController.text.trim(),
                    'department': departmentController.text.trim(),
                    'role': roleController.text.trim(),
                    'status': 'Active',
                  });
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text('Employee added successfully'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1677C8),
                foregroundColor: Colors.white,
              ),
              child: const Text('Add Employee'),
            ),
          ],
        );
      },
    );
  }

  void _showEmployeeDetails(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFE0F2FE),
                child: Text(
                  employee['name'][0],
                  style: const TextStyle(
                    color: Color(0xFF1677C8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  employee['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F3D66),
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailRow('Employee ID', employee['id']),
              _detailRow('Email', employee['email']),
              _detailRow('Department', employee['department']),
              _detailRow('Role', employee['role']),
              _detailRow('Status', employee['status']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'On Leave':
        return Colors.orange;
      case 'Inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return SizedBox(
      width: 240,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 25,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F3D66),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final employees = _filteredEmployees;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FC),
      body: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 28),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE2E8F0),
                ),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0F3D66)),
                  tooltip: 'Back',
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.people_alt_outlined,
                  color: Color(0xFF1677C8),
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Text(
                  'HRMS Service',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F3D66),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(width: 8),
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFFE0F2FE),
                  child: Icon(
                    Icons.person_outline,
                    color: Color(0xFF1677C8),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Employee Management',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1E3F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Manage employee information, departments, roles and employment status.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _summaryCard(
                        'Total Employees',
                        '${_employees.length}',
                        Icons.people_outline,
                        const Color(0xFF1677C8),
                      ),
                      _summaryCard(
                        'Active Employees',
                        '${_employees.where((e) => e['status'] == 'Active').length}',
                        Icons.verified_user_outlined,
                        Colors.green,
                      ),
                      _summaryCard(
                        'On Leave',
                        '${_employees.where((e) => e['status'] == 'On Leave').length}',
                        Icons.event_busy_outlined,
                        Colors.orange,
                      ),
                      _summaryCard(
                        'Departments',
                        '${_employees.map((e) => e['department']).toSet().length}',
                        Icons.business_outlined,
                        const Color(0xFF7C3AED),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 650;

                        if (isMobile) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 44,
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (_) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        'Search by name, ID, department or role...',
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Color(0xFF64748B),
                                    ),
                                    suffixIcon: _searchController.text.isNotEmpty
                                        ? IconButton(
                                            onPressed: () {
                                              _searchController.clear();
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.clear),
                                          )
                                        : null,
                                    filled: true,
                                    fillColor: const Color(0xFFF8FAFC),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE2E8F0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE2E8F0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 44,
                                child: ElevatedButton.icon(
                                  onPressed: _showAddEmployeeDialog,
                                  icon: const Icon(Icons.add),
                                  label: const Text('Add Employee'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1677C8),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 44,
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (_) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        'Search by name, ID, department or role...',
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Color(0xFF64748B),
                                    ),
                                    suffixIcon: _searchController.text.isNotEmpty
                                        ? IconButton(
                                            onPressed: () {
                                              _searchController.clear();
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.clear),
                                          )
                                        : null,
                                    filled: true,
                                    fillColor: const Color(0xFFF8FAFC),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE2E8F0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE2E8F0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              onPressed: _showAddEmployeeDialog,
                              icon: const Icon(Icons.add),
                              label: const Text('Add Employee'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(160, 44),
                                backgroundColor: const Color(0xFF1677C8),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Employee Directory',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F3D66),
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                        if (employees.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(40),
                            child: Center(
                              child: Text(
                                'No employees found.',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        else
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowHeight: 55,
                              dataRowMinHeight: 58,
                              dataRowMaxHeight: 65,
                              columnSpacing: 30,
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'Employee',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Employee ID',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Department',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Role',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Status',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Action',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              rows: employees.map((employee) {
                                final status = employee['status'] as String;
                                final statusColor = _statusColor(status);

                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                            radius: 18,
                                            backgroundColor:
                                                const Color(0xFFE0F2FE),
                                            child: Text(
                                              employee['name'][0],
                                              style: const TextStyle(
                                                color: Color(0xFF1677C8),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          SizedBox(
                                            width: 170,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  employee['name'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  employee['email'],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        employee['id'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(employee['department']),
                                    ),
                                    DataCell(
                                      Text(employee['role']),
                                    ),
                                    DataCell(
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: statusColor.withValues(
                                            alpha: 0.10,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          status,
                                          style: TextStyle(
                                            color: statusColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      IconButton(
                                        onPressed: () =>
                                            _showEmployeeDetails(employee),
                                        icon: const Icon(
                                          Icons.visibility_outlined,
                                          color: Color(0xFF1677C8),
                                        ),
                                        tooltip: 'View Details',
                                      ),
                                    ),
                                  ],
                                );
                                                            }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
      