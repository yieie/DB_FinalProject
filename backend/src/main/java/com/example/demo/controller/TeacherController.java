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

    @PostMapping
    public ResponseEntity<Teacher> createTeacher(@RequestBody Teacher teacher) {
        teacherDAO.addTeacher(teacher);
        return ResponseEntity.status(HttpStatus.CREATED).body(teacher);
    }

    @GetMapping("/{teacherId}")
    public ResponseEntity<Teacher> getTeacherById(@PathVariable String teacherId) {
        Teacher teacher = teacherDAO.getTeacherById(teacherId);
        if (teacher != null) {
            return ResponseEntity.ok(teacher);
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping
    public ResponseEntity<List<Teacher>> getAllTeachers() {
        List<Teacher> teachers = teacherDAO.getAllTeachers();
        return ResponseEntity.ok(teachers);
    }

    @PutMapping("/{teacherId}")
    public ResponseEntity<Teacher> updateTeacher(
        @PathVariable int teacherId, 
        @RequestBody Teacher teacher
    ) {
        teacher.setTeacherId(teacherId);
        teacherDAO.updateTeacher(teacher);
        return ResponseEntity.ok(teacher);
    }

    @DeleteMapping("/{teacherId}")
    public ResponseEntity<Void> deleteTeacher(@PathVariable String teacherId) {
        teacherDAO.deleteTeacher(teacherId);
        return ResponseEntity.noContent().build();
    }
}