package com.example.demo.controller;
import com.example.demo.dao.TeacherDAO;
import com.example.demo.model.Student;
import com.example.demo.model.Teacher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;


@RestController
@RequestMapping("/api/Tr")
public class TeacherController {
    private TeacherDAO teacherDAO = new TeacherDAO();

    // @PostMapping("/login")
    // public ResponseEntity<String> teacherLogin(@RequestBody Teacher teacher) {
    //     String teacherId = teacher.getTrId();
    //     String teacherPasswd = teacher.getTrPasswd();
        
    //     /*等DAO寫好，會傳前端輸入的老師帳號密碼，後端要驗證對不對 */
    //     // boolean isAuthenticated = teacherDAO.authenticate(teacherId, teacherPasswd);
    //     // if(isAuthenticated) {
    //     //     return ResponseEntity.ok("Login successful");
    //     // }
    //     return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    // }

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

    @GetMapping("{teacheremail}")
    public ResponseEntity<Teacher> getTeamTeacher(@PathVariable String teacheremail) {
        Teacher teacher = teacherDAO.getTeacherByEmail(teacheremail);

        //在資料庫裏面email只存在id欄位，在前端為了方便呼叫會多email欄位
        // Teacher teacher = new Teacher();
        // teacher.setTrId("teacher.gamil");
        // teacher.setTrName("王小明");
        // teacher.setTrEmail("teacher.gamil");
        // teacher.setTrSexual("男");
        // teacher.setTrPhone("0912345678");
        // teacher.setTrJobType("教授");
        // teacher.setTrDepartment("資訊工程學系");
        // teacher.setTrOrganization("國立高雄大學");
        return ResponseEntity.ok(teacher);
    }

    @GetMapping("/detailsData/{id}")
    public ResponseEntity<Teacher> getTeacherDetails(@PathVariable String id) {
        // Teacher teacher = teacherDAO.getTeacherDetails(id);
        Teacher teacher = new Teacher();
        teacher.setTrId("teacher.gamil");
        teacher.setTrName("王小明");
        teacher.setTrEmail("teacher.gamil");
        teacher.setTrSexual("男");
        teacher.setTrPhone("0912345678");
        teacher.setTrJobType("教授");
        teacher.setTrDepartment("資訊工程學系");
        teacher.setTrOrganization("國立高雄大學");
        return ResponseEntity.ok(teacher);
    }

    //更新使用者資料
    @PostMapping("/{id}/update")
    public ResponseEntity<Void> updateTeacher(@PathVariable String id, @RequestBody Teacher teacher) {
        // teamDAO.updateTeam(id, teacher);
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