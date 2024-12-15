package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendEmail(String toEmail, String subject, String body) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("test@mail.nuk.edu.tw"); // 發件人郵箱
        message.setTo(toEmail); // 收件人
        message.setSubject(subject); // 郵件主題
        message.setText(body); // 內容

        mailSender.send(message);
        System.out.println("Email sent successfully to " + toEmail);
    }
}
