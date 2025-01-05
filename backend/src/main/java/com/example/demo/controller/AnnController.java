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
import java.util.List;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
// Ann格式: Ann{annID=-1, annTitle='', annInfo='werwer', poster='', fileName='', fileType='null', fileData='', adminID='admin1', annTime=null}
// 資料庫要自己加現在的時間

@RestController
@RequestMapping("/api/Ann")
public class AnnController {
    private final AnnDAO annDAO = new AnnDAO();

    @GetMapping("/list")
    public ResponseEntity<List<Ann>> getBasicAnnouncements() {
        List<Ann> announcements = annDAO.getBasicAnnouncements();
        // Ann ann = new Ann();
        // ann.setAnnID(1);
        // ann.setAnnTitle("testannnnn");
        // ann.setAnnInfo("test");
        // ann.setAdminID("admin1");
        // ann.setAnnTime(LocalDateTime.now());
        // List<Ann> announcements = List.of(ann);

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

    @Autowired
    private ObjectMapper objectMapper;
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
            // 將 RequestParam 組裝為 Ann 物件
            Ann ann = new Ann();
            ann.setAnnID(annId);
            // 資料庫要自己加現在的時間
            ann.setAnnTitle(annTitle);
            ann.setAnnInfo(annInfo);
            ann.setAdminID(annAdmin);
            System.out.println("加"+ann.getAdminID());
            // 處理文件
            if (files != null) {
                for (MultipartFile file : files) {
                    String originalFilename = file.getOriginalFilename(); // 檔案名稱
                    String contentType = file.getContentType(); // 檔案類型
                    ann.setFileName(List.of(originalFilename));
                    ann.setFileType(contentType);
                    String filePath = annDAO.saveFile(file.getOriginalFilename(), file.getBytes());
                    ann.addFile(file.getOriginalFilename(), file.getContentType(), filePath);
                    ann.setFilePath(List.of(filePath));
                    System.out.println(ann.getFilePath());
                }
            }

            // 處理圖片
            if (images != null) {
                for (MultipartFile image : images) {
                    String contentType = image.getContentType(); // 圖片類型 (MIME 類型)
                    ann.setFileType(contentType);
                    String imagePath = annDAO.saveFile(image.getOriginalFilename(), image.getBytes());
                    ann.addImage(image.getOriginalFilename(), image.getContentType(), imagePath);
                    ann.setPosterPath(List.of(imagePath));
                    System.out.println(ann.getPosterPath() + "\n");
                }
            }
            
            System.out.println(ann);


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
            // System.out.println(annId);
            Ann ann = new Ann();
            // 資料庫要自己加現在的時間
            ann.setAnnID(id);
            ann.setAnnTitle(annTitle);
            ann.setAnnInfo(annInfo);
            ann.setAdminID(annAdmin);
            System.out.println("靠"+ann.getAdminID());
            if (files != null) {
                for (MultipartFile file : files) {
                    String originalFilename = file.getOriginalFilename(); // 檔案名稱
                    String contentType = file.getContentType(); // 檔案類型
                    ann.setFileName(List.of(originalFilename));
                    ann.setFileType(contentType);
                    String filePath = annDAO.saveFile(file.getOriginalFilename(), file.getBytes());
                    ann.addFile(file.getOriginalFilename(), file.getContentType(), filePath);
                    ann.setFilePath(List.of(filePath));
                }
            }

            if (images != null) {
                for (MultipartFile image : images) {
                    String contentType = image.getContentType(); // 圖片類型 (MIME 類型)
                    ann.setFileType(contentType);
                    String imagePath = annDAO.saveFile(image.getOriginalFilename(), image.getBytes());
                    ann.addImage(image.getOriginalFilename(), image.getContentType(), imagePath);
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