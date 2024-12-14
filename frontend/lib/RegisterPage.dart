import 'package:flutter/material.dart';
import 'Navbar.dart';
import 'ApiService.dart';
import 'DataStruct.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
   const RegisterForm({super.key});
  

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _registerfromkey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  final TextEditingController _passwdcheckController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _sexual="0"; 
  final TextEditingController _phoneController = TextEditingController();
  String _college="請選擇";
  String _major="請選擇";
  String _grade="請選擇";
  final ApiService _apiService = ApiService();
 /*  final List<String> college=[
    "請選擇",
    "人文社會科學院",
    "法學院",
    "管理學院",
    "理學院",
    "工學院",
  ];
  final List<String> humanities = ["請選擇","西洋語文學系","運動健康與休閒學系","東亞語文學系","運動競技學系","建築學系","工藝與創意設計學系"];
  final List<String> law = ["請選擇","法律學系","政治法律學系","財經法律學系"];
  final List<String> management = ["請選擇","應用經濟學系","亞太工商管理學系","財務金融學系","資訊管理學系"];
  final List<String> science = ["請選擇","應用數學系","生命科學系","應用化學系","應用物理學系"];
  final List<String> engineering = ["請選擇","電機工程學系","土木與環境工程學系","化學工程及材料工程學系","資訊工程學系"];
  final Map<String, List<String>> collegeData = {
    "請選擇": ['請選擇'],
    "人文社會科學院": ["請選擇","西洋語文學系","運動健康與休閒學系","東亞語文學系","運動競技學系","建築學系","工藝與創意設計學系"],
    "法學院": ["請選擇","法律學系","政治法律學系","財經法律學系"],
    "管理學院": ["請選擇","應用經濟學系","亞太工商管理學系","財務金融學系","資訊管理學系"],
    "理學院": ["請選擇","應用數學系","生命科學系","應用化學系","應用物理學系"],
    "工學院": ["請選擇","電機工程學系","土木與環境工程學系","化學工程及材料工程學系","資訊工程學系"],
  };  */
  final List<String> major=[
    "請選擇",
    "西洋語文學系","運動健康與休閒學系","東亞語文學系","運動競技學系","建築學系","工藝與創意設計學系",
    "法律學系","政治法律學系","財經法律學系",
    "應用經濟學系","亞太工商管理學系","財務金融學系","資訊管理學系",
    "應用數學系","生命科學系","應用化學系","應用物理學系",
    "電機工程學系","土木與環境工程學系","化學工程及材料工程學系","資訊工程學系"
  ];
  final List<String> grade=["請選擇","一年級","二年級","三年級","四年級","五年級","六年級"];

  Future<void> _register() async {
    StuStruct stu = StuStruct(
      id: _idController.text, 
      passwd: _passwdController.text, 
      name: _nameController.text, 
      email: _emailController.text, 
      sexual: _sexual, 
      phone: _phoneController.text,
      major: _major, 
      grade: _grade
    );

    String? response = await ApiService.register(stu);

    if (response != null) {
      print("註冊成功: $response");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('註冊成功')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登入失敗，請檢查帳號密碼')),
      );
    }
  }

/*  void _updateMajors(String college) {
    setState(() {
      _college = college;
      switch(_college){
        case '人文社會科學院':
          major = humanities;
          break;
        case '法學院':
          major = law;
          break;
        case '管理學院':
          major = management;
          break;
        case '理學院':
          major = science;
          break;
        case '工學院':
          major = engineering;
          break;
        default:
          break;
      }
      _major = major.first; // 重置為第一個選項
    });
  } */

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: SizedBox(
          width: 600,
          child: Form(
            key: _registerfromkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [ 
                    
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: _nameController, // 綁定控制器
                        decoration: const InputDecoration(
                          labelText: '姓名',
                          hintText: '請輸入姓名',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '帳號請勿為空值';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(width: 50),
                    Flexible(
                      flex: 1,
                      child:TextFormField(
                        controller: _idController, // 綁定控制器
                        decoration: const InputDecoration(
                          labelText: '學號',
                          hintText: '請輸入學號',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '帳號請勿為空值';
                          }
                          return null;
                        },
                      )
                    ),
                  ]
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwdController, // 綁定控制器
                  obscureText: true,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: '密碼',
                    hintText: '請輸入密碼',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '密碼請勿為空值';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwdcheckController, // 綁定控制器
                  obscureText: true,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: '再次確認密碼',
                    hintText: '請輸入密碼',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '密碼請勿為空值';
                    }
                    else if(value != _passwdController.text){
                      return '密碼不相同';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController, // 綁定控制器
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: '電子郵件',
                    hintText: '請輸入電子郵件',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '電子郵件請勿為空值';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text("請選擇您的生理性別"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: "1",
                      groupValue: _sexual,
                      onChanged: (value) {
                        setState(() {
                          _sexual = "1";
                        });
                      },
                    ),
                    Text("男"),
                    Radio<String>(
                      value: "2",
                      groupValue: _sexual,
                      onChanged: (value) {
                        setState(() {
                          _sexual = "2";
                        });
                      },
                    ),
                    Text("女"),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController, // 綁定控制器
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: '電話號碼',
                    hintText: '電話號碼',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '電子郵件請勿為空值';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children:[
                    /* Text("院所："),
                    DropdownButton(
                      value: _college,
                      icon: Icon(Icons.keyboard_arrow_down),
                      dropdownColor: Colors.white,
                      onChanged: (String? value) {
                        print(value);
                        if (value != null) {
                          _updateMajors(value); // 更新系別選項
                        }
                      },
                      items: college.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ), */
                    // const Spacer(),
                    Text("系別："),
                    DropdownButton<String>(
                      value: _major,
                      icon: Icon(Icons.keyboard_arrow_down),
                      dropdownColor: Colors.white,
                      onChanged: (String? value) {
                        print(value);
                        setState(() {
                          _major = value!;
                        });
                      },
                      items: major.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                    const Spacer(),
                    Text("年級："),
                    DropdownButton<String>(
                      value: _grade,
                      icon: Icon(Icons.keyboard_arrow_down),
                      dropdownColor: Colors.white,
                      onChanged: (String? value) {
                        print(value);
                        setState(() {
                          _major = value!.trim();
                        });
                      },
                      items: grade.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                    const Spacer()
                ]),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:_register,
                  child: const Text('註冊'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white60,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}