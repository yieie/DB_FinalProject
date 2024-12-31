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

@RestController
@RequestMapping("/api/Ann")
public class AnnController {
    private final AnnDAO annDAO = new AnnDAO();

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

    @Autowired
    private ObjectMapper objectMapper;
    // @PostMapping(value = "/add", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
    // public ResponseEntity<String> addAnnouncement(
    //         @RequestParam("data") String annJson,
    //         @RequestParam(value = "files", required = false) MultipartFile[] files,
    //         @RequestParam(value = "Images", required = false) MultipartFile[] images) {
    //     try {
    //         System.out.println("Received JSON: " + annJson);
    //         // json 轉 Ann 物件
    //         Ann ann = objectMapper.readValue(annJson, Ann.class);
            
    //         // 處理文件上傳
    //         if (files != null) {
    //             for (MultipartFile file : files) {
    //                 String filePath = annDAO.saveFile(file.getOriginalFilename(), file.getBytes());
    //                 ann.addFile(file.getOriginalFilename(), file.getContentType(), filePath);
    //             }
    //         }

    //         // 處理圖片上傳
    //         if (images != null) {
    //             for (MultipartFile image : images) {
    //                 String imagePath = annDAO.saveFile(image.getOriginalFilename(), image.getBytes());
    //                 ann.addImage(image.getOriginalFilename(), image.getContentType(), imagePath);
    //             }
    //         }

    //         // boolean isAdded = annDAO.addAnnouncement(ann);
    //         boolean isAdded = true; // test
    //         if (isAdded) {
    //             return ResponseEntity.status(HttpStatus.CREATED).body("Announcement added successfully");
    //         } else {
    //             return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to add announcement");
    //         }
    //     } catch (IOException e) {
    //         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error processing request: " + e.getMessage());
    //     }
    // }
    @PostMapping(value = "/add", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
    public ResponseEntity<String> addAnnouncement(
            @RequestParam(value = "annid", required = false) Integer id,
            @RequestParam(value = "anndate", required = false) String date,
            @RequestParam(value = "anntitle") String title,
            @RequestParam(value = "anninfo", required = false) String info,
            @RequestParam(value = "annadmin", required = false) String admin,
            @RequestParam(value = "files", required = false) MultipartFile[] files,
            @RequestParam(value = "Images", required = false) MultipartFile[] images) {
        try {
            // 創建 Announcement 物件
            Ann ann = new Ann();
            ann.setAnnID(id != null ? id : 0); // 若無 id，設置為 0 或自動遞增
            ann.setAnnTime(LocalDateTime.parse(date));
            ann.setAnnTitle(title);
            ann.setAnnInfo(info);
            ann.setAdminID(admin);

            // 處理文件上傳
            if (files != null) {
                for (MultipartFile file : files) {
                    String filePath = annDAO.saveFile(file.getOriginalFilename(), file.getBytes());
                    ann.addFile(file.getOriginalFilename(), file.getContentType(), filePath);
                }
            }

            // 處理圖片上傳
            if (images != null) {
                for (MultipartFile image : images) {
                    String imagePath = annDAO.saveFile(image.getOriginalFilename(), image.getBytes());
                    ann.addImage(image.getOriginalFilename(), image.getContentType(), imagePath);
                }
            }

            // 保存公告到數據庫
            // boolean isAdded = annDAO.addAnnouncement(ann);
            boolean isAdded = true; // test
            if (isAdded) {
                return ResponseEntity.status(HttpStatus.CREATED).body("Announcement added successfully");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to add announcement");
            }
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error processing request: " + e.getMessage());
        }
    }


    // @PostMapping(value = "/edit/{id}", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
    // public ResponseEntity<String> editAnnouncement(
    //         @PathVariable("id") int id,
    //         @RequestParam("data") String annJson,
    //         @RequestParam(value = "files", required = false) MultipartFile[] files,
    //         @RequestParam(value = "Images", required = false) MultipartFile[] images) {
    //     try {
    //         System.out.println("Received JSON: " + annJson);

    //         // Parse JSON to Ann object
    //         Ann ann = objectMapper.readValue(annJson, Ann.class);

    //         ann.setAnnID(id);

    //         // Handle file uploads
    //         if (files != null) {
    //             for (MultipartFile file : files) {
    //                 String filePath = annDAO.saveFile(file.getOriginalFilename(), file.getBytes());
    //                 ann.addFile(file.getOriginalFilename(), file.getContentType(), filePath);
    //             }
    //         }

    //         if (images != null) {
    //             for (MultipartFile image : images) {
    //                 String imagePath = annDAO.saveFile(image.getOriginalFilename(), image.getBytes());
    //                 ann.addImage(image.getOriginalFilename(), image.getContentType(), imagePath);
    //             }
    //         }

    //         // boolean isUpdated = annDAO.updateAnnouncement(ann);
    //         boolean isUpdated = true; // test
    //         if (isUpdated) {
    //             return ResponseEntity.ok("Announcement updated successfully");
    //         } else {
    //             return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to update announcement");
    //         }
    //     } catch (IOException e) {
    //         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error processing request: " + e.getMessage());
    //     }
    // }
    @PostMapping(value = "/edit/{id}", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
    public ResponseEntity<String> editAnnouncement(
            @PathVariable("id") int id,
            @RequestParam(value = "annid", required = false) Integer annId,
            // @RequestParam(value = "anndate", required = false) String date,
            @RequestParam(value = "anntitle") String title,
            @RequestParam(value = "anninfo", required = false) String info,
            @RequestParam(value = "annadmin", required = false) String admin,
            @RequestParam(value = "files", required = false) MultipartFile[] files,
            @RequestParam(value = "Images", required = false) MultipartFile[] images) {
        try {
            // 檢查日期是否為 null
            // LocalDate annDate = (date != null && !date.isEmpty()) ? LocalDate.parse(date) : null;

            // 創建 Ann 物件
            Ann ann = new Ann();
            ann.setAnnID(id); // 使用路徑參數的 id
            // ann.setAnnTime(LocalDateTime.parse(date));
            ann.setAnnTitle(title);
            ann.setAnnInfo(info);
            ann.setAdminID(admin);

            // 處理文件上傳
            if (files != null) {
                for (MultipartFile file : files) {
                    String filePath = annDAO.saveFile(file.getOriginalFilename(), file.getBytes());
                    ann.addFile(file.getOriginalFilename(), file.getContentType(), filePath);
                }
            }

            // 處理圖片上傳
            if (images != null) {
                for (MultipartFile image : images) {
                    String imagePath = annDAO.saveFile(image.getOriginalFilename(), image.getBytes());
                    ann.addImage(image.getOriginalFilename(), image.getContentType(), imagePath);
                }
            }

            // 更新公告到數據庫
            // boolean isUpdated = annDAO.updateAnnouncement(ann);
            boolean isUpdated = true; // test
            if (isUpdated) {
                return ResponseEntity.ok("Announcement updated successfully");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to update announcement");
            }
        } catch (DateTimeParseException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid date format: " + e.getMessage());
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error processing request: " + e.getMessage());
        }
    }

}
