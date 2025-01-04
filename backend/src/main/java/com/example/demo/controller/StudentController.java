package com.example.demo.controller;

import com.example.demo.dao.StudentDAO;
import com.example.demo.model.Student;
import com.example.demo.model.Team;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;



@RestController
@RequestMapping("/api/Stu")
public class StudentController {
    private final StudentDAO studentDAO = new StudentDAO();
    // @PostMapping("/login")
    // public ResponseEntity<String> stuLogin(@RequestBody Student stu) {
    //     String stuId = stu.getStuID();
    //     String stuPasswd = stu.getStuPasswd();
        
    //     /*等DAO寫好，需要check student的id和password是否正確 */
    //     boolean isAuthenticated = studentDAO.authenticate(stuId, stuPasswd);
    //     if(isAuthenticated) {
    //         return ResponseEntity.ok("Login successful");
    //     }
    //     return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    // }
    
    // @PostMapping("/register")
    // public ResponseEntity<String> stuRegister(@RequestBody Student stu) {
    //     String stuId = stu.getStuID();
    //     String stuPasswd = stu.getStuPasswd();
    //     String stuName = stu.getStuName();
    //     String stuSex = stu.getStuSex();
    //     String stuPhone = stu.getStuPhone();
    //     String stuEmail = stu.getStuEmail();
    //     String stuDepartment = stu.getStuDepartment();
    //     String stuGrade = stu.getStuGrade();
    //     System.out.println(stu);
    //     /*等DAO寫好，需要insert student的每個attribute */
    //     boolean isRegistered = studentDAO.register(stuId, stuPasswd, stuName, stuSex, stuPhone, stuEmail, stuDepartment, stuGrade);
    //     if(isRegistered) {
    //         return ResponseEntity.ok("Register successful");
    //     }
    //     return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to register");
    // }
    
    //拿隊伍隊員的所有資料
    //回傳資料請將代表人(leader)放在首位
    @GetMapping("/{teamid}")
    public ResponseEntity<List<Student>> getTeamStudent(@PathVariable String teamid) {
        // List<Student> students = studentDAO.getTeamStudents(teamid);
        Student student1 = new Student();
        student1.setStuID("B08901001");
        student1.setStuName("王小明");
        student1.setStuEmail("email.com");
        student1.setStuSex("男");
        student1.setStuPhone("0912345678");
        student1.setStuDepartment("資工系");
        student1.setStuGrade("大三");
        student1.setStuRole(true);
        student1.setTeamId("1");
        student1.setStuIdCard("A123456789");

        List<Student> students = List.of(student1);
        return ResponseEntity.ok(students);
    }

    @GetMapping("/detailsData/{id}")
    public ResponseEntity<Student> getStudentDetails(@PathVariable String id) {
        // Student student = studentDAO.getStudentDetails(stu, id);
        Student student = new Student();
        student.setStuID("B08901001");
        student.setStuName("王小明");
        student.setStuEmail("email.com");
        student.setStuSex("男");
        student.setStuPhone("0912345678");
        student.setStuDepartment("資工系");
        student.setStuGrade("大三");
        student.setStuRole(true);
        student.setTeamId("1");
        student.setStuIdCard("A123456789");
        return ResponseEntity.ok(student);
    }
    
    //更新使用者資料
    @PostMapping("/{id}/update")
    public ResponseEntity<Void> updateStudent(@PathVariable String id, @RequestBody Student student) {
        // teamDAO.updateTeam(id, student);
        // 有這些會改
        // 'id':id,
        // 'passwd': passwd,
        // 'name': name,
        // 'email': email,
        // 'sexual': sexual,
        // 'phone': phone
        return ResponseEntity.ok().build();
    }
}
