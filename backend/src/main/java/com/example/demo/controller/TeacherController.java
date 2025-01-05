package com.example.demo.controller;
import com.example.demo.dao.TeacherDAO;
import com.example.demo.model.Student;
import com.example.demo.model.Teacher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/api/Tr")
public class TeacherController {
    private TeacherDAO teacherDAO = new TeacherDAO();

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
    public ResponseEntity<Void> updateTeacher(@PathVariable String id, @RequestBody Map<String, String> data) {
        // teamDAO.updateTeam(id, teacher);
        // 有這些會改
        // 'id':id,
        // 'passwd': passwd,
        // 'name': name,
        // 'email': email,
        // 'sexual': sexual,
        // 'phone': phone
        System.out.println(data.get("id"));
        System.out.println(data.get("passwd"));
        System.out.println(data.get("name"));
        System.out.println(data.get("email"));
        System.out.println(data.get("sexual"));
        System.out.println(data.get("phone"));
        return ResponseEntity.ok().build();
    }

    @PostMapping("/add")
    public ResponseEntity<Boolean> addTeacher(@RequestBody Teacher teacher) {
        // 前端會送tr資料庫裡的每個東西
        // boolean isAdded = teacherDAO.addTeacher(teacher);
        boolean isAdded = true;

        if (isAdded) {
            return ResponseEntity.status(HttpStatus.CREATED).body(true); // 成功回傳 true
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(false); // 失敗回傳 false
        }
    }
}