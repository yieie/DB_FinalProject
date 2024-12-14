package com.example.demo.controller;

import com.example.demo.dao.StudentDAO;
import com.example.demo.model.Student;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/students")
public class StudentController {
    private final StudentDAO studentDAO = new StudentDAO();
    @PostMapping("/login")
    public ResponseEntity<String> stuLogin(@RequestBody Student stu) {
        String stuId = stu.getStuID();
        String stuPasswd = stu.getStuPasswd();
        
        /*等DAO寫好，需要check student的id和password是否正確 */
        boolean isAuthenticated = studentDAO.authenticate(stuId, stuPasswd);
        if(isAuthenticated) {
            return ResponseEntity.ok("Login successful");
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    }
    
    @PostMapping("/register")
    public ResponseEntity<String> stuRegister(@RequestBody Student stu) {
        String stuId = stu.getStuID();
        String stuPasswd = stu.getStuPasswd();
        String stuName = stu.getStuName();
        String stuSex = stu.getStuSex();
        String stuPhone = stu.getStuPhone();
        String stuEmail = stu.getStuEmail();
        String stuDepartment = stu.getStuDepartment();
        String stuGrade = stu.getStuGrade();
        
        /*等DAO寫好，需要insert student的每個attribute */
        boolean isRegistered = studentDAO.register(stuId, stuPasswd, stuName, stuSex, stuPhone, stuEmail, stuDepartment, stuGrade);
        if(isRegistered) {
            return ResponseEntity.ok("Register successful");
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to register");
    }
        
}
