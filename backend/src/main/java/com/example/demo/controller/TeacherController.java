package com.example.demo.controller;
import com.example.demo.dao.TeacherDAO;
import com.example.demo.model.Teacher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;


@RestController
@RequestMapping("/api/teachers")
public class TeacherController {
    private TeacherDAO teacherDAO = new TeacherDAO();

    @PostMapping("/login")
    public ResponseEntity<String> teacherLogin(@RequestBody Teacher teacher) {
        String teacherId = teacher.getTrId();
        String teacherPasswd = teacher.getTrPasswd();
        
        /*等DAO寫好，會傳前端輸入的老師帳號密碼，後端要驗證對不對 */
        // boolean isAuthenticated = teacherDAO.authenticate(teacherId, teacherPasswd);
        // if(isAuthenticated) {
        //     return ResponseEntity.ok("Login successful");
        // }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    }

    // @PostMapping("/register")
    // public ResponseEntity<String> teacherRegister(@RequestBody Teacher teacher) {
    //     String teacherId = teacher.getTrId();
    //     String teacherPasswd = teacher.getTrPasswd();
    //     String teacherName = teacher.getTrName();
    //     String teacherJobType = teacher.getTrJobType();
    //     String teacherDepartment = teacher.getTrDepartment();
    //     String teacherOrganization = teacher.getTrOrganization();
        
    //     /*等DAO寫好，需要insert teacher的每個attribute */
    //     // boolean isRegistered = teacherDAO.register(teacherId, teacherPasswd, teacherName, teacherJobType, teacherDepartment, teacherOrganization);
    //     // if(isRegistered) {
    //     //     return ResponseEntity.status(HttpStatus.CREATED).body("Register successful");
    //     // }
    //     return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to register");
    // }
}