package com.example.demo.controller;

import com.example.demo.dao.AnnDAO;
import com.example.demo.model.Ann;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.nio.file.Files;
import java.nio.file.Path;
// Ann格式: Ann{annID=-1, annTitle='', annInfo='werwer', poster='', fileName='', fileType='null', fileData='', adminID='admin1', annTime=null}
// 資料庫要自己加現在的時間

@RestController
@RequestMapping("/api/Ann")
public class AnnController {
    private final AnnDAO annDAO = new AnnDAO();
    private static final String UPLOAD_DIR = "C:/Users/User/DB_FinalProject/DB_FinalProject/backend/src/main/resources/static/images";

    @GetMapping("/list")
    public ResponseEntity<List<Ann>> getBasicAnnouncements() {
        List<Ann> announcements = annDAO.getBasicAnnouncements();
        if (announcements.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(announcements);
    }

    @GetMapping("/details/{id}")
    public ResponseEntity<Ann> getAnnouncementDetails(@PathVariable("id") int id) {
        Ann announcement = annDAO.getAnnById(id);
        if (announcement == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.ok(announcement);
    }

    @PostMapping(value = "/add", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
    public ResponseEntity<String> addAnnouncement(
            @RequestParam("annid") int annId,
            @RequestParam(value = "anndate", required = false) String annDate,
            @RequestParam("anntitle") String annTitle,
            @RequestParam("anninfo") String annInfo,
            @RequestParam("annadmin") String annAdmin,
            @RequestPart(value = "files", required = false) MultipartFile[] files,
            @RequestPart(value = "Images", required = false) MultipartFile[] images) {
        try {
            Ann ann = new Ann();
            ann.setAnnID(annId);
            ann.setAnnTitle(annTitle);
            ann.setAnnInfo(annInfo);
            ann.setAdminID(annAdmin);
            System.out.println(ann.getAdminID() + " " + ann.getAnnID() + " " + ann.getAnnTitle() + " " + ann.getAnnInfo());
            // 處理文件
            // if (files != null) {
            //     for (MultipartFile file : files) {
            //         String originalFilename = file.getOriginalFilename(); // 檔案名稱
            //         String contentType = file.getContentType(); // 檔案類型
            //         ann.setFileName(List.of(originalFilename));
            //         ann.setFileType(contentType);
            //         String filePath = annDAO.saveFile(file.getOriginalFilename(), file.getBytes());
            //         ann.addFile(file.getOriginalFilename(), file.getContentType(), filePath);
            //         ann.setFilePath(List.of(filePath));
            //         System.out.println(ann.getFilePath());
            //     }
            // }

            // 處理圖片
            // 確保 `uploads/` 目錄存在
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            if (images != null) {
                for (MultipartFile image : images) {
                    String filename = System.currentTimeMillis() + "_" + image.getOriginalFilename();
                    Path filePath = uploadPath.resolve(filename);
                    Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                    // 更新資料庫內 `imagePath`
                    String imagePath = filename;
                    ann.setPosterPath(List.of(imagePath));
                }
            }

            boolean isAdded = annDAO.addAnnouncement(ann);
            if (isAdded) {
                return ResponseEntity.status(HttpStatus.CREATED).body("Announcement added successfully");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to add announcement");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error processing request: " + e.getMessage());
        }
    }

    @PostMapping(value = "/edit/{id}", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
    public ResponseEntity<String> editAnnouncement(
            @PathVariable("id") int id,
            @RequestParam(value = "annid") int annId,
            @RequestParam(value = "anndate", required = false) String annDate,
            @RequestParam(value = "anntitle") String annTitle,
            @RequestParam("anninfo") String annInfo,
            @RequestParam("annadmin") String annAdmin,
            @RequestPart(value = "files", required = false) MultipartFile[] files,
            @RequestPart(value = "Images", required = false) MultipartFile[] images) {
        try {
            System.out.println("annAdmin: " + annAdmin);
            Ann ann = new Ann();
            ann.setAnnID(id);
            ann.setAnnTitle(annTitle);
            ann.setAnnInfo(annInfo);
            ann.setAdminID(annAdmin);
            // if (files != null) {
            //     for (MultipartFile file : files) {
            //         String originalFilename = file.getOriginalFilename(); // 檔案名稱
            //         String contentType = file.getContentType(); // 檔案類型
            //         ann.setFileName(List.of(originalFilename));
            //         ann.setFileType(contentType);
            //         String filePath = annDAO.saveFile(file.getOriginalFilename(), file.getBytes());
            //         ann.addFile(file.getOriginalFilename(), file.getContentType(), filePath);
            //         ann.setFilePath(List.of(filePath));
            //     }
            // }
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (images != null) {
                for (MultipartFile image : images) {
                    String filename = System.currentTimeMillis() + "_" + image.getOriginalFilename();
                    Path filePath = uploadPath.resolve(filename);
                    Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                    // 更新資料庫內 `imagePath`
                    String imagePath = filename;
                    ann.setPosterPath(List.of(imagePath));
                }
            }
            
            boolean isUpdated = annDAO.updateAnnouncement(ann);
            
            if (isUpdated) {
                return ResponseEntity.ok("Announcement updated successfully");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to update announcement");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error processing request: " + e.getMessage());
        }
    }
}