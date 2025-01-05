package com.example.demo.controller;

import com.example.demo.dao.StudentDAO;
import com.example.demo.model.Student;
import com.example.demo.model.Team;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;


@RestController
@RequestMapping("/api/Stu")
public class StudentController {
    private final StudentDAO studentDAO = new StudentDAO();
    private static final String UPLOAD_DIR = "uploads/";
    
    //拿隊伍隊員的所有資料
    //回傳資料請將代表人(leader)放在首位
    @GetMapping("/{teamid}")
    public ResponseEntity<List<Student>> getTeamStudent(@PathVariable String teamid) {
        List<Student> students = studentDAO.getTeamStudents(teamid);
        // Student student1 = new Student();
        // student1.setStuID("B08901001");
        // student1.setStuName("王小明");
        // student1.setStuEmail("email.com");
        // student1.setStuSex("男");
        // student1.setStuPhone("0912345678");
        // student1.setStuDepartment("資工系");
        // student1.setStuGrade("大三");
        // student1.setStuRole(true);
        // student1.setTeamId("1");
        // student1.setStuIdCard("A123456789");

        // List<Student> students = List.of(student1);
        return ResponseEntity.ok(students);
    }

    @GetMapping("/detailsData/{id}")
    public ResponseEntity<Student> getStudentDetails(@PathVariable String id) {
        // Student student = studentDAO.getStudentDetails(id);
        Student student = new Student();
        // student.setStuID("B08901001");
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
    public ResponseEntity<Void> updateStudent(@PathVariable String id, @RequestBody Map<String, String> data) {
        studentDAO.updateStudent(id, data);
        // 有這些會改
        // 'id':id,
        // 'passwd': passwd,
        // 'name': name,
        // 'email': email,
        // 'sexual': sexual,
        // 'phone': phone
        // System.out.println(data.get("id"));
        // System.out.println(data.get("passwd"));
        // System.out.println(data.get("name"));
        // System.out.println(data.get("email"));
        // System.out.println(data.get("sexual"));
        // System.out.println(data.get("phone"));
        return ResponseEntity.ok().build();
    }

    //拿學生的teamid，如果沒有回傳'無'
    @GetMapping("/{stuid}/teamid")
    public ResponseEntity<String> getStudentTeamId(@PathVariable String stuid) {
        String teamid = studentDAO.getStudentTeamId(stuid);
        // String teamid = "1";
        return ResponseEntity.ok(teamid);
    }

    //拿學生的workid，如果沒有回傳'無'
    @GetMapping("/{stuid}/workid")
    public ResponseEntity<String> getStudentWorkId(@PathVariable String stuid) {
        String workid = studentDAO.getStudentWorkId(stuid);
        // String workid = "1";
        return ResponseEntity.ok(workid);
    }

    @PostMapping("/add")
    public ResponseEntity<Void> addStudent(@RequestBody List<Student> students) {
        //studentDAO.addStudent(students);
        
        for(Student student: students) {
            System.out.println(student.getStuID());
            System.out.println(student.getStuName());
            System.out.println(student.getStuEmail());
            System.out.println(student.getStuSex());
            System.out.println(student.getStuPhone());
            System.out.println(student.getStuDepartment());
            System.out.println(student.getStuGrade());
            System.out.println(student.getStuRole());
        }
        return ResponseEntity.ok().build();
    }

    @PostMapping("/add/idcard")
    public ResponseEntity<String> uploadImage(@RequestParam("Images") MultipartFile image) {
        if (image.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Image file is empty");
        }

        try {
            // Define the directory to save the image
            Path uploadDirectory = Paths.get("uploads/images");

            // Ensure the directory exists
            if (!Files.exists(uploadDirectory)) {
                Files.createDirectories(uploadDirectory);
            }

            // Save the image file
            Path filePath = uploadDirectory.resolve(image.getOriginalFilename());
            Files.write(filePath, image.getBytes());

            return ResponseEntity.ok("Image uploaded successfully: " + filePath.toString());
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred while uploading the image");
        }
    }

    public String saveFile(String fileName, byte[] data) throws IOException {
        if (data == null || fileName == null) {
            return null;
        }
        String relativePath = UPLOAD_DIR + fileName;
        File dir = new File(UPLOAD_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        File file = new File(relativePath);
        try (FileOutputStream fos = new FileOutputStream(file)) {
            fos.write(data);
        }
        return relativePath; // 返回相對路徑
    }
}