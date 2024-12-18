import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/presentation/widgets/Navbar.dart';
import 'package:db_finalproject/presentation/widgets/Sidebar.dart';
import 'package:db_finalproject/features/admin/data/Workshop.dart';
import 'package:db_finalproject/core/services/ApiService.dart';

class WorkshopJoin extends StatefulWidget {
  @override
  _WorkshopJoinState createState() => _WorkshopJoinState();
}

class _WorkshopJoinState extends State<WorkshopJoin> {
  List<Workshop> workshops = [];
  ApiService _apiService = ApiService();

  Future<void> fetchWorkshops() async {
    try {
      // workshops = await _apiService.getWorkshops();
      setState(() {
        // Placeholder data for testing
        workshops = [
          Workshop(wsid: 1, wsdate: "2024-01-15", wstime: "10:00 AM", wstopic: "AI Basics"),
          Workshop(wsid: 2, wsdate: "2024-01-20", wstime: "2:00 PM", wstopic: "Flutter Development"),
        ];
      });
      // setState(() {});
    } catch (e) {
      print('Error fetching workshops: $e');
    }
  }

  Future<void> registerWorkshop(int wsid) async {
    try {
      // await _apiService.registerWorkshop(wsid);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Successfully registered for workshop $wsid!"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to register for workshop $wsid."))
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWorkshops();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "報名工作坊",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Table(
                      border: TableBorder(
                        top: BorderSide(color: Colors.grey),
                        bottom: BorderSide(color: Colors.grey),
                        horizontalInside: BorderSide(color: Colors.grey),
                      ),
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(3),
                        3: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "日期",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "時間",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "主題",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "操作",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ...workshops.map(
                          (workshop) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(workshop.wsdate),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(workshop.wstime),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(workshop.wstopic),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () => registerWorkshop(workshop.wsid),
                                  child: Text("報名"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Sidebar()
        ],
      ),
    );
  }
}
